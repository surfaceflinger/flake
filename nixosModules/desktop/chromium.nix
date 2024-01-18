{ inputs, lib, pkgs, ... }:
{
  environment.systemPackages = [
    (inputs.chrome.packages.${pkgs.system}.google-chrome.overrideAttrs (attrs: { meta = attrs.meta // { license = lib.licenses.free; }; }))
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
      "cankofcoohmbhfpcemhmaaeennfbnmgp" # Netflix 1080p
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "dgcfkhmmpcmkikfmonjcalnjcmjcjjdn" # CurlWget
      "dneaehbmnbhcippjikoajpoabadpodje" # Old Reddit Redirect
      "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
      "donbcfbmhbcapadipfkeojnmajbakjdc" # ruffle.rs
      "edibdbjcniadpccecjdfdjjppcpchdlm" # I still don't care about cookies
      "emffkefkbkpkgpdeeooapgaicgmcbolj" # Wikiwand
      "enamippconapkdmgfgjchkhakpfinmaj" # DeArrow
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube dislike
      "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # Google Docs Offline
      "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
      "icallnadddjmdinamnolclfjanhfoafe" # FastForward
      "ipdchdaimepggclpjanobgdahjflhedd" # AWS Dark
      "jinjaccalgkegednnccohejagnlnfdag" # Małpka
      "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs
      "ldpochfccmkkmhdbclfhpagapcfdljkj" # Decentraleyes
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "ohnjgmpcibpbafdlkimncjhflgedgpam" # 4chan X
      "pampamgoihgcedonnphgehgondkhikel" # DotGit
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
    ];
    extraOpts = {
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      "BlockThirdPartyCookies" = true;
      "BuiltInDnsClientEnabled" = false;
      "CloudPrintProxyEnabled" = false;
      "ExtensionInstallBlocklist" = [ "*" ];
      "HistoryClustersVisible" = false;
      "HttpsOnlyMode" = "force_enabled";
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
      "UrlKeyedAnonymizedDataCollectionEnabled" = false;
    };
  };
}
