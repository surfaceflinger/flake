{ pkgs, ... }: {
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    setOptions = [
      "autocd" # Automatically cd into typed directory
      "globdots" # Include hidden files in auto/tab complete
      "interactive_comments" # Comments in the shell
      "prompt_subst" # Substitution in the prompt
    ];
    enableCompletion = false;
    histFile = "$HOME/.config/zsh/history";
    histSize = 10000000;
    syntaxHighlighting.enable = true;
    vteIntegration = true;
    shellAliases = rec {
      awsume = ". ${pkgs.awsume}/bin/awsume";
      cat = "${pkgs.bat}/bin/bat";
      grep = "${pkgs.ripgrep}/bin/rg";
      ls = "${pkgs.eza}/bin/eza --color=auto --group-directories-first --classify";
      lst = "${ls} --tree";
      la = "${ls} --all";
      ll = "${ls} --all --long --header --group";
      llt = "${ll} --tree";
      tree = "${ls} --tree";
    };
    shellInit = ''
      mkdir -p "$HOME/.config/zsh" && touch "$HOME/.config/zsh/history"
      zsh-newuser-install () {}
      lk () {cd "$(${pkgs.walk}/bin/walk "$@")"}
    '';
    promptInit = ''
      # Fixup for cloud-init sourced hostname
      HOST=$(${pkgs.inetutils}/bin/hostname)

      unsetopt PROMPT_SP # Disable empty line before first prompt (BlackBox bug?)
      autoload -U colors && colors # Enable colors
      stty stop undef # Disable ctrl-s to freeze terminal.

      # auto/tab complete
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit

      # Setup prompt with git integration
      autoload -Uz vcs_info
      zstyle ':vcs_info:git:*' formats 'on %b '
      precmd() {
        vcs_info
        BASE="%F{bg-blue}%n@%m %f[%F{white}%~%f] %F{green}$vcs_info_msg_0_%f"
        if [[ $UID -eq 0 ]]; then
          PS1="%F{bg-red}%n@%m %f[%F{white}%~%f] %F{green}$vcs_info_msg_0_%f%# "
        else
          case $TERM in
          xterm*)
            PS1='$BASE✨ ';;
          *)
            PS1='$BASE%# ';;
          esac
        fi
      }

      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
    '';
  };
}
