{
  vars,
  pkgs,
  config,
  ...
}: {
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

      # hashicorp tools
      opentofu
      openbao

      # nix tools
      alejandra
      nix-output-monitor
      nh # nix helper (nh search <pkg name>)
      nix-index # another nix helper (search for filenames)
      nixfmt
    ];
  };
}
