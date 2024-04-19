{
  description = "nat's nix flake (:";

  inputs = {
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix/main";
    conduit.inputs.nixpkgs.follows = "nixpkgs";
    conduit.url = "github:girlbossceo/conduwuit/main";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts/main";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:surfaceflinger/home-manager/amberol-init";
    impermanence.url = "github:nix-community/impermanence/master";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    schizofox.inputs.nixpkgs.follows = "nixpkgs";
    schizofox.url = "github:surfaceflinger/schizofox/firefox-sync";
    srvos.inputs.nixpkgs.follows = "nixpkgs";
    srvos.url = "github:nix-community/srvos/main";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix/main";
    xkomhotshot.inputs.nixpkgs.follows = "nixpkgs";
    xkomhotshot.url = "github:surfaceflinger/xkomhotshot/master";
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "riscv64-linux"
        "x86_64-linux"
      ];

      imports = [
        ./hmModules
        ./nixosConfigurations
        ./nixosModules
        ./packages
        inputs.treefmt-nix.flakeModule
      ];

      perSystem.treefmt.imports = [ ./treefmt.nix ];
    };
}
