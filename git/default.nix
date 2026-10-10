{
  vars,
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    #ignores = [
    #  # IDE
    #  ".idea"
    #  ".vscode"
    #  "*debug"
    #  # vim
    #  "*.sw?"
    #];
    # settings = {
    #   user = {
    #     name = "kakwa";
    #     email = "carpentier.pf@gmail.com";
    #   };
    #   commit = {
    #     verbose = true;
    #   };
    #   core = {
    #     editor = "vim";
    #     askPass = "";
    #   };
    #   column = {
    #     ui = "auto";
    #   };
    #   branch = {
    #     sort = "-committerdate";
    #   };
    #   tag = {
    #     sort = "version:refname";
    #   };
    #   init = {
    #     defaultBranch = "main";
    #   };
    #   diff = {
    #     algorithm = "histogram";
    #     colorMoved = "plain";
    #     mnemonicPrefix = true;
    #     renames = true;
    #   };
    #   fetch = {
    #     prune = true;
    #     pruneTags = true;
    #     all = true;
    #   };
    #   help = {
    #     autocorrect = "prompt";
    #   };
    #   rerere = {
    #     enabled = true;
    #     autoupdate = true;
    #   };
    #   rebase = {
    #     autoSquash = true;
    #     autoStash = true;
    #     updateRefs = true;
    #   };
    #   merge = {
    #     conflictstyle = "zdiff3";
    #   };
    #   pull = {
    #     rebase = true;
    #   };
    #   push = {
    #     default = "simple";
    #     autoSetupRemote = true;
    #     followTags = true;
    #   };
    #   # Replace all https to git remote url
    #   #alias = {
    #   #  glog = "log --all --pretty='format:%d %Cgreen%h%Creset %an - %s' --graph";
    #   #};
    # };
  };
}
