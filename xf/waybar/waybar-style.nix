# waybar-style.nix
{ ... }:
let
  accent = "#ff2fa0";
  accentSoft = "#ff8cc6";
  bg = "rgba(30, 8, 40, 0.6)";
in
{
  hjem.users.xf = {
    enable = true;
    files = {
      ".config/waybar/style.css".text = ''
        * {
            font-family: "JetBrainsMono Nerd Font", sans-serif;
            font-size: 14px;
            font-weight: 600;
        }

        window#waybar {
            background: ${bg};
            border-radius: 0 0 18px 18px;
            border: 2px solid ${accentSoft};
            box-shadow: 0 0 2px rgba(255, 47, 160, 0.3);
            color: #ffd9f0;
        }

        /* General modules */
        #workspaces button,
        #custom-greeting,
        #clock,
        #cpu,
        #memory,
        #custom-break,
        #custom-hydrate,
        #pulseaudio,
        #network,
        #tray {
            background: rgba(255, 140, 198, 0.1);
            color: #ffe3f5;
            border-radius: 14px;
            padding: 2px 14px;
            margin: 4px 3px;
            text-shadow: 0 0 4px rgba(255, 140, 198, 0.5);
            transition: all 0.3s ease;
        }

        /* Workspace hover */
        #workspaces button:hover {
            background: rgba(255, 140, 198, 0.3);
            box-shadow: 0 0 2px ${accentSoft};
        }

        /* Other module hover */
        #clock:hover,
        #cpu:hover,
        #memory:hover {
            background: rgba(255, 140, 198, 0.3);
            box-shadow: 0 0 6px ${accentSoft};
        }

        #workspaces button.active {
            background: ${accent};
            color: #1e0828;
            font-weight: 800;
            box-shadow: 0 0 2px ${accent};
        }

        /* CPU */
        #cpu {
            color: #ffb8dc;
        }

        /* RAM */
        #memory {
            color: #ffc7e5;
        }

        /* Hydrate reminder */
        #custom-hydrate {
            animation: breathe 4s ease-in-out infinite;
        }

        /* Offline network */
        #network.disconnected {
            color: #ff6b6b;
            animation: blink 0.8s infinite alternate;
        }

        @keyframes breathe {
            0%   { opacity: 0.85; }
            50%  { opacity: 1; text-shadow: 0 0 7px ${accentSoft}; }
            100% { opacity: 0.85; }
        }

        @keyframes blink {
            from { opacity: 1; }
            to   { opacity: 0.45; }
        }
      '';
    };
  };
}
