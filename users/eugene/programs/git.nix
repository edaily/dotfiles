{ config, lib, pkgs, ... }:

{
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
}
