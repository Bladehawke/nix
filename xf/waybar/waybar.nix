# waybar-config.nix
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fuzzel
    wireplumber
    networkmanager
    bluez
    blueman
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hjem.users.xf = {
    enable = true;

    files.".config/waybar/config.jsonc".text = builtins.toJSON {
      layer = "top";
      position = "top";
      height = 40;
      spacing = 6;
      margin-top = 0;
      margin-left = 0;
      margin-right = 0;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "custom/controls" "tray" ];

      "hyprland/workspaces" = {
        format = "{name}";
        format-icons = { default = ""; active = ""; urgent = ""; };
        persistent-workspaces = { "*" = 5; };
      };

      clock = {
        format = "{:%a %d %b  •  %H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        interval = 1;
      };

      cpu = {
        format = "CPU {usage}%";
        interval = 2;
        tooltip = true;
        tooltip-format = "CPU usage: {usage}%";
      };

      memory = {
        format = "RAM {percentage}%";
        interval = 2;
        tooltip = true;
        tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
      };

      "custom/controls" = {
        format = "+";
        tooltip = true;
        tooltip-format = "Audio • Network • Bluetooth";
        on-click = "/home/xf/.local/bin/controls";
      };

      tray = { icon-size = 18; spacing = 8; };
    };

    files.".local/bin/controls" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        choice="$(
          printf '%s\n' 'Audio' 'Network' 'Bluetooth' |
          fuzzel --dmenu --prompt "Controls > "
        )"

        case "$choice" in
          Audio)
            selected="$(
              wpctl status | sed -n '/Sinks:/,/Sources:/p' |
              grep -E '^[[:space:]]*[0-9]+\.' |
              sed -E 's/^[[:space:]]*[0-9]+\. //' |
              fuzzel --dmenu --prompt "Output > "
            )"
            [ -z "$selected" ] && exit 0
            sink_id="$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -F "$selected" | grep -oE '[0-9]+' | head -1)"
            [ -n "$sink_id" ] && wpctl set-default "$sink_id"
            ;;

          Network)
            selected="$(
              nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list |
              awk -F: '{ used = ($1 == "*") ? "✓ " : "  "; if ($2 != "") printf "%s%s  %s%%  %s\n", used, $2, $3, $4 }' |
              fuzzel --dmenu --prompt "Wi-Fi > "
            )"
            [ -z "$selected" ] && exit 0
            ssid="$(printf '%s\n' "$selected" | sed -E 's/^✓ //; s/^  //; s/[[:space:]]+[0-9]+%[[:space:]]+[^[:space:]]+$//')"
            [ -n "$ssid" ] && nmcli device wifi connect "$ssid"
            ;;

          Bluetooth)
            selected="$(bluetoothctl devices | sed 's/^Device [^ ]* //' | fuzzel --dmenu --prompt "BT > ")"
            [ -z "$selected" ] && exit 0
            mac="$(bluetoothctl devices | grep -F "$selected" | awk '{print $2}')"
            [ -n "$mac" ] && bluetoothctl connect "$mac"
            ;;
        esac
      '';
    };
  };
}
