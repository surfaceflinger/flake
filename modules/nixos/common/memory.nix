{ inputs, ... }:
{
  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };

  environment.etc."sysctl.d/10-pop-default-settings.conf".source =
    inputs.pop-os-default-settings + /etc/sysctl.d/10-pop-default-settings.conf;

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
  };
}
