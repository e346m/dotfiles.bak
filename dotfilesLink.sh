#! /bin/bash
if [[ ! -d ~/.config/nvim ]]; then
  mkdir -p ~/.config/nvim
  ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
fi

if [[ ! -d ~/.vim/rc/ ]]; then
  mkdir -p ~/.vim/rc/
  ln -s ~/dotfiles/dein.toml ~/.vim/rc/dein.toml
  ln -s ~/dotfiles/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
fi

if [[ ! -d ~/.config/alacritty ]]; then
  mkdir -p ~/.config/alacritty
  ln -s ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
fi

if [[ ! -d ~/.config/vale ]]; then
  mkdir -p ~/.config/vale
  cd ~/dotfiles/vale/styles
  curl  -sL -o - https://github.com/errata-ai/Microsoft/releases/download/v0.8.1/Microsoft.zip | jar -xvf /dev/stdin

  ln -s ~/dotfiles/vale/vale.ini ~/.vale.ini
  # vim ale plugin cannort accept --config flag
  # ln -s ~/dotfiles/vale/vale.ini ~/.config/vale/vale.ini
  ln -s ~/dotfiles/vale/styles ~/.config/vale/styles
fi

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.latexmkrc ~/.latexmkrc
ln -s ~/dotfiles/.iex.exs ~/.iex.exs
