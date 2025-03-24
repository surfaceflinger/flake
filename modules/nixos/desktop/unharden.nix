{
  config,
  lib,
  ...
}:
{
  nix-mineral.overrides = {
    desktop = {
      allow-multilib = true;
      allow-unprivileged-userns = true;
      disable-usbguard = true;
      home-exec = true;
      skip-restrict-home-permission = true;
      tmp-exec = true;
      yama-relaxed = true;
    };
    performance.no-pti = true;
    security = {
      disable-bluetooth-kmodules = lib.mkForce false;
    };
  };

  boot.specialFileSystems."/proc" = {
    options = lib.mkForce [
      "nosuid"
      "nodev"
      "noexec"
      "hidepid=0"
      "gid=${toString config.users.groups.proc.gid}"
    ];
  };
}
