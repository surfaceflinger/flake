{ config, ... }:
{
  services.tcsd.enable = true;
  users.groups."tss".members = config.users.groups."wheel".members;
}
