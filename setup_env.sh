#!/bin/bash

# Setup some common tools that I use
echo "Updating Ubuntu and putting some tools on here."
sudo apt -q update
sudo apt install --assume-yes \
	curl \
	git \
	lm-sensors \
	python-pip \
	python-setuptools \
	python3-pip \
	python3-tk \
	tmux \
	tree \
	vim \
	virtualenv

# Setup the ~/.vimrc file
echo "Copying ~/.vimrc"
if [ -a ~/.vimrc ]; then
	echo " - Backing up ~/.vimrc"
	cp ~/.vimrc{,.bak."$(date +%Y%m%d%H%M%S)"}
fi
cp ./vimrc ~/.vimrc

# Setup the ~/.tmux.conf file
if [ -a ~/.tmux.conf ]; then
	echo " -Backing up ~/.tmux.conf"
	cp ~/.tmux.conf{,.bak."$(date +%Y%m%d%H%M%S)"}
fi
cp ./tmux.conf ~/.tmux.conf

# Setup the python.vim file and directory
echo "Copying python.vim"
if [ ! -d ~/.vim/ftplugin ]; then 
	mkdir -p ~/.vim/ftplugin
	cp ./vim/ftplugin/python.vim ~/.vim/ftplugin/
else
	if [ -a ~/.vim/ftplugin/python.vim ]; then
		cp ~/.vim/ftplugin/python.vim{,.bak."$(date +%Y%m%d%H%M%S)"}
	fi
	cp ./vim/ftplugin/python.vim ~/.vim/ftplugin/
fi

# Ensure that git is installed
echo "Checking for git"
if [ -x /usr/bin/git ]; then
	echo " - git is installed"
else
	echo " - git is not installed. Installing now."
	sudo apt -q update && sudo apt --assume-yes install git
fi

# Configuring Git
if [ -x "$(command -v git)" ]; then
	git config --global user.name "Matthew J. Geiger"
	git config --global user.email "matthew.j.geiger@gmail.com"
	git config --global color.ui true
	git config --global merge.ff false
	git config --global core.editor "vim"
else
	echo " - Difficulty trying to find git. Could not configure."
fi

# Install Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# Install the Vundle vim plugin
echo "Getting Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim &>/dev/null
