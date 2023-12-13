{ lib
, pkgs
, config
, ...
}:
{
  services.printing = {
    enable = true;
    webInterface = false;
    stateless = true;
  };
}
