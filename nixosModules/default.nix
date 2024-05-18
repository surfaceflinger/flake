_: {
  flake.nixosModules = {
    # Presets
    common = ./common;
    desktop = ./desktop;
    laptop = ./laptop;
    server = ./server;
    vps = ./vps;

    # Mixins
    gaming = ./mixins/gaming.nix;
    iwlwifi = ./mixins/iwlwifi.nix;
    mitigations-off = ./mixins/mitigations-off.nix;
    ryzen = ./mixins/ryzen.nix;
    tpm12 = ./mixins/tpm12.nix;
    tpm20 = ./mixins/tpm20.nix;
    virtualisation = ./mixins/virtualisation.nix;

    # Users
    nat = ./users/nat.nix;
    natwork = ./users/natwork.nix;
  };
}
