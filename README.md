#NixOS Configuration Setup
Give yourself ownership of /etc/nixos:

sudo chown -R xf:users /etc/nixos


Delete the existing files in /etc/nixos. (NOT THE HARDWEARE SCAN)

Copy the new configuration files into /etc/nixos.

put the hardware scan form your new install into your user folder 

Rebuild NixOS using the xf configuration:

sudo nixos-rebuild switch --flake /etc/nixos#xf

If the rebuild fails, retry it.
It may take up to 5 attempts to succeed. Individual builds can take up to an hour.
