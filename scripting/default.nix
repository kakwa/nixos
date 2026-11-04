{
  vars,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # scripting
    jq # json processor
    jo # easily create json object
    yq-go # yaml processor
    expect # for automating interactive stuff
    perl # hell
    envsubst # basic envvar template processor (ex: gen config leveraging a few variables)
  ];
}
