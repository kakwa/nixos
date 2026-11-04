{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # file handling tools
    p7zip # Zip Encryption
    rsync # Syncer - $ rsync -r dir1/ dir2/
    unzip # Zip Files
    zip # Zip
  ];
}
