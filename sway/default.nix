{
  vars,
  pkgs,
  config,
  lib,
  ...
}:
let
  # Wrap the sway helper scripts (roles/sway/files/sway-*.py) as a package so
  # they land in $PATH, instead of being copied to /usr/local/bin like Ansible did.
  swayPython = pkgs.python3.withPackages (ps: [ ps.i3ipc ]);
  swayScripts = pkgs.stdenvNoCC.mkDerivation {
    pname = "kakwa-sway-scripts";
    version = "1.0";
    src = ./assets;
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
  services.displayManager.defaultSession = "sway";

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      xwayland # run X11 apps under wayland
      swaylock # screen locker
      swayidle # idle manager (screen blank/lock)
      xdg-desktop-portal-wlr # screen sharing/screenshot portal
      wdisplays # graphical display configuration
      wl-clipboard # wl-copy/wl-paste
      wmenu # wayland menu launcher
      i3status # status bar generator
      pavucontrol # pulseaudio volume mixer (GUI)
      bluez # bluetooth
      blueman # bluetooth device manager
      swayScripts # sway helper scripts (window/workspace cycling)
    ];
  };

  environment.systemPackages = with pkgs; [
    (pkgs.writeTextFile {
      name = "sway-session";
      destination = "/share/wayland-sessions/sway.desktop";
      text = ''
        [Desktop Entry]
        Name=Sway
        Comment=An i3-compatible Wayland compositor
        Exec=env XDG_SESSION_TYPE=wayland XDG_CURRENT_DESKTOP=sway dbus-run-session sway
        Type=Application
      '';
    })
  ];

  environment.etc = {
    "sway/config".source = ./assets/config;
    "sway/bg.jpg".source = ./assets/bg.jpg;
    "sway/config.d/40-sway-background.conf".source = ./assets/40-sway-background.conf;
    "sway/config.d/50-swayidle.conf".source = ./assets/50-swayidle.conf;
    "i3status.conf".source = ./assets/i3status.conf;
  };

  # Handle lid close: lock + suspend (overrides "ignore" set in default.nix)
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = lib.mkForce "suspend";
    HandleLidSwitchDocked = lib.mkForce "ignore";
  };
}
