{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    google-chrome
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
      "cankofcoohmbhfpcemhmaaeennfbnmgp" # Netflix 1080p
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "dneaehbmnbhcippjikoajpoabadpodje" # Old Reddit Redirect
      "edibdbjcniadpccecjdfdjjppcpchdlm" # I still don't care about cookies
      "emffkefkbkpkgpdeeooapgaicgmcbolj" # Wikiwand
      "enamippconapkdmgfgjchkhakpfinmaj" # DeArrow
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube dislike
      "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # Google Docs Offline
      "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
      "icallnadddjmdinamnolclfjanhfoafe" # FastForward
      "ipdchdaimepggclpjanobgdahjflhedd" # AWS Dark
      "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    ];
    extraOpts = {
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      "BlockThirdPartyCookies" = true;
      "CloudPrintProxyEnabled" = false;
      "HistoryClustersVisible" = false;
      "MetricsReportingEnabled" = false;
      "NetworkPredictionOptions" = 2;
      "PasswordManagerEnabled" = false;
      "PaymentMethodQueryEnabled" = false;
      "PrivacySandboxAdMeasurementEnabled" = false;
      "PrivacySandboxAdTopicsEnabled" = false;
      "PrivacySandboxPromptEnabled" = false;
      "PrivacySandboxSiteEnabledAdsEnabled" = false;
      "SafeBrowsingProtectionLevel" = 0;
      "SearchSuggestEnabled" = false;
      "SpellCheckServiceEnabled" = false;
      "SSLErrorOverrideAllowed" = true;
    };
  };
}
