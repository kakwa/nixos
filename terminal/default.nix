{
  vars,
  pkgs,
  config,
  ...
}:
{
  imports = [
    (import ./foot.nix { inherit vars pkgs; })
    (import ./zsh.nix { inherit vars pkgs; })
  ];
}
