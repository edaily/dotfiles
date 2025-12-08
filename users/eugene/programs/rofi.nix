{ config, lib, pkgs, ... }:

let
  isLinux = pkgs.stdenv.isLinux;
in {
  programs.rofi = {
    enable = isLinux;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font 14";
    theme = "gruvbox-dark-hard";
  };
}
