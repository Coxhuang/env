#!/usr/bin/env bash

git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/wting/autojump.git ~/.oh-my-zsh/custom/plugins/autojump
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

cd ~/.oh-my-zsh/custom/plugins/autojump && python3 install.py
