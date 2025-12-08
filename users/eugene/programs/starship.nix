{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    
    settings = {
      # Format: configure what modules are shown
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$golang"
        "$lua"
        "$nodejs"
        "$python"
        "$rust"
        "$nix_shell"
        "$line_break"
        "$character"
      ];

      # Don't print a new line at the start of the prompt
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold cyan";
      };

      git_branch = {
        symbol = " ";
        style = "bold purple";
      };

      git_status = {
        style = "bold yellow";
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "$";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };

      golang = {
        symbol = " ";
        style = "bold cyan";
      };

      nix_shell = {
        symbol = " ";
        format = "via [$symbol$state]($style) ";
        style = "bold blue";
      };

      nodejs = {
        symbol = " ";
        style = "bold green";
      };

      python = {
        symbol = " ";
        style = "bold yellow";
      };

      rust = {
        symbol = " ";
        style = "bold red";
      };

      lua = {
        symbol = " ";
        style = "bold blue";
      };

      username = {
        show_always = false;
        style_user = "bold yellow";
        style_root = "bold red";
      };

      hostname = {
        ssh_only = true;
        style = "bold green";
      };
    };
  };
}
