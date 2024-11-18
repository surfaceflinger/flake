_: {
  programs.nano = {
    enable = true;
    syntaxHighlight = true;
    nanorc = ''
      set autoindent
      set constantshow
      set indicator
      set linenumbers
      set minibar
      set nohelp
      set numbercolor normal,normal
      set tabsize 2
      set tabstospaces
      set titlecolor normal,normal
    '';
  };
}
