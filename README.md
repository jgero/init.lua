# Neovim config as nix flake

Complete neovim setup with langauge servers, git integration, file searching and
navigation and keybinding cheat sheet.

## Use it

> Cloned locally: `nvim = "nix run ~/projects/init.lua --";`
> Remote: `nix run github:jgero/init.lua/stable --`

While the master branch of the flake is mostly stable, there is a stable branch
as well. It's useful to alias both of them anyways to have a fallback when
working on the configuration and everything breaks.

## Sources

- https://primamateria.github.io/blog/neovim-nix/#custom-neovim-package

