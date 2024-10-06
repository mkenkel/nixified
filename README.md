# Nixified

### Space serving to be a dotfile/configuration haven for everything configuration-based.

##### Converting from 'imperative' to 'declarative' with the number of growing *nix devices I continue to interact with.


## Prerequisites
- Darwin/Mac users, please be sure to have already run the [nix-installer](https://github.com/DeterminateSystems/nix-installer) from DeterminateSystems.

## Install notes
> [!WARNING]
> Before running these, be sure either the hostname is changed within the files, or that the hostname of your system matches what's defined in the configurations!

### 1. NixOS Install
```sh
sudo nixos-rebuild --flake #.$HOST switch
```

### 2. Darwin Install
```sh
nix run nix-darwin -- switch --flake .#$(scutil --get LocalHostName)
```
