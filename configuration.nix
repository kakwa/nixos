# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
# This configuration replaces the previous Ansible playbook
# (../desktop.yml + ../roles/*) used to provision this desktop. Each
# section below is annotated with the Ansible role(s) it replaces.

{ config, lib, pkgs, ... }:

let
  # Wrap the sway helper scripts (roles/sway/files/sway-*.py) as a package so
  # they land in $PATH, instead of being copied to /usr/local/bin like Ansible did.
  swayPython = pkgs.python3.withPackages (ps: [ ps.i3ipc ]);
  swayScripts = pkgs.stdenvNoCC.mkDerivation {
    pname = "kakwa-sway-scripts";
    version = "1.0";
    src = ./files/sway;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/bin
      for f in sway-window-cycle.py sway-workspace-cycle.py sway-workspace-init.py; do
        install -m0755 $f $out/bin/$f
        substituteInPlace $out/bin/$f --replace "/usr/bin/env python3" "${swayPython}/bin/python3"
      done
    '';
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "chimay"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  ##############################################################################
  # roles/plymouth: boot splash
  ##############################################################################
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" "splash" ];

  ##############################################################################
  # roles/sway (+ terminal, misc-desktop's display bits): Wayland desktop
  ##############################################################################
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      xwayland
      swaylock
      swayidle
      xdg-desktop-portal-wlr
      wdisplays
      wmenu
      i3status
      swayScripts
    ];
  };

  # roles/sway "Install sway stuff": pipewire replaces pulseaudio.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # roles/sway "Desktop Configuration" (custom wayland-sessions .desktop) and
  # display manager (gdm3 in the Ansible role).
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  #services.displayManager.sessionPackages = [
  #  (pkgs.writeTextFile {
  #    name = "sway-cust-session";
  #    destination = "/share/wayland-sessions/sway-cust.desktop";
  #    text = builtins.readFile ./files/sway/sway-cust.desktop;
  #  })
  #];

  # roles/sway "Install Wallpaper" / "Install Sway Wallpaper configuration":
  # /etc/sway/config expects the wallpaper at /usr/share/backgrounds/kwp.jpg.
  systemd.tmpfiles.rules = [
    "L+ /usr/share/backgrounds/kwp.jpg - - - - ${./files/sway/kwp.jpg}"
  ];

  environment.etc = {
    "sway/config".source = ./files/sway/config;
    "sway/config.d/40-sway-background.conf".source = ./files/sway/40-sway-background.conf;
    "i3status.conf".source = ./files/sway/i3status.conf;

    ##############################################################################
    # roles/terminal: foot terminal emulator
    ##############################################################################
    "xdg/foot/foot.ini".source = ./files/terminal/foot.ini;

    ##############################################################################
    # roles/vim
    ##############################################################################
    "vim/vimrc".source = ./files/vim/vimrc;

    ##############################################################################
    # roles/gdb
    ##############################################################################
    "gdb/gdbinit".source = ./files/gdb/gdbinit;
    "gdb/gdbinit.d/myutils.py".source = ./files/gdb/myutils.py;

    ##############################################################################
    # roles/git
    ##############################################################################
    "gitconfig".source = ./files/git/gitconfig;
    "gitignore".source = ./files/git/gitignore;
  };

  ##############################################################################
  # roles/sensors: lm_sensors package (facts baked into i3status.conf above,
  # for this host's k10temp/amdgpu hwmon paths)
  ##############################################################################
  services.fwupd.enable = true; # roles/misc-base "fwupd"

  environment.systemPackages = with pkgs; [
    # roles/misc-base
    rsync
    btop
    psmisc
    screen
    tmux
    tree
    nmap
    tcpdump

    # roles/misc-desktop
    android-file-transfer
    sway-contrib.grimshot
    v4l-utils
    flameshot
    firefox
    libreoffice
    mpv
    inkscape
    gimp
    pavucontrol
    geeqie
    dmenu
    clang
    clang-tools
    cmake
    gnumake
    go
    ansible
    lm_sensors

    # Softwares
    freecad
    kicad
    spotify
    #discord
    #slack
    prusa-slicer

    # roles/git, roles/vim, roles/gdb, roles/terminal
    git
    vim
    gdb
    foot
    dejavu_fonts

    # Editors / misc
    wget
  ];

  # roles/misc-base "unattended-upgrades": closest NixOS analog.
  system.autoUpgrade.enable = true;

  # roles/misc-desktop "docker.io"
  virtualisation.docker.enable = true;

  # NOTE: roles/repos and roles/repos-desktop only added Debian (apt)
  # third-party repositories (freecad-pkg, spotify, slack-discord-misc-pkg,
  # kakwalab-pkg, misc-pkg, debian-rpm-build-tools, opentofu); no repository
  # configuration is needed on NixOS since packages are pulled from nixpkgs:
  #   - spotify, discord, slack, scc -> already installed above, from nixpkgs
  #   - freecad, opentofu -> available in nixpkgs if ever needed, not
  #     installed here since they weren't in the original package lists either
  #   - astocad, cowbuilder, mock, apt-file, ncal -> Debian-specific packaging
  #     tools/packages with no NixOS equivalent; skipped.

  ##############################################################################
  # roles/zsh: system-wide zsh + oh-my-zsh (gentoo theme, git/debian plugins)
  ##############################################################################
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "gentoo";
      plugins = [ "git" "debian" ];
    };
    interactiveShellInit = ''
      export EDITOR="vim"
      export PATH=$PATH:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:/sbin:/usr/sbin

      alias tree="tree -C"
      alias gh="cd $HOME/Geek/GitHub"
      alias gu="cd $HOME/Geek/Upstream"
      alias setswaykbmap="swaymsg input 'type:keyboard' xkb_layout"
    '';
  };

  ##############################################################################
  # roles/users
  ##############################################################################

  users.groups.carpenti = { gid = 1002; };
  users.groups.kakwa = { gid = 1001; };

  users.users.kakwa = {
    isNormalUser = true;
    uid = 1001;
    description = "Kakwa";
    group = "kakwa";
    shell = pkgs.zsh;
    extraGroups = [
      "cdrom" "floppy" "audio" "dip" "video" "plugdev" "users" "render"
      "netdev" "docker" "wheel" # wheel == sudo group on NixOS
    ];
  };

  users.users.carpenti = {
    isNormalUser = true;
    uid = 1002;
    description = "Carpenti";
    group = "carpenti";
    shell = pkgs.zsh;
    extraGroups = [
      "cdrom" "floppy" "audio" "dip" "video" "plugdev" "users" "render"
      "netdev" "docker" "wheel" # wheel == sudo group on NixOS
    ];
  };

  # programs.firefox.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
