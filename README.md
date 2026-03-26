
# Git

configure git and generate an ssh key:

```shell
git config --global user.name "linux"
git config --global user.email kaxiford@gmail.com
git config --global core.editor "nvim"
git config --global init.defaultBranch main
ssh-keygen -t ed25519 -C "kaxiford@gmail.com"

# add to github
```
