#! /bin/bash
# Install the necessary files

# First lets symlink the zshrc
ln -sfv ~/.dotfiles/zshrc ~/.zshrc

# Next lets symlink the bash_profile
ln -sfv ~/.dotfiles/bash_profile ~/.bash_profile

# Next lets symlink the custom theme
ln -sfv ~/.dotfiles/omz-themes/babun.zsh-theme ~/.oh-my-zsh/themes/babun.zsh-theme

# Then lets do the gitconfig
ln -sfv ~/.dotfiles/git/gitconfig ~/.gitconfig

# Then lets do the sshrc
ln -sfv ~/.dotfiles/sshrc ~/.ssh/rc

# Install the rclone config
mkdir -p ~/.config/rclone
ln -sfv ~/.dotfiles/rclone/rclone.conf ~/.config/rclone/rclone.conf

# Install our inputrc to ensure CTRL+L and other shortcuts continue to work
ln -sfv ~/.dotfiles/inputrc ~/.inputrc

# Then lets do the wezterm config
ln -sfv ~/.dotfiles/wezterm.lua ~/.wezterm.lua

# Then lets symlink the tmux config
ln -sfv ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Finally lets symlink the tmux local config
ln -sfv ~/.dotfiles/tmux.conf.local ~/.tmux.conf.local
