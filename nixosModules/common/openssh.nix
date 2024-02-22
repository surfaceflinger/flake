_: {
  # https://github.com/k4yt3x/sshd_config
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
      ];
      KbdInteractiveAuthentication = false;
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "diffie-hellman-group14-sha256"
      ];
      Macs = [
        "hmac-sha2-256-etm@openssh.com"
        "hmac-sha2-512-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    extraConfig = ''
      AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
      AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
      AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
      AcceptEnv XMODIFIERS

      AllowAgentForwarding no
      AllowTcpForwarding no
      AllowStreamLocalForwarding no
      DisableForwarding yes
      PermitTunnel no

      AuthenticationMethods publickey
      MaxAuthTries 3
      PermitEmptyPasswords no
      PubkeyAuthentication yes

      HostKeyAlgorithms ssh-ed25519

      ClientAliveCountMax 2
      ClientAliveInterval 300
      TCPKeepAlive no

      Compression no

      IgnoreRhosts yes

      MaxSessions 2

      Protocol 2

      AllowGroups users
    '';
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
