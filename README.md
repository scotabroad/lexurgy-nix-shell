# Lexurgy Nix Shell

## About
This repository features the tools to enable the Lexurgy sound change applier inside a Nix shell.

To know more about Lexurgy, see [here](https://github.com/def-gthill/lexurgy).

## Usage
Note: Must have enabled experimental nix-commands in your Nix configuration

### Flakes
Either of the two commands below will enter a Nix shell with lexurgy

`nix develop --no-write-lock-file github:scotabroad/lexurgy-nix-shell`

`nix shell github:scotabroad/lexurgy-nix-shell`
