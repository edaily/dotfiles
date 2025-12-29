{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  isLinux = pkgs.stdenv.isLinux;
in {
  imports = [ ./programs ];

  # Make inputs available to all imported modules
  _module.args.inputs = inputs;

  home.stateVersion = "18.09";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = [
    pkgs.chezmoi
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.htop
    pkgs.jq
    pkgs.ripgrep
    pkgs.tree
    pkgs.watch
    pkgs.gopls
    pkgs.neofetch
    pkgs.nil
    pkgs.lua-language-server
    pkgs.nodePackages.typescript-language-server
    pkgs.sshpass
    pkgs.rustc
    pkgs.cargo
    pkgs.claude-code
    pkgs.nixfmt-rfc-style
    pkgs.opencode
    pkgs.jellyfin
  ] ++ (lib.optionals isLinux [
    # Hyprland session essentials
    pkgs.ghostty
    pkgs.waybar
    pkgs.swaybg
    pkgs.wl-clipboard
    pkgs.wlogout
    pkgs.polkit_gnome
    pkgs._1password-cli
    pkgs.google-chrome
  ]) ++ [
    (pkgs.writeShellApplication {
      name = "random-wallpaper";
      runtimeInputs = [ pkgs.coreutils pkgs.findutils ] ++ (lib.optionals isLinux [ pkgs.swaybg ]);
      text = builtins.readFile ./scripts/random-wallpaper.sh;
    })
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
  };

  xdg.configFile."wallpapers".source = ./wallpapers;
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  xdg.configFile."ghostty/config".source = ./ghostty/config;

  home.pointerCursor = lib.mkIf isLinux {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 18;
  };

  gtk = lib.mkIf isLinux {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

}

