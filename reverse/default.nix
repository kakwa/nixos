{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # reverse engineering
    ghidra
    file
  ];
}
