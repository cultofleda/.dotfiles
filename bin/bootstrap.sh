# /bin/bash

# TODO This needs lots of work
export UNAME_OUT="$(uname -s)"

case $UNAME_OUT in
Linux*) machine=Linux ;;
Darwin*) machine=Mac ;;
CYGWIN*) machine=Cygwin ;;
MINGW*) machine=MinGw ;;
*) machine="UNKNOWN:${UNAME_OUT}" ;;
esac

export DOTFILES_DIR=$HOME/.dotfiles
export XDG_CONFIG_HOME=$HOME/.config

# Just linux
if [ ${machine} == "Linux" ]; then
	ln -s $DOTFILES_DIR/i3 $XDG_CONFIG_HOME
	ln -s $DOTFILES_DIR/picom $XDG_CONFIG_HOME
	ln -s $DOTFILES_DIR/polybar $XDG_CONFIG_HOME
fi

# Multiplatform (mostly rust based things lol)
ln -s $DOTFILES_DIR/nvim $XDG_CONFIG_HOME
ln -s $DOTFILES_DIR/zellij $XDG_CONFIG_HOME
ln -s $DOTFILES_DIR/kitty $XDG_CONFIG_HOME

# zsh deserves special treatment I guess
ln -s $DOTFILES_DIR/zsh/.zshrc $HOME/.zshrc
