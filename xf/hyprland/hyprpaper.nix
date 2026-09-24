{ ... }: {
  hjem.users.xf = {
    enable = true;
    files = {
      ".config/hypr/hyprpaper.conf".text = ''
        splash = false

        preload = /etc/nixos/xf/hyprland/image.png

        wallpaper {
            monitor = DP-2
            path = /etc/nixos/xf/hyprland/image.png
        }

        wallpaper {
            monitor = DP-3
            path = /etc/nixos/xf/hyprland/image.png
        }
      '';
    };
  };
}
