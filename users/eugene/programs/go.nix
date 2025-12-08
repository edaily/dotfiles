{ config, lib, pkgs, ... }:

{
  programs.go = {
    enable = true;
    env.GOPATH = "code/go";
  };
}
