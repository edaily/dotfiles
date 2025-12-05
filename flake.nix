{
  description = "NixOS systems and tools by mitchellh";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Used to get ibus 1.5.29 which has some quirks we want to test.
    nixpkgs-old-ibus.url = "github:nixos/nixpkgs/e2dd4e18cc1c7314e24154331bae07df76eb582f";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Master nixpkgs is used for really bleeding edge packages. Warning
    # that this is extremely unstable and shouldn't be relied on. Its
    # mostly for testing.
    nixpkgs-master.url = "github:nixos/nixpkgs";

    # snapd
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # I think technically you're not supposed to override the nixpkgs
    # used by neovim but recently I had failures if I didn't pin to my
    # own. We can always try to remove that anytime.
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    # Non-flakes
    theme-bobthefish.url = "github:oh-my-fish/theme-bobthefish/e3b4d4eafc23516e35f162686f08a42edf844e40";
    theme-bobthefish.flake = false;
    fish-fzf.url = "github:jethrokuan/fzf/24f4739fc1dffafcc0da3ccfbbd14d9c7d31827a";
    fish-fzf.flake = false;
    fish-foreign-env.url = "github:oh-my-fish/plugin-foreign-env/dddd9213272a0ab848d474d0cbde12ad034e65bc";
    fish-foreign-env.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
      (final: prev: rec {
        # gh CLI on stable has bugs.
        gh = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.gh;

        ibus = ibus_stable;
        ibus_stable = inputs.nixpkgs.legacyPackages.${prev.system}.ibus;
        ibus_1_5_29 = inputs.nixpkgs-old-ibus.legacyPackages.${prev.system}.ibus;
        ibus_1_5_31 = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.ibus;
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user   = "eugene";
    };
  };
}
