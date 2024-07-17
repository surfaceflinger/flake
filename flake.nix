{
  description = "nat's nix flake (:";

  inputs = {
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix/main";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";
    blueprint.url = "github:numtide/blueprint/main";
    cfn-changeset-viewer.inputs.nixpkgs.follows = "nixpkgs";
    cfn-changeset-viewer.url = "github:surfaceflinger/cfn-changeset-viewer/flake-parts";
    conduit.inputs.nixpkgs.follows = "nixpkgs";
    conduit.url = "github:girlbossceo/conduwuit/main";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    impermanence.url = "github:nix-community/impermanence/master";
    lix.flake = false;
    lix-module.inputs.lix.follows = "lix";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
    lix-module.url = "git+https://git.lix.systems/lix-project/nixos-module";
    lix.url = "git+https://git@git.lix.systems/lix-project/lix?ref=main";
    mutter.flake = false;
    mutter.url = "git+https://gitlab.gnome.org/Community/Ubuntu/mutter.git?ref=triple-buffering-v4-46";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database/main";
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
