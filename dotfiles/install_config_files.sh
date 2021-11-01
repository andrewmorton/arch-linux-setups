#!/bin/bash

##### Restore dotfiles and config files
# Restores the dotfiles that are kept in $REPO/dofiles to the newly created user folder

#### Globals

target_config_dirs=(
	bspwm 
	sxhkd 
	nvim
	wired
	polybar
	cairo-dock
)

this_dir=$(pwd)

#### END Globals

#### Functions

function linkConfigFileWithDir() {
  CURRENT=$(pwd)
  LOCATION="$1"
  FILE="$2"

  echo "Linking ${FILE} with ${LOCATION}/${FILE}"

  ln -sf "${CURRENT}/${FILE}" "${LOCATION}/${FILE}"

}

function makeConfigDirWithParents() {
	TARGET="$1"

	if ! [[ -d $HOME/.config/$TARGET ]]; then
		mkdir -p "${HOME}/.config/${TARGET}"
	fi
}

function createConfigDirsFromArray() {
  ARRAY=("${1[@]}")

  for dir in "${ARRAY[@]}"; do
    makeConfigDirWithParents "$dir"
  done

}




#### END Functions

# Create Pictures if not exists
if ! [[ -d $HOME/Pictures ]]; then
	mkdir -p "$HOME/Pictures"
fi

# Create all dirs from given list

createConfigDirsFromArray "${target_config_dirs[@]}"


# Install all dotfiles for system


# Link Bashrc

ln -sf "$this_dir/bashrc" "$HOME/.bashrc"
ln -sf "$this_dir/bspwmrc" "$HOME/.config/bspwm/bspwmrc"
ln -sf "$this_dir/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"
ln -sf "$this_dir/init.vim" "$HOME/.config/nvim/init.vim"
ln -sf "$this_dir/wired.ron" "$HOME/.config/wired/wired.ron"
# Commenting emacs for now. Might not be using it anymore
# cp $this_dir/emacs/emacs.el $HOME/.emacs.d/init.el # Just copy emacs config because it will be replaced
ln -sf "$this_dir/xbindkeysrc" "$HOME/.xbindkeysrc"

# Install polybar launch script and config
ln -sf "$this_dir/polybar_launch.sh" "$HOME/.config/polybar/launch.sh"
ln -sf "$this_dir/polybar_config" "$HOME/.config/polybar/config"

# Make sym link to git pictures folder
ln -sf "$this_dir/bg" "$HOME/Pictures/bg"

# Install cairo-dock launcher

ln -sf "$this_dir/cairo_launch.sh" "$HOME/.config/cairo-dock/cairo_launch.sh"

##### END Restore dotfiles
