{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  isLinux = pkgs.stdenv.isLinux;

  shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
in {
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

    # Hyprland session essentials
    pkgs.ghostty
    pkgs.waybar
    pkgs.swaybg
    pkgs.wl-clipboard
    pkgs.wlogout
    pkgs.polkit_gnome
    (pkgs.writeShellApplication {
      name = "random-wallpaper";
      runtimeInputs = [ pkgs.swaybg pkgs.coreutils pkgs.findutils ];
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
  
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 18;
  };

  gtk = {
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

  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    shellAliases = shellAliases;
  };

  programs.go = {
    enable = true;
    env.GOPATH = "code/go";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Eugene";
        email = "eugene@builtbyeugene.com";
      };
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      github.user = "edaily";
      push.default = "tracking";
      init.defaultBranch = "main";
    };
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraConfig = ''
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NonText guibg=NONE ctermbg=NONE
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
    ];
  };

}
