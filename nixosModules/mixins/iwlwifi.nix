_:
{
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=8 power_save=0
    options iwlmvm power_scheme=1
  '';
}
