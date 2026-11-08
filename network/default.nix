{
  vars,
  pkgs,
  config,
  ...
}: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    settings.publish = {
      disable-publishing = false;
      disable-user-service-publishing = false;
      publish-addresses = true;
      publish-domain = true;
      publish-hinfo = true;
      publish-workstation = true;
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
