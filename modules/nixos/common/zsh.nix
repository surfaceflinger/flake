{ pkgs, ... }:
{
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    histFile = "$HOME/.config/zsh/history";
    histSize = 10000000;
    syntaxHighlighting.enable = true;
    vteIntegration = true;
    setOptions = [
      "autocd" # Automatically cd into typed directory
      "globdots" # Include hidden files in auto/tab complete
      "interactive_comments" # Comments in the shell
      "prompt_subst" # Substitution in the prompt
    ];
    shellAliases = rec {
      awsume = ". ${pkgs.awsume}/bin/awsume";
      cat = "${pkgs.bat}/bin/bat";
      grep = "${pkgs.ripgrep}/bin/rg";
      la = "${ls} --all";
      ll = "${ls} --all --long --header --group";
      llt = "${ll} --tree";
      ls = "${pkgs.eza}/bin/eza --color=auto --group-directories-first --classify";
      lst = "${ls} --tree";
      sshi = "${pkgs.openssh}/bin/ssh -o IdentitiesOnly=yes";
      tree = "${ls} --tree";
    };
    shellInit = ''
      mkdir -p "$HOME/.config/zsh" && touch "$HOME/.config/zsh/history"
      zsh-newuser-install () {}
      lk () {cd "$(${pkgs.walk}/bin/walk "$@")"}
    '';
    promptInit = ''
      autoload -U colors && colors # Enable colors
      HOST=$(${pkgs.inetutils}/bin/hostname) # Fixup for cloud-init sourced hostname
      stty stop undef # Disable ctrl-s to freeze terminal.
      unsetopt PROMPT_SP # Disable empty line before first prompt (BlackBox bug?)
      zstyle ':completion:*' menu select # select-style completions

      # setup prompt with git and awsume integration
      autoload -Uz vcs_info
      precmd() {
          # setup colors
          local awsume_info
          local awsume_info_color="%F{153}"
          local userhost_color="%F{183}"
          local dir_color="%F{225}"
          local prompt_symbol="✨"
          local vcs_info_color="%F{190}"

          if [[ $UID -eq 0 ]]; then
              userhost_color="%F{161}"
              prompt_symbol="😾"
          fi

          # setup awsume + vcs
          if [[ -n "$AWSUME_PROFILE" ]]; then
              awsume_info="$awsume_info_color☁️  $AWSUME_PROFILE%f "
          fi
          zstyle ":vcs_info:git:*" formats "''${vcs_info_color}🌸 %b%f "
          vcs_info

          # setup prompt
          local BASE="$userhost_color%n@%m %f[$dir_color%~%f] $vcs_info_msg_0_$awsume_info"

          # don't use colors/emojis on dumb terminals
          case $TERM in
          xterm*)
              PS1="$BASE$prompt_symbol ";;
          *)
              PS1=$(echo "$BASE%# " | tr -cd "[:print:]");
          esac
      }

      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
    '';
  };
}
