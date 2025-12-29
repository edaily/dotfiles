{ config, lib, pkgs, ... }:

let isLinux = pkgs.stdenv.isLinux;
in {
  programs.rofi = {
    enable = isLinux;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font 14";
    theme = ../rofi/theme.rasi;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
    };
  };
}
