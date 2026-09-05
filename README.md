These dotfiles are distro agnostic (any non-NixOS Linux) as long as the requirements are installed.

These dotfiles are hardcoded for `x86_64-linux`, if you're using a different architecture just
change `system` in `flake.nix`. If you're not me, you also need to change `home.username` and
`home.homeDirectory` in `home.nix`, and `homeConfigurations."azuma"` in `flake.nix` - the name there
is what you pass after the `#` in `--flake .#azuma`.

Home manager only installs runtimes that nvim-mason requires to install language servers and other
nvim/zellij/kitty utilities, every other runtime and dev tool should be in a per project
`flake.nix`.

Note that this config is made with rollbackability in mind so interactively editing config files
like `~/.claude/settings.json` through claude for example, wont work because the file claude will
try to edit is the current config generation which is inside the readonly `/nix/store/`

# Requirements

packages:

- git
- curl
- [nix determinate installer](https://docs.determinate.systems/)

a bootstrap expects a clean install, so these paths and files must not exist:

```
~/.config/nvim
~/.config/zellij
~/.config/kitty
~/.claude/CLAUDE.md
~/.claude/settings.json
~/.bashrc
~/.gitconfig
```

note that some distros ship a default bash config, so even on a clean install you may need to delete
it or use a `-b backup` flag - which will append a `.backup` extension to the existing file and
place the file from this repo as the active one (only use it on the first run tho)

fonts are installed by home manager, so nothing needs to be on the host for kitty or the nerd font
glyphs in nvim/zellij to render.

# Bootstrapping

```
git clone https://github.com/azumawin/dotfiles.git ~/dotfiles
cd ~/dotfiles
nix run home-manager/master -- switch --flake .#azuma
```

note this bootstraps with home manager `master`, not the revision pinned in `flake.lock` - only the
very first activation, every switch after this uses the pinned one.

# Versioning your config after bootstrapping

open a new shell first: `home-manager` lives in `~/.nix-profile/bin`, which the `.bashrc` from this
repo puts on `PATH`, so it isn't there yet in the shell you bootstrapped from.

after making a change to the config you must do:

```
home-manager switch --flake .#azuma
```

# Restoring your original config

Home manager won't restore your `.backup` files for you, so you'll have to do it yourself:

- `home-manager uninstall`
- `mv ~/<file>.backup ~/<file>` for all files/directories you wish to restore

# notes for future me

i used virtualbox with debian 13 iso to test it

make sure the vm is turned off before snapshotting/restoring

commands that i used to snapshot:

```
VBoxManage snapshot "debian13" take pristine
```

to restore the snapshot:

```
VBoxManage snapshot "debian13" restore pristine
```

# TODO

- improve CLAUDE.md and settings.json with guardrails, i want 2 modes that i could switch between.
  1: can only access current directory. 2: can access whatever is needed, usually when im fixing
  config problems in ~/dotfiles/
- use nix to install lsp related packages from mason into home environment and drop the entire mason
  stack from nvim.
