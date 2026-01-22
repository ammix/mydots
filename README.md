# README

This is my personal home-manager x stow setup.

## [System Setup](./justfile)

First stow using for the DE less setup.

```bash
    just init
```
Then setup libvirt group

```bash
    sudo groupadd --system libvirt
```
## YubiKey

Save keys for local pam auth to work.

```bash
    pamu2fcfg > ~/.config/Yubico/u2f_keys
```
### Cheat-Sheet

```bash
sops home/secrets/secrets.yaml  # Edit secrets file
```
