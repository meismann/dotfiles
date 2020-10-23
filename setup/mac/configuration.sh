repo_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && git rev-parse --show-toplevel )

echo 'Installing Ubuntu fonts …' \
  && cp $repo_dir/fonts/Ubuntu/* ~/Library/Fonts \
  && echo '… done installing Ubuntu fonts.'

# Taken from https://github.com/lysyi3m/macos-terminal-themes/
open $repo_dir/Ubuntu.terminal
