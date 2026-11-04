{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # hashicorp tools
    opentofu
    openbao
  ];
}
