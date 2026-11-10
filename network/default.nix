{
  vars,
  pkgs,
  config,
  ...
}: {

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  
    publish = {
      enable = true;          # master switch (replaces disable-publishing = false)
      userServices = true;    # replaces disable-user-service-publishing = false
      addresses = true;       # publish-addresses
      domain = true;          # publish-domain
      hinfo = true;           # publish-hinfo
      workstation = true;     # publish-workstation
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "kakwa" ];
      MaxAuthTries = 3;
      PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
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
