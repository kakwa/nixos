{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # image tools
    python3Packages.pillow
    imagemagick
    gifsicle
    ffmpeg
    giflib
  ];
}
