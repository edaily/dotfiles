{ inputs, ... }:

{
  imports =
    [ ./git.nix ./go.nix ./neovim.nix ./nushell.nix ./rofi.nix ./starship.nix ];
}
