{
  pkgs,
  vars,
  ...
}:
{
  ##############################################################################
  # roles/zsh: system-wide zsh + oh-my-zsh (gentoo theme, git/debian plugins)
  ##############################################################################
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;

    ohMyZsh = {
      enable = true;
      theme = "gentoo";
      plugins = [
        "git"
        "debian"
      ];
      preLoaded = ''
        export ZSH_DISABLE_COMPFIX="true"
      '';
    };
    shellAliases = {
      tree = "tree -C";
      gh = "cd $HOME/Geek/GitHub";
      gu = "cd $HOME/Geek/Upstream";
      setswaykbmap = "swaymsg input 'type:keyboard' xkb_layout";
    };
  };
}
