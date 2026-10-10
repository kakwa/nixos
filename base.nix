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
    (import ./environment {inherit vars pkgs config;})
    (import ./gui {inherit vars pkgs config;})
    (import ./fonts {inherit vars pkgs config;})
    (import ./git {inherit vars pkgs config;})
    (import ./power {inherit vars pkgs config;})
  ];

  perso.vim.enable = true;
  programs = {
    zsh = {
      enable = true;
    };
  };
}
