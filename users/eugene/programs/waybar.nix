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
        spacing = 10;
        
        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" ];

        tray = {
          show-passive-items = true;
          icon-size = 20;
        };

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };
        
        pulseaudio = {
          tooltip = false;
          format = "  {volume}%";
          format-bluetooth = " {volume}%";
          format-bluetooth-muted = " {volume}%";
          format-muted = "X {volume}%";
          format-source = "{volume}% ";
          format-source-muted = " ";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              "░░░░░░░░░░"
              "█░░░░░░░░░"
              "██░░░░░░░░"
              "███░░░░░░░"
              "████░░░░░░"
              "█████░░░░░"
              "██████░░░░"
              "███████░░░"
              "████████░░"
              "█████████░"
              "██████████"
            ];
          };
          interval = 60;
          on-click = "pamixer --toggle-mute";
          on-scroll-up = "pamixer --allow-boost --set-limit 150 --increase 2";
          on-scroll-down = "pamixer --allow-boost --set-limit 150 --decrease 2";
        };


      };
    };

    style = ''
      window#waybar {
          background: rgba(18, 18, 28, 0.9);
          color: #cdd6f4;
      }

      * {
          border: none;
          border-radius: 0;
          font-size: 13px;
          min-height: 0;
      }
    '';
  };
}
