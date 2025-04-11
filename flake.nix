{
  description = "nat's nix flake (:";

  inputs = {
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix/main";
    blahajpl-homepage.flake = false;
    blahajpl-homepage.url = "github:blahaj-pl/homepage/main";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";
    blueprint.url = "github:numtide/blueprint/main";
    cfn-changeset-viewer.inputs.nixpkgs.follows = "nixpkgs";
    cfn-changeset-viewer.url = "github:surfaceflinger/cfn-changeset-viewer/flake-parts";
    dont-track-me.url = "github:dtomvan/dont-track-me.nix/main";
    firefox-gnome-theme.flake = false;
    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme/v132";
    grapevine.url = "git+https://gitlab.computer.surgery/matrix/grapevine.git?ref=main";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    impermanence.url = "github:nix-community/impermanence/master";
    nano-syntax-highlighting.flake = false;
    nano-syntax-highlighting.url = "github:galenguyer/nano-syntax-highlighting/master";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database/main";
    nix-mineral.flake = false;
    nix-mineral.url = "github:cynicsketch/nix-mineral/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    schizofox.inputs.nixpkgs.follows = "nixpkgs";
    schizofox.url = "github:schizofox/schizofox/main";
    srvos.inputs.nixpkgs.follows = "nixpkgs";
    srvos.url = "github:nix-community/srvos/main";
    tf.inputs.nixpkgs.follows = "nixpkgs";
    tf.url = "github:vdesjardins/terraform-overlay/main";
    xkomhotshot.inputs.nixpkgs.follows = "nixpkgs";
    xkomhotshot.url = "github:surfaceflinger/xkomhotshot/master";
  };

  outputs = inputs: inputs.blueprint { inherit inputs; };
}
