{ ... }:

{
  environment.variables = {
    NIXOS_OZONE_WL = "1"; # Electron/Chromium on Wayland
    MOZ_ENABLE_WAYLAND = "1"; # Firefox Wayland
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # allow software rendering in VMs
    WLR_NO_HARDWARE_CURSORS = "1"; # fixes invisible cursor in some VMs
    LIBGL_ALWAYS_SOFTWARE =
      "1"; # Force software rendering for all apps (fixes Ghostty/Walker crashes)
  };
}
