# dotfiles

My Linux desktop setup on [Fedora Sericea](https://fedoraproject.org/sericea/).

![FIAP MBA](https://raw.githubusercontent.com/josecastillolema/dotfiles/master/img/screenshot.png)]

## Desktop

 - Window manager: Sway

 - Display setup: wdisplays

 - Browser: Chrome

 - Terminal: GNOME Terminal

    I would consider Foot but having a grabbable scrollbar is a must for now. One workaround would be to setup fast scroll (i.e.: *$mod + scroll wheel*) but I have not been able to configure it correctly (if anyone has please let me know).

 - IDE: Visual Studio Code

 - File manager: Nautilus

    I would consider Thunar but I miss the preview (GNOME Sushi) feature.

 - PDF reader: Zathura

 - Image viewer: imv

 - Video player: VLC


## Tools
 
 - Terminal multiplexer: tmux
 - Configuration management: Ansible
 - Text editor: vim
 - Prompt: Starship
 - Containers: Podman, Docker in rootless mode, Toolbx
 - Flatpak
 - Keyboard input: wtype


## Things I did not get right

Please if you have managed any of those let me know:
 - Sway
   - Share one specific window on Google Meet [swaywm/sway#3282](https://github.com/swaywm/sway/issues/3282)
   - Drag & Drop: it only works at random times [swaywm/sway#6460](https://github.com/swaywm/sway/issues/6460)
   - Fast scroll using *$mod + scroll wheel*
   - WhatsApp window gets tiled uppong being reopened from system tray [swaywm/sway#6905](https://github.com/swaywm/sway/issues/6905)

## TODO
 - Setup hibernation
    - https://discussion.fedoraproject.org/t/setup-hibernation-on-silverblue-kionite/78834
    - https://bbs.archlinux.org/viewtopic.php?id=259382