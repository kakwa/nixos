{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
    gnumake # make
    rustup # more languages
    python3 # MORE
    go # MORE!
    nodejs_26 # MORRREEEEE!!!!!
  ];
}
