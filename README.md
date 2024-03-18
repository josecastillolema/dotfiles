# dotfiles

My Linux desktop setup on [Fedora Sway Atomic](https://fedoraproject.org/atomic-desktops/sway/), previously known as Sericea.

![](https://raw.githubusercontent.com/josecastillolema/dotfiles/master/img/screenshot.png)

## Desktop

 - Window manager: Sway via baseOS

   Only use wayland applications; xwayland apps are not properly scaled [swaywm/sway#2966](https://github.com/swaywm/sway/issues/2966), drag and drop does not work [swaywm/sway#6460](https://github.com/swaywm/sway/issues/6460) and have a glitched behaviour uppon minimized on system tray [swaywm/sway#6905](https://github.com/swaywm/sway/issues/6905).

 - Browser
     - Primary: Firefox via [Flatpak](https://flathub.org/apps/org.mozilla.firefox)
     - Secondary: Chrome via [Flatpak](https://flathub.org/apps/com.google.Chrome)

       With flags `--ozone-platform-hint=wayland` and `--enable-pixel-canvas-recording=enabled`.

  - Terminal: [WezTerm](https://wezfurlong.org/wezterm/) via [Flatpak](https://flathub.org/apps/org.wezfurlong.wezterm)

    Amazing terminal with wayland, grabbable scrollbar and ligature support.

    Would prefer Foot but having a grabbable scrollbar is a must for now. One workaround would be to setup fast scroll (i.e.: *$mod + scroll wheel*) but I have not been able to configure it correctly (if anyone has please let me know [&#8629;](#issues)). Also Foot does not support ligatures [dnkl/foot#57](https://codeberg.org/dnkl/foot/issues/57).

  - IDE:
     - Primary: Visual Studio Code via [Flatpak](https://flathub.org/apps/com.visualstudio.code)

       With flags `--socket=wayland` and `--ozone-platform-hint=wayland`.

       With [JetBrains Mono font](https://github.com/JetBrains/JetBrainsMono) with programming ligatures installed via rpm-ostree.

       Instead of using SDK extensions [tend to opt for local language installs (golang, ocaml, etc.)](https://josecastillolema.github.io/dev-inmutable-distros/).

       [toolbox-vscode](https://github.com/owtaylor/toolbox-vscode) to integrate VSCode and toolbx.

     - Secundary: Neovim via [Flatpak](https://flathub.org/es/apps/io.neovim.nvim)

 - Messaging application: Ferdium via [Flatpak](https://flathub.org/apps/org.ferdium.Ferdium)

   Use it as client for Gmail, Outlook, Slack, Google Chat, WhatsApp, iCloud, Discord, ChatGPT and Bard.

 - File manager: Nautilus via rpm-ostree with NautilusPreviewer (GNOME Sushi) via Flatpak (org.gnome.NautilusPreviewer)

   Would prefer Thunar or PCMan FM but miss the preview feature.

 - Text editor: Gnome Text Editor via [Flatpak](https://flathub.org/apps/org.gnome.TextEditor)

 - PDF reader: Evince (GNOME Document Viewer) via [Flatpak](https://flathub.org/apps/org.gnome.Evince)

 - Image viewer: imv via baseOS

 - PDF editing: Xournal++ via [Flatpak](https://flathub.org/apps/com.github.xournalpp.xournalpp)

 - Basic photo editing: Drawing via [Flatpak](https://flathub.org/apps/com.github.maoschanz.drawing)

 - Video player: mpv via [Flatpak](https://flathub.org/apps/io.mpv.Mpv) using the flathub repo

 - Torrent client: Transmission via [Flatpak](https://flathub.org/apps/com.transmissionbt.Transmission)

 - File sync
     - Dropbox via [Flatpak](https://flathub.org/apps/com.dropbox.Client)
     - Gdrive with rclone via rpm-ostree

 - Office suite: LibreOffice via [Flatpak](https://flathub.org/apps/org.libreoffice.LibreOffice)

 - Display setup: wdisplays via rpm-ostree

## Tools

 - Shell: bash via baseOS
 - Prompt: Starship via local install
 - Text editor: neovim via [Flatpak](https://flathub.org/es/apps/io.neovim.nvim)
 - Application management: rpm-ostree and Flatpak via baseOS
 - Terminal multiplexer: tmux in remote systems
 - Configuration management: Ansible via [toolbx](https://github.com/josecastillolema/toolbox-images/blob/main/fedora-toolbox-38/Containerfile#L16)
 - Containers: Podman and Toolbx via base OS, Docker in rootless mode via local install
   - [Toolbx images](https://github.com/josecastillolema/toolbox-images)
 - Virtualization: [kcli](https://kcli.readthedocs.io/en/latest/) via [toolbx](https://github.com/josecastillolema/toolbox-images/blob/main/fedora-toolbox-38/Containerfile#L19-L21)
   - [Kcli plans](https://github.com/josecastillolema/kcli-plans)
 - Kubernetes: Kind and kube-burner via local install
 - Keyboard input: wtype via rpm-ostree


## Tricks

 - For [ovn-kubernetes](https://github.com/ovn-org/ovn-kubernetes/):
    ```
    $ sudo modprobe openvswitch
    ```

 - For [KubeVirt](https://kubevirt.io/):
   - Create the kind cluster as root
   - The following command will allow the installation of KubeVirt in a rootless cluster but then the VMs won't be created because rootless docker/podman are unable to create pods in kind with ephemeral storage requests [kubernetes-sigs/kind#3359](https://github.com/kubernetes-sigs/kind/issues/3359):
      ```
      $ sudo chown $USER /dev/kvm
      ```

 - For [web-burner](https://github.com/redhat-performance/web-burner):
    ```
    $ sudo sysctl -w kernel.keys.maxkeys=5000
    ```

 - Create a kind cluster using rootless podman as provider without the need of setting systemd property `Delegate=yes` (see [https://kind.sigs.k8s.io/docs/user/rootless/](https://kind.sigs.k8s.io/docs/user/rootless/)):
    ```
    KIND_EXPERIMENTAL_PROVIDER=podman systemd-run --scope --user ~/go/bin/kind create cluster
    ```


## Issues

If you have managed to get working any of the following please let me know:
 - Docker/Podman in rootless mode
   - Unable to create pods in kind with ephemeral storage requests [kubernetes-sigs/kind#3359](https://github.com/kubernetes-sigs/kind/issues/3359)
 - Emacs Flatpak
   - ^G detaches text-mode emacs from terminal [flathub/org.gnu.emacs#6](https://github.com/flathub/org.gnu.emacs/issues/6)
   - Pure-GTK (wayland) support [flathub/org.gnu.emacs#58](https://github.com/flathub/org.gnu.emacs/issues/58)
 - Ferdium
   - <s>Allow setting default zoom level per service [ferdium/ferdium-app#1556](https://github.com/ferdium/ferdium-app/issues/1556)</s>
   - Credentials autocomplete [ferdium/ferdium-app#1425](https://github.com/ferdium/ferdium-app/issues/1425)
   - Feature: Ability to add Chrome extensions like password managers [ferdium/ferdium-app#135](https://github.com/ferdium/ferdium-app/issues/135)
   - Unable to print from Gmail view [ferdium/ferdium-app#1573](https://github.com/ferdium/ferdium-app/issues/1573)
   - <s>Stuck in purple screen in Linux with Wayland [ferdium/ferdium-app#1551](https://github.com/ferdium/ferdium-app/issues/1551)</s>
   - <s>Zoom resets after service change [ferdium/ferdium-app#1419](https://github.com/ferdium/ferdium-app/issues/1419)</s>
 - Firefox
   - Slack huddles are not available [webcompat/web-bugs#82623](https://github.com/webcompat/web-bugs/issues/82623)
   - <s>Prime Video does not work (neither Chrome nor Firefox) https://www.primevideo.com/region/na/help?nodeId=GU85HKX66NVFNQ9Y</s>
 - GNOME
   - gvfsd-recent preventing system suspension [GNOME/gvfs#715](https://gitlab.gnome.org/GNOME/gvfs/-/issues/715)
 - Nautilus
   - Extract files to current folder [r/gnome/112a3jq](https://www.reddit.com/r/gnome/comments/112a3jq/extract_files_to_current_folder/)
   - Nautilus on Flathub [GNOME/nautilus#946](https://gitlab.gnome.org/GNOME/nautilus/-/issues/946)
 - Starship
   - Conditional styling for Toolbx symbol [starship/starship#2724](https://github.com/starship/starship/issues/2724)
 - Sway
   - <s>Drag & Drop from XWayland apps to Wayland ones: it only works occasionally [swaywm/sway#6460](https://github.com/swaywm/sway/issues/6460)</s>
   - <s>Differentiate between *app_ids* that start the same [swaywm/sway#7838](https://github.com/swaywm/sway/issues/7838)</s>
   - Fast scroll using *$mod + ScrollWheel*. Tried with:
      ```
      bindsym --whole-window $mod+button4 exec "wtype -M shift -k Prior"
      bindsym --whole-window $mod+button5 exec "wtype -M shift -k Next"
      ```
       - Problem 1: Only works the first wheel turn, then need to relase and press again *$mod*
       - Problem 2: Different apps use different combinations, i.e.: just *ScrollWheel* or *Shift+ScrollWheel*
   - Persistent workspaces [swaywm/sway#7631](https://github.com/swaywm/sway/pull/7631)
   - Share a specific window on Google Meet [swaywm/sway#3282](https://github.com/swaywm/sway/issues/3282)
   - <s>XWayland windows gets tiled uppong being reopened from system tray [swaywm/sway#6905](https://github.com/swaywm/sway/issues/6905)</s>
 - Toolbx
   - Load completions from the host [containers/toolbox#1302](https://github.com/containers/toolbox/issues/1472)
   - Support for custom commands upon entering container [containers/toolbox#1302](https://github.com/containers/toolbox/issues/1302)
 - Vim Flatpak
   - Wayland support [vim/vim#4727](https://github.com/vim/vim/issues/4727), [vim/vim#9639](https://github.com/vim/vim/pull/9639)
 - Visual Studio Code
   - Add optional Wayland support [flathub/com.visualstudio.code#471](https://github.com/flathub/com.visualstudio.code/issues/471)
   - <s>Crash when rebuilding application menu on wayland [microsoft/vscode#184124](https://github.com/microsoft/vscode/issues/184124)</s>
   - Exit Vim Insert Mode on Save [VSCodeVim/Vim#2411](https://github.com/VSCodeVim/Vim/issues/2411)
   - <s>JetBrains Mono font ligatures not working [JetBrains/JetBrainsMono#655](https://github.com/JetBrains/JetBrainsMono/issues/655)</s>
   - Paste through mouse middle button does not insert text at cursor position[VSCodeVim/Vim#5065](https://github.com/VSCodeVim/Vim/issues/5065)
   - Reset to normal mode when leaving file focus [VSCodeVim/Vim#7553](https://github.com/VSCodeVim/Vim/issues/7553)
   - <s>Small/giant mouse cursor [microsoft/vscode#136390](https://github.com/microsoft/vscode/issues/136390)</s>
 - Zathura
   - Add Flatpak manifest [pwmt/zathura#25](https://git.pwmt.org/pwmt/zathura/-/merge_requests/25)

## TODO
 - Setup hibernation
    - [https://discussion.fedoraproject.org/t/setup-hibernation-on-silverblue-kionite/78834](https://discussion.fedoraproject.org/t/setup-hibernation-on-silverblue-kionite/78834)
    - [https://bbs.archlinux.org/viewtopic.php?id=259382](https://bbs.archlinux.org/viewtopic.php?id=259382)
