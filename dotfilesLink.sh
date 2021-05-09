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

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.latexmkrc ~/.latexmkrc
ln -s ~/dotfiles/.iex.exs ~/.iex.exs
