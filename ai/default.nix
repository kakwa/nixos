{
  vars,
  pkgs,
  config,
  ...
}: let
  unstable = "crap";
in {
  environment.systemPackages = with pkgs; [
    opencode # AI coding agent
  ];

  #home-manager.users.${vars.user} = {
  #  xdg.configFile."opencode/opencode.json".source = ./assets/opencode.json;
  #  xdg.configFile."opencode/opencode.json".force = true;

  #  xdg.configFile."opencode/AGENTS.md".source = ./assets/AGENTS.md;
  #  xdg.configFile."opencode/AGENTS.md".force = true;
  #};
}
