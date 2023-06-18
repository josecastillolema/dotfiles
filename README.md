# dotfiles

My Linux desktop setup on [Fedora Sericea](https://fedoraproject.org/sericea/).

![](https://raw.githubusercontent.com/josecastillolema/dotfiles/master/img/screenshot.png)

## Desktop

 - Window manager: Sway via baseOS

   Only use wayland applications; xwayland apps are not properly scaled [swaywm/sway#2966](https://github.com/swaywm/sway/issues/2966), drag and drop does not work [swaywm/sway#6460](https://github.com/swaywm/sway/issues/6460) and have a glitched behaviour uppon minimized on system tray [swaywm/sway#6905](https://github.com/swaywm/sway/issues/6905).

 - Display setup: wdisplays via rpm-ostree

 - Browser
     - Primary: Firefox via baseOS
     - Secondary: Chrome via [Flatpak](https://flathub.org/apps/com.google.Chrome)

       With flags `--ozone-platform-hint=wayland` and `--enable-pixel-canvas-recording=enabled`.

 - Terminal: GNOME Terminal via rpm-ostree

   I prefer Foot but having a grabbable scrollbar is a must for now. One workaround would be to setup fast scroll (i.e.: *$mod + scroll wheel*) but I have not been able to configure it correctly (if anyone has please let me know [&#8629;](#issues)).

 - IDE: Visual Studio Code via [Flatpak](https://flathub.org/apps/com.visualstudio.code)

   With flags `--socket=wayland` and `--ozone-platform-hint=wayland`.

 - File manager: Nautilus via rpm-ostree

   I prefer Thunar but I miss the preview (GNOME Sushi) feature.

 - PDF reader: Zathura via rpm-ostree

 - Image viewer: imv via baseOS

 - Video player
   - Primary: mpv via [Flatpak](https://flathub.org/apps/io.mpv.Mpv) using the flathub repo
   - Secondary: VLC via [Flatpak](https://flathub.org/apps/org.videolan.VLC)

 - Torrent client: Transmission via [Flatpak](https://flathub.org/apps/com.transmissionbt.Transmission)

 - WhatsApp client: WhatsApp for Linux via [Flatpak](https://flathub.org/apps/com.github.eneshecan.WhatsAppForLinux)
   
   Supports wayland. 


## Tools
 
 - Shell: bash via baseOS
 - Terminal multiplexer: tmux via rpm-ostree
 - Configuration management: Ansible via toolbx
 - Text editor: vim via rpm-ostree
 - Prompt: Starship via local install
 - Containers: Podman and Toolbx via base OS, Docker in rootless mode via local install
 - Kubernetes: Kind and kube-burner via local install
 - Application management: rpm-ostree and Flatpak via baseOS
 - Keyboard input: wtype via rpm-ostree


## Issues

If you have managed to get working any of the following please let me know:
 - Sway
   - Share a specific window on Google Meet [swaywm/sway#3282](https://github.com/swaywm/sway/issues/3282)
   - <s>Drag & Drop from XWayland apps to Wayland ones: it only works occasionally [swaywm/sway#6460](https://github.com/swaywm/sway/issues/6460)</s>
   - <s>XWayland windows gets tiled uppong being reopened from system tray [swaywm/sway#6905](https://github.com/swaywm/sway/issues/6905)</s>
   - <s>Prime Video does not work (neither Chrome nor Firefox) https://www.primevideo.com/region/na/help?nodeId=GU85HKX66NVFNQ9Y</s>
   - Small/giant mouse cursor on Visual Studio Code [microsoft/vscode#136390](https://github.com/microsoft/vscode/issues/136390)
   - Fast scroll using *$mod + ScrollWheel*. Tried with:
      ```
      bindsym --whole-window $mod+button4 exec "wtype -M shift -k Prior"
      bindsym --whole-window $mod+button5 exec "wtype -M shift -k Next"
      ```
       - Problem 1: Only works the first wheel turn, then need to relase and press again *$mod*
       - Problem 2: Different apps use different combinaitons, i.e.: just *ScrollWheel* or *Shift+ScrollWheel*
 - Starship
   - Conditional styling for Toolbx symbol [starship/starship#2724](https://github.com/starship/starship/issues/2724)

## TODO
 - Setup hibernation
    - https://discussion.fedoraproject.org/t/setup-hibernation-on-silverblue-kionite/78834
    - https://bbs.archlinux.org/viewtopic.php?id=259382
