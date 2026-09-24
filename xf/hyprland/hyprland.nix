# hyprland.nix — entry: autostart, environment, module loading
{ pkgs, ... }: {
  hjem.users.xf = {
    enable = true;
    files = {
      ".config/hypr/hyprland.lua".text = ''
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- COZY PINK CONFIG                          --
-- entry point: modules live in separate files --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- See https://wiki.hypr.land/Configuring/Start/

-- Modules
require("appearance")
require("input")
require("rules")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
--  hl.exec_cmd("waybar")
--  hl.exec_cmd("hyprpaper")
    hl.exec_cmd("protonvpn-app")
    hl.exec_cmd("/run/current-system/sw/bin/polkit-gnome-authentication-agent-1")
-- PS3 animated wallpaper
    hl.exec_cmd("mpvpaper -o 'no-audio --loop-playlist=yes --cache=no --vd-lavc-threads=1 --keep-open=yes' '*' /etc/nixos/xf/hyprland/ps3_wave_4k.mp4")
    hl.exec_cmd("dms run")
-- GDK theme settings — libadwaita reads these on Wayland (dconf/gsettings)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Pink-Dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark")
    hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")


    hl.env("XCURSOR_SIZE", "24")
end)
'';

      # GTK3 fallback — apps that don't read dconf
      ".config/gtk-3.0/settings.ini".text = ''
[Settings]
gtk-theme-name=Colloid-Pink-Dark
gtk-icon-theme-name=Papirus-Dark
gtk-application-prefer-dark-theme=true
gtk-cursor-theme-name=Adwaita
gtk-font-name=JetBrainsMono Nerd Font 11
'';

      # GTK4 fallback
      ".config/gtk-4.0/settings.ini".text = ''
[Settings]
gtk-theme-name=Colloid-Pink-Dark
gtk-icon-theme-name=Papirus-Dark
gtk-application-prefer-dark-theme=true
gtk-font-name=JetBrainsMono Nerd Font 11
'';
    };
  };
}
