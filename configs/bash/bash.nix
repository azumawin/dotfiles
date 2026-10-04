{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellOptions = [
      "histappend"
      "extglob"
      "globstar"
      "checkjobs"
      "checkwinsize"
    ];

    initExtra = ''
      set -o vi
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      case "$TERM" in xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";; esac
    '';
  };

  home.sessionPath = [ "$HOME/.local/bin" ];
}
