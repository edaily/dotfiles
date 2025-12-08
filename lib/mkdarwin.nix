{ nixpkgs, inputs }:

name:
{
  system,
  user,
}:

let
  darwin = inputs.nix-darwin.lib.darwinSystem;
  home-manager = inputs.home-manager.darwinModules;
  
  machineConfig = ../machines/${name}.nix;
  userHMConfig = ../users/${user}/home-manager.nix;
in darwin {
  inherit system;

  modules = [
    machineConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.users.${user} = import userHMConfig {
        inputs = inputs;
      };
      home-manager.sharedModules = [
        inputs.nixvim.homeModules.nixvim
      ];
    }
    {
      users.users.${user}.home = "/Users/${user}";
    }
  ];
}
