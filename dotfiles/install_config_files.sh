##### Restore dotfiles and config files
# Restores the dotfiles that are kept in $REPO/dofiles to the newly created user folder
##### END Restore dotfiles

this_dir=$(pwd)

# find if userhome/.config exists, if not make it
if ! [ -d $HOME/.config/bspwm ] || ! [ -d $HOME/.config/sxhkd ]
then
	mkdir -p $HOME/.config/bspwm
	mkdir -p $HOME/.config/sxhkd
	mkdir -p $HOME/.config/nvim
	mkdir -p $HOME/Pictures
fi

# Install all dotfiles for system
ln -sf $this_dir/bashrc $HOME/.bashrc
ln -sf $this_dir/bspwmrc $HOME/.config/bspwm/bspwmrc
ln -sf $this_dir/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
ln -sf $this_dir/init.vim $HOME/.config/nvim/init.vim

# Make sym link to git pictures folder
ln -sf -t $this_dir/bg $HOME/Pictures/bg
