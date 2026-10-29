{ pkgs, ... }:
{
  # ~/.vimrc rather than the xdg path: this same file gets scp'd to or stowed on
  # machines whose vim predates xdg support, and it has to be read there too.
  home.file.".vimrc".source = ../stowable-configs/vim/.vimrc;

  # vim-full for the clipboard and +python builds. the vimrc itself needs nothing
  # beyond stock vim, it's the no-sudo-no-plugins fallback for other machines.
  home.packages = with pkgs; [ vim-full ];
}
