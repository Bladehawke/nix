# mako.nix — notification styling to match the system theme
{ ... }: {
  hjem.users.xf = {
    enable = true;
    files = {
      ".config/mako/config".text = ''
# Cozy pink theme — matches waybar / fuzzel / borders
font=JetBrainsMono Nerd Font 11
background-color=#1e0828ee
text-color=#ffd9f0
border-size=2
border-color=#ff8cc6
border-radius=16
padding=12
margin=8,12
width=380
height=120
markup=1
icon-path=/run/current-system/sw/share/icons/Papirus-Dark
icons-location=right
max-icon-size=56
default-timeout=6000
layer=overlay
'';
    };
  };
}
