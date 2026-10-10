{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # GUI tools
    remmina # XRDP & VNC Client
    flameshot # fancy screenshot tool
    sway-contrib.grimshot # basic (CLI) screenshot tool
    evince # pdf reader
    firefox # browser
    xournalpp # handwriting Notetaking software with PDF annotation support
    lxqt.lxqt-openssh-askpass # GUI askpass
    gimp # raster image editor
    inkscape # vector image editor
    geeqie # image viewer
    mpv # video viewer
    prusa-slicer # 3d printer slicer
    freecad # 3d modeling
    kicad # PCB designer
    spotify # music
    discord # chat
    libreoffice # office suit
    kdePackages.kdenlive
  ];
}
