# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
TZ='Europe/Madrid'; export TZ

if [ ! -f /run/.toolboxenv ]; then
	rclone mount gdrive: ~/gdrive/ &
	rclone sync dropbox: ~/dropbox/ &
fi
