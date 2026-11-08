{
  vars,
  pkgs,
  config,
  ...
}: {
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # mdns
    avahi # mdns
    nssmdns

    wakeonlan # wol (perl)
    wol

    # network tools
    nmap # network search engine
    netcat # net army knife
    tcpdump # network capture
    wireshark # network capture (gui)
    dig # DNS querier
    wget # http client
    curl # http client, but better, and ftp, sftp, and more
  ];
}
