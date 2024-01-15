_:
{
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=8
    options iwlmvm power_scheme=1
  '';
}
