{
  config,
  pkgs,
  username,
  lib,
  ...
}: let
  vars = import ./vars.nix;
in {
  imports = [
    # Include the results of the hardware scan.
    (import ./terminal {inherit vars pkgs config;})
    (import ./sway {
      inherit
        vars
        pkgs
        config
        lib
        ;
    })
    (import ./ai {inherit vars pkgs config;})
    (import ./vim {
      inherit
        vars
        pkgs
        config
        lib
        ;
    })
    (import ./devtools {inherit vars pkgs config;})
    (import ./scripting {inherit vars pkgs config;})
    (import ./files {inherit vars pkgs config;})
    (import ./sysadmin {inherit vars pkgs config;})
    (import ./containers {inherit vars pkgs config;})
    (import ./misc {inherit vars pkgs config;})
    (import ./network {inherit vars pkgs config;})
    (import ./infra {inherit vars pkgs config;})
    (import ./image {inherit vars pkgs config;})
    (import ./reverse {inherit vars pkgs config;})
    (import ./nixtools {inherit vars pkgs config;})
    (import ./apps {inherit vars pkgs config;})
    (import ./fonts {inherit vars pkgs config;})
    (import ./git {inherit vars pkgs config;})
  ];

  environment.variables = {
    TERMINAL = "${vars.terminal}";
    EDITOR = "${vars.editor}";
    VISUAL = "${vars.editor}";
  };

  perso.vim.enable = true;
  programs = {
    zsh = {
      enable = true;
    };
  };
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
}
