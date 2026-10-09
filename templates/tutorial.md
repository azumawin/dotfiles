# quick philosophy

- sdks (compilers, runtimes, interpreters, etc.), dev tools (language servers, linters, formatters,
  etc.) are a per project concern and should not be installed globally on your machine.
  - why: because when a project owns everything it needs to be developed and built it's easy to
    reproduce the environment which eliminates "it works on my machine" bugs and makes deploying
    easier, it makes onboarding easier because devs dont have to install things on their machine
    globally, because when they're versioned in the repo there's a tool to install them too, and
    also it just feels "correct" and "pure" for me.
- there should only be 1 `flake.nix` per project.
  - why: the purpose of a `flake.nix` in a project is to setup the environment for that project,
    which may use more than 1 ecosystem (for example my uni notes use python and latex). there are
    per-ecosystem templates in this directory, but they're used as starting points for
    multi-ecosystem projects.

# dependency layers of a project

language package manager owns:

- libraries + dev tools that the whole team (including CI) must share (linters, formatters)

`flake.nix` owns:

- everything else that the project needs for development, building, running
  - sdks
  - native libraries (because most language package managers ship precompiled binaries for
    manylinux, which expect the standard FHS and certain libraries to already exist, so as a nixos
    user you have to have `nix-ld` enabled).
  - language servers - most controversial one because technically they're part of the ecosystem,
    though not always. so it could live in both places, but i like putting it in `flake.nix` because
    of the "not always" and also to serve non-vscode editors.
  - postgres, redis, and other project specific tooling that package manager can't do

if everyone uses nix then language package manager just owns the libraries and all tooling goes into
`flake.nix`.

# notes

templates ship `flake.lock` so package versions are pinned to the locked revision unless you do
`nix flake update`.

template usage:

```
mkdir myproj && cd myproj
nix flake init -t ~/dotfiles#python
```
