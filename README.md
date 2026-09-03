# Usage

prerequisites:

- git
- curl
- nix determinate installer

```
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
git clone git@github.com:azumawin/dotfiles.git
cd dotfiles && nix run home-manager/master -- switch --flake .#azuma
```
