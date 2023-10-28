_: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      Ciphers = [ "chacha20-poly1305@openssh.com" ];
      KbdInteractiveAuthentication = false;
      KexAlgorithms = [ "sntrup761x25519-sha512@openssh.com" ];
      Macs = [ "-*" ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    extraConfig = ''
      AllowAgentForwarding no
      AllowGroups users
      LoginGraceTime 15s
      MaxAuthTries 2
      MaxStartups 4096
      PerSourceMaxStartups 1
      PubkeyAcceptedKeyTypes ssh-ed25519
    '';
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
