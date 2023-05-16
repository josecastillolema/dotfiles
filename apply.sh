#!/bin/sh

# rpm-ostree
rpm-ostree install ranger

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.google.Chrome

# gsettings
gsettings set org.gnome.desktop.interface scaling-factor 1.5

# backup any old config files
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.old
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.old
[ -f ~/.config/sway/config ] && mv ~/.config/sway/config ~/.config/sway/config.old

# install Vundle
[ -d ~/.vim ] || mkdir ~/.vim
[ -d ~/.vim/bundle/Vundle.vim ] || \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link my base config
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.tmux_line.conf ~/.tmux_line.conf
ln -s $DIR/.tmux.conf ~/.tmux.conf
ln -s $DIR/.bashrc ~/.bashrc

# install plugins with Vundle
vim +PluginInstall +qall

# git
git config --global gitreview.username josecastillolema
git config --global user.name "Jose Castillo Lema"
git config --global user.email "josecastillolema@gmail.com"
git config --global core.editor vim
