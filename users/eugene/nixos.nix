{ pkgs, inputs, ... }:

{
  environment.localBinInPath = true;

  users.users.eugene = {
    isNormalUser = true;
    home = "/home/eugene";
    extraGroups = [ "docker" "lxd" "wheel" ];
    shell = pkgs.nushell;
    initialPassword = "changeme";
  };
}
