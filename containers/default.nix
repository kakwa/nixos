{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # container tools
    dive # docker image inspector
    podman # container manager
    kubectl # k8s
  ];
}
