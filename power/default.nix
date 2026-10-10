{
  vars,
  pkgs,
  config,
  ...
}: {
  # Home setup (closing lid)
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
}
