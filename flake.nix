{
  description = "nat's nix flake (:";

  # nixConfig = {
  #   extra-substituters = [
  #     "https://cache.garnix.io"
  #     "https://cache.nixos.org"
  #     "https://nix-community.cachix.org"
  #     "https://numtide.cachix.org"
  #   ];
  #   extra-trusted-public-keys = [
  #     "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  #     "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #     "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
  #   ];
  # };

  inputs = {
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    chrome.inputs.nixpkgs.follows = "nixpkgs";
    chrome.url = "github:r-k-b/browser-previews";
    conduit.inputs.nixpkgs.follows = "nixpkgs";
    conduit.url = "gitlab:girlbossceo/conduwuit/main";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nyx.inputs.nixpkgs.follows = "nixpkgs";
    nyx.url = "github:chaotic-cx/nyx";
    srvos.inputs.nixpkgs.follows = "nixpkgs";
    srvos.url = "github:nix-community/srvos";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    xkomhotshot.inputs.nixpkgs.follows = "nixpkgs";
    xkomhotshot.url = "github:surfaceflinger/xkomhotshot";
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-linux" "x86_64-linux" ];

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
