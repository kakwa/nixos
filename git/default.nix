{
  vars,
  pkgs,
  config,
  ...
}: let
  gitignore = pkgs.writeText "gitignore" ''
    # IDE
    .idea
    .vscode
    *debug
    # vim
    *.sw?
  '';
in {
  programs.git = {
    enable = true;
    lfs.enable = true;

    config = {
      user = {
        name = vars.gitUser;
        email = "carpentier.pf@gmail.com";
      };
      commit = {
        verbose = true;
      };
      core = {
        editor = vars.editor;
        askPass = "";
        excludesFile = gitignore;
      };
      column = {
        ui = "auto";
      };
      branch = {
        sort = "-committerdate";
      };
      tag = {
        sort = "version:refname";
      };
      init = {
        defaultBranch = "main";
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help = {
        autocorrect = "prompt";
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      alias = {
        glog = "log --all --pretty='format:%d %Cgreen%h%Creset %an - %s' --graph";
      };
    };
  };
}
