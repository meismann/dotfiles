#!/bin/bash

create_backup(){
  file_name=$1
  if [[ -e $file_name && ! -L $file_name ]]
  then
    echo "Creating backup for $file_name ($file_name.bkp)"
    mv $file_name $file_name.bkp
  else
    return 1
  fi
}

remove_symlink() {
  file_name=$1
  if [[ -L $file_name ]]
  then
    echo "Removing symlink $file_name (pointing to $(readlink $file_name))"
    rm -fr $file_name
  fi
}

prepare_setup_of() {
  file_name=$1
  create_backup $file_name || remove_symlink $file_name
}

repo_dir=`pwd`

cd

# Link whatever needs to go right into ~
linkable_files=( .bash_profile .bash_aliases .gitexcludes .vim .vimrc bin dotfiles_linux_additions dotfiles_mac_additions .gitconfig )
for i in "${linkable_files[@]}"
do
  prepare_setup_of $i
  echo "Creating symlink $i"
  ln -s $repo_dir/${i#.} $i
done

