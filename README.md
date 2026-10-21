My NixOS dotfiles.

This config is made with rollbackability in mind so interactively editing config files like
`~/.claude/settings.json` through claude for example, wont work because the file claude will try to
edit is the current config generation which is inside the readonly `/nix/store/`

Note that it's assumed that these dotfiles live at `~/dotfiles`, some things may break otherwise,
for example nvim config keymap, also lazy is configured to put lazy-lock.json there.

These dotfiles setup KDE through plasma-manager.

# Bootstrapping

```
git clone https://github.com/azumawin/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo nixos-rebuild switch --flake .#<host>
```

# Cleaning up old generations (keep 5 most recent)

drop old system generations:

```
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
```

actually garbage collect the outdated generations:

```
sudo nix-collect-garbage
```

clean up bootloader so it doesnt show generations that dont exist anymore:

```
sudo /run/current-system/bin/switch-to-configuration boot
```
