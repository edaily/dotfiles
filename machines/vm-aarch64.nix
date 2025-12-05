{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware/vm-aarch64.nix
    ./vm-shared.nix
  ];

  boot.binfmt.emulatedSystems = ["x86_64-linux"];
  networking.interfaces.ens192.useDHCP = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  virtualisation.vmware.guest.enable = true;

  # Share our host filesystem
  fileSystems."/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:/";
    options = [
      "umask=22"
      "uid=1000"
      "gid=1000"
      "allow_other"
      "auto_unmount"
      "defaults"
    ];
  };
}
