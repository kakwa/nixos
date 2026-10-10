{
  vars,
  pkgs,
  config,
  lib,
  ...
}:
{
  options.perso.vim.enable = lib.mkEnableOption "system-wide vim with custom vimrc";

  config = lib.mkIf config.perso.vim.enable {
    environment.systemPackages = [
      (pkgs.vim-full.customize {
        name = "vim";
        vimrcFile = ./assets/vimrc;
      })
    ];
  };
}
