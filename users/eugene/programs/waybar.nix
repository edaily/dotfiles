{ config, lib, pkgs, ... }:

let
  isLinux = pkgs.stdenv.isLinux;
in {
  programs.waybar = {
    enable = isLinux;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 0;
        
        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" ];

        tray = {
          show-passive-items = true;
          icon-size = 20;
        };

        "niri/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            active = "";
            default = "";
          };
        };

        clock = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };

        pulseaudio = {
          format = "vol {volume} {format_source}";
          format-bluetooth = "volb {volume} {format_source}";
          format-bluetooth-muted = "volb {format_source}";
          format-muted = "vol {format_source}";
          format-source = "mic {volume}";
          format-source-muted = "mic";
        };
      };
    };

    style = ''
      window#waybar {
          background-color: rgba(0, 0, 0, 0.9);
          color: #ffffff;
      }

      * {
          border: none;
          border-radius: 0;
          font-size: 13px;
          min-height: 0;
          font-family: "Roboto", "Font Awesome 5 Free";
      }
    '';
  };
}
