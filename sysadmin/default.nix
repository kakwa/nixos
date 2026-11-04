{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # sysadmin tools
    htop # better top
    btop # better htop
    tree # see tree dirs/files structure
    tmux # terminal multiplexer/persistent sessions
    screen # same but old school
    lshw # hardware config scanner
    pstree # process tree display
    ansible # configuration tools
    virt-manager # VM manager
  ];
}
