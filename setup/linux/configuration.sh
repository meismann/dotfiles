# Fixes errors with my git aliasing during completions that occur because the `git` command is not present but expected
echo "__git_cmd_idx=1" >> /usr/share/bash-completion/completions/git

# Sets proper editor for visudo
sudo update-alternatives --config editor
