##### Restore dotfiles and config files
# Restores the dotfiles that are kept in $REPO/dofiles to the newly created user folder
##### END Restore dotfiles

# find if userhome/.config exists, if not make it
if ! [ -d $HOME/.config/bspwm ]
then
	mkdir -p $HOME/.config/bspwm
fi

# Install all dotfiles for system
ln -sf ./bashrc $HOME/.bashrc
ln -sf ./bspwmrc $HOME/.config/bspwm/bspwmrc
ln -sf ./sxhkdrc $HOME/.config/bspwm/sxhkdrc
