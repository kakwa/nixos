{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # nix tools
    nix-output-monitor
    nh # nix helper (nh search <pkg name>)
    nix-index # another nix helper (search for filenames)
    nixfmt
  ];
}
