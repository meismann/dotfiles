PRIVATE_KEY_FILE=$HOME/.ssh/id_rsa
PUBLIC_KEY_FILE=$PRIVATE_KEY_FILE.pub

copy_key_file_to_clipboard() {
  if [[ -x $(which pbcopy) ]]; then
    pbcopy < $PUBLIC_KEY_FILE
    return 0
  fi

  if [[ -x $(which xclip) ]]; then
    xclip -i -selection 'clipboard' < $PUBLIC_KEY_FILE
    return 0
  fi

  echo "Copying $PUBLIC_KEY_FILE to the clipboard failed."
  return 1
}

mkdir -p $HOME/.ssh

if [[ ! -e $PRIVATE_KEY_FILE ]]; then
  ssh-keygen -f $PRIVATE_KEY_FILE -t rsa -b 4096 -C 'Martin Eismann, Softwerk' -P ''
  ssh-add $PRIVATE_KEY_FILE

  copy_key_file_to_clipboard \
    && read -p 'Use the key on the clipboard to create a new key in Github, then press Enter' -n 1 -s \
    || read -p "Create a new key in Github using the content of $PUBLIC_KEY_FILE." -n 1 -s
else
  ssh-add $PRIVATE_KEY_FILE
  echo "The SSH key file $PUBLIC_KEY_FILE exists. Does Github know about it?" \
    && copy_key_file_to_clipboard && echo 'Anyway, its content is on the clipboard now.' \
    && read -p 'Press ENTER when the key is in Github' -n 1 -s
fi

echo # need a linebreak here
