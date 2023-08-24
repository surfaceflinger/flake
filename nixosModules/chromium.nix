{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    google-chrome-dev
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      # Manifest version in parenthesis
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin (2)
      "dneaehbmnbhcippjikoajpoabadpodje" # Old Reddit Redirect (2)
      "edibdbjcniadpccecjdfdjjppcpchdlm" # I still don't care about cookies (3)
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube dislike (3)
      "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs (2)
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube (2)
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden (3)
      "omkfmpieigblcllmkgbflkikinpkodlk" # enhanced-h264ify (2)
    ];
  };
}
