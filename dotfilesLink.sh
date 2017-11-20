#! /bin/bash
ln -s ~/dotfiles/.vimrc ~/.vimrc
if [ -f ~/.config/nvim/init.vim ]; then
  mkdir -p ~/.config/nvim
  ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
fi
if [ -f ~/.vim/rc/ ]; then
  mkdir -p ~/.vim/rc/
  ln -s ~/dotfiles/dein.toml ~/.vim/rc/dein.toml
  ln -s ~/dotfiles/lazy_dein.toml ~/.vim/rc/lazy_dein.toml
fi
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.latexmkrc ~/.latexmkrc
ln -s ~/dotfiles/.iex.exs ~/.iex.exs
