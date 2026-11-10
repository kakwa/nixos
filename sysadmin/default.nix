{
  vars,
  pkgs,
  config,
  ...
}: {
  # Allow the primary user to run sudo without a password.
  security.sudo.extraRules = [
    {
      users = [ vars.user ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

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
    lshw # list my hardware
    usbutils # for lsusb
    pciutils # for lspci
  ];
}
