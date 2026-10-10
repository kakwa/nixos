{
  config,
  pkgs,
  username,
  lib,
  ...
}:
let
  vars = {
    user = "kakwa";
    gitUser = "kakwa";
    location = "$HOME/.setup";
    terminal = "foot";
    editor = "vim";
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    (import ./terminal { inherit vars pkgs config; })
    (import ./sway {
      inherit
        vars
        pkgs
        config
        lib
        ;
    })
    (import ./ai { inherit vars pkgs config; })
    (import ./vim {
      inherit
        vars
        pkgs
        config
        lib
        ;
    })
  ];

  perso.vim.enable = true;
  programs = {
    zsh = {
      enable = true;
    };
  };

  # Home setup (closing lid)
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };

    systemPackages = with pkgs; [
      # scripting
      jq # json processor
      jo # easily create json object
      yq-go # yaml processor
      expect # for automating interactive stuff
      perl # hell
      envsubst # basic envvar template processor (ex: gen config leveraging a few variables)

      # file handling tools
      p7zip # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      unzip # Zip Files
      zip # Zip

      # dev and debug tools
      git # better cvs
      strace # debug and trace syscalls
      delve # gdb-like for golang
      gdlv # delve gui
      scc # sloccount (source line of code count) but modern
      tig # git viz
      clang # compiler
      clang-tools # clang tools (format, LSP/clangd & more
      cmake # smaller hell
      rustup # more languages
      python3 # MORE
      go # MORE!
 
      # sysadmin tools
      htop # better top
      btop # better htop
      tree # see tree dirs/files structure
      tmux # terminal multiplexer/persistent sessions
      lshw # hardware config scanner
      pstree # process tree display
      ansible # configuration tools

      # container tools
      dive # docker image inspector
      podman # container manager
      kubectl # k8s

      # misc tools
      pwgen

      # network tools
      nmap # network search engine
      netcat # net army knife
      tcpdump # network capture
      wireshark # network capture (gui)
      dig # DNS querier
      wget # http client
      curl # http client, but better, and ftp, sftp, and more

      # GUI tools
      remmina # XRDP & VNC Client
      flameshot # fancy screenshot tool
      sway-contrib.grimshot # basic (CLI) screenshot tool
      evince # pdf reader
      firefox # browser
      xournalpp # handwriting Notetaking software with PDF annotation support
      lxqt.lxqt-openssh-askpass # GUI askpass
      gimp # raster image editor
      inkscape # vector image editor
      geeqie # image viewer
      mpv # video viewer
      prusa-slicer # 3d printer slicer
      freecad # 3d modeling
      kicad # PCB designer
      spotify # music
      discord # chat

      # hashicorp tools
      #terraform
      #vault
      #boundary

      # nix tools
      alejandra
      nix-output-monitor
      nh # nix helper (nh search <pkg name>)
      nix-index # another nix helper (search for filenames)
      nixfmt-rfc-style
    ];
  };

  programs = {
    git = {
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
  };
}
