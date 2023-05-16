#!/bin/sh

rpm-ostree install ranger

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# backup any old config files
rm -rf ~/.vimrc.old
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.old

rm -rf ~/.bashrc.old
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old

rm -rf ~/.tmux.conf.old
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.old

# install Vundle
[ -d ~/.vim ] || mkdir ~/.vim
[ -d ~/.vim/bundle/Vundle.vim ] || \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link my base config
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.tmux_line.conf ~/.tmux_line.conf
ln -s $DIR/.tmux.conf ~/.tmux.conf
ln -s $DIR/.bashrc ~/.bashrc

# install plugins with Vundle
vim +PluginInstall +qall

git config --global gitreview.username josecastillolema
git config --global user.name "Jose Castillo Lema"
git config --global user.email "josecastillolema@gmail.com"
git config --global core.editor vim