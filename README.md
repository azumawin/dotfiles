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
