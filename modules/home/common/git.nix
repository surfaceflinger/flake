{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    signing = {
      key = "~/.ssh/id_ed25519";
      signByDefault = true;
    };
    extraConfig = {
      core.editor = with pkgs; (lib.getExe nano);
      gpg.format = "ssh";
      http.postBuffer = 524288000;
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
