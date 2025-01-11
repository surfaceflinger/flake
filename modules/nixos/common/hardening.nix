{ inputs, lib, ... }:
{
  imports = [
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  nix-mineral = {
    enable = true;
    overrides = {
      compatibility = {
        allow-ip-forward = true;
        allow-unsigned-modules = true;
        no-lockdown = true;
      };
      performance.allow-smt = true;
      security = {
        disable-bluetooth-kmodules = true;
        disable-intelme-kmodules = true;
        lock-root = true;
        sysrq-sak = true;
      };
    };
  };

  environment.etc.gitconfig.source = lib.mkForce "${inputs.security-misc}/etc/gitconfig";

  # fixup for building
  services.logrotate.checkConfig = false;
}
