{ config, lib, pkgs, ... }:

let
  shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
in {
  programs.nushell = {
    enable = true;
    configFile.source = ../nushell/config.nu;
    shellAliases = shellAliases;
  };
}
