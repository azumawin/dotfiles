# TODO

- will need to change nvim <leader>fc dir to point to correct location of dotfiles sinc ei updated
  it

- track brave config in a json as well

- flake.nix should determine my system from hardware-configuration.nix or something, i shouldnt have
  to hardcode it.

- i put some things in programs.enable and some things as packages, i decided randomly so thats not
  good and need to fix.

- java setup with ftplugin is deprecated for now, will fix next time i need it.

- i want to learn how to open side panels fast in zellij/tmux and turn it off fast, then turn the
  same one back on without destroying the order

- improve CLAUDE.md and settings.json with guardrails, i want 2 modes that i could switch between.
  1: can only access current directory. 2: can access whatever is needed, usually when im fixing
  config problems in ~/dotfiles/

- move latex styles here

- setup latex snippets eventually

- move to tmux

- setup vim fugitive and smth for viewing diffs

- Vim / Neovim (vim-fugitive)If you prefer working entirely in the terminal but want a buffer-based
  experience, the vim-fugitive plugin is the industry standard.How to use it:Open your project in
  Vim and type :Gdiffsplit (or :G).This opens a split buffer showing your working copy vs. the
  index.Visually select the lines you want to stage using V (Visual Line mode).Type :diffput (or use
  the shortcut dp) to push those lines into the staging buffer. Save and close.
