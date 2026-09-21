These dotfiles are distro agnostic (any non-NixOS Linux) as long as the requirements are installed.

These dotfiles are hardcoded for `x86_64-linux`, if you're using a different architecture just
change `system` in `flake.nix`. If you're not me, you also need to change `home.username` and
`home.homeDirectory` in `home.nix`, and `homeConfigurations."azuma"` in `flake.nix` - the name there
is what you pass after the `#` in `--flake .#azuma`.

Home manager installs the language servers, formatters and linters that nvim expects on `PATH`
(mason is gone - `home.nix` owns that list now and `flake.lock` pins it) plus the runtimes and other
nvim/zellij/kitty utilities, every other runtime and dev tool should be in a per project
`flake.nix`.

Note that this config is made with rollbackability in mind so interactively editing config files
like `~/.claude/settings.json` through claude for example, wont work because the file claude will
try to edit is the current config generation which is inside the readonly `/nix/store/`

Note that it's assumed that these dotfiles live at `~/dotfiles`, some things may break otherwise,
for example nvim config keymap, also lazy is configured to put lazy-lock.json there.

# Bootstrapping

```
git clone https://github.com/azumawin/dotfiles.git ~/dotfiles
cd ~/dotfiles
nix run home-manager/master -- switch --flake .#azuma
```

# Creating a generation

note: cd into dotfiles dir first.

system:

```
sudo nixos-rebuild switch --flake .#vm
```

where vm can be changed for the hostname that you wish to create the generation for

user space:

```
home-manager switch --flake .#azuma
```

# TODO

- apps that have their own config as dotfiles go as packages / etc. apps that have their config
  through nix fields (for example way easier to configure firefox through nix options) go as
  program.enable, apps that have no config at all go as packages It collapses to one question. Cases
  1 and 3 both land on home.packages, so what you've actually got is: is Nix owning this app's
  config? Yes → programs.X.enable. No (either because you write a dotfile, or because there's no
  config at all) → home.packages.

  Stated that way it's also self-enforcing, because the failure mode is a real error rather than a
  style opinion. programs.kitty writes xdg.configFile."kitty/kitty.conf" (kitty.nix:413) and
  programs.zellij owns its config the same way — enable either and it collides with the
  xdg.configFile."kitty" / "zellij" entries you already have. The rule isn't just tidiness; the two
  options are genuinely mutually exclusive per app.

  The one gap: "no config at all → packages" holds only when the module is just an installer. Some
  modules give you things that aren't config — a systemd user service, a shell hook, cross-program
  wiring. There the module is worth enabling even with nothing to configure. the weird thing with
  this is that home-manager should be enabled as a program even tho it has no config i think its an
  exception tho because of the wiring or smth. i need to more strictly define the logic of which way
  to use to install software on nix depending on: does nix own the config? is it meant to exist for
  this user or for the whole system? then i like to group tools that could potentially be owned by
  nix in the future in apps.nix under a different comment

- flake.nix should determine my system from hardware-configuration.nix or something, i shouldnt have
  to hardcode it.

- i put some things in programs.enable and some things as packages, i decided randomly so thats not
  good and need to fix.

- will need to update lazy lockfile location in init.lua:58 becuase i changed the dotfile structure,
  i need to think of a better solution than currently, either put all stuff like this that expects a
  specific thing into one file, document it, or figure out something smarter.

- will need to change nvim <leader>fc dir to point to correct location of dotfiles sinc ei updated
  it

- i dont like the awkward tension of installing runtimes per project but installing lsps globally
  into my user space, idk yet what the right thing to do here is.

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
