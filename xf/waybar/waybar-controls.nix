{ ... }: {
  hjem.users.xf = {
    enable = true;

    files.".local/bin/waybar-controls" = {
      executable = true;

      text = ''
        #!/usr/bin/env bash

        choice="$(
          printf '%s\n' \
            'Audio' \
            'Network' \
            'Bluetooth' |
            fuzzel --dmenu --prompt "Controls > "
        )"

        case "$choice" in

          Audio)
            selected="$(
              wpctl status |
                sed -n '/Sinks:/,/Sources:/p' |
                grep -E '^[[:space:]]*[0-9]+\.' |
                sed -E 's/^[[:space:]]*[0-9]+\. //' |
                fuzzel --dmenu --prompt "Audio output > "
            )

            [ -z "$selected" ] && exit 0

            sink_id="$(
              wpctl status |
                sed -n '/Sinks:/,/Sources:/p' |
                grep -F "$selected" |
                grep -oE '[0-9]+' |
                head -1
            )

            [ -n "$sink_id" ] && wpctl set-default "$sink_id"
            ;;


          Network)
            selected="$(
              nmcli -t \
                -f IN-USE,SSID,SIGNAL,SECURITY \
                device wifi list |
                awk -F: '
                  {
                    used = ($1 == "*") ? "✓ " : "  ";

                    if ($2 != "")
                      printf "%s%s  %s%%  %s\n",
                        used, $2, $3, $4
                  }
                ' |
                fuzzel --dmenu --prompt "Wi-Fi > "
            )

            [ -z "$selected" ] && exit 0

            ssid="$(
              printf '%s\n' "$selected" |
                sed -E \
                  's/^✓ //;
                   s/^  //;
                   s/[[:space:]]+[0-9]+%[[:space:]]+[^[:space:]]+$//'
            )

            [ -n "$ssid" ] &&
              nmcli device wifi connect "$ssid"
            ;;


          Bluetooth)
            selected="$(
              bluetoothctl devices |
                sed 's/^Device [^ ]* //' |
                fuzzel --dmenu --prompt "Bluetooth > "
            )

            [ -z "$selected" ] && exit 0

            mac="$(
              bluetoothctl devices |
                grep -F "$selected" |
                awk '{print $2}'
            )

            [ -n "$mac" ] &&
              bluetoothctl connect "$mac"
            ;;

        esac
      '';
    };
  };
}
