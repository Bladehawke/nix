# hypr-appearance.nix — deploys appearance.lua
{ ... }: {
  hjem.users.xf = {
    enable = true;
    files = {
      ".config/hypr/appearance.lua".text = ''
-- -- -- -- -- -- -- -- -- -- -- -- --
-- APPEARANCE — warm, soft, pink   --
-- -- -- -- -- -- -- -- -- -- -- -- --

------------------
---- COLORS ------
------------------

-- The pink palette. Keep in sync with waybar-style.nix
local accentA  = "rgba(ff2fa0ee)"  -- hot pink
local accentB  = "rgba(ff8cc6ee)"  -- soft pink highlight
local inactive = "rgba(58384baa)"
local plumBg   = "rgba(1e0828aa)"

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@240",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-3",
    mode     = "3840x2160@60",
    position = "1920x0",
    scale    = 2,
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Softer gaps and thinner borders: cozy, breathing room
hl.config({
    general = {
        gaps_in  = 8,
        gaps_out = 18,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(ff2fa0ee)", "rgba(ff8cc6ee)" }, angle = 45 },
            inactive_border = "rgba(58384baa)",
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 18,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.97,

        shadow = {
            enabled      = true,
            range        = 24,
            render_power = 3,
            color        = "rgba(1e0828aa)",
        },

        blur = {
            enabled           = true,
            size              = 7,
            passes            = 3,
            vibrancy          = 0.18,
            vibrancy_darkness = 0.25,
            brightness        = 0.95,
            noise             = 0.01,
            xray              = false,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves: springy and soft, nothing snappy
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Springs
hl.curve("easy",  { type = "spring", mass = 1,   stiffness = 71.2633,  dampening = 15.8273644 })
hl.curve("boing", { type = "spring", mass = 0.8, stiffness = 120,      dampening = 14 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 5,    spring = "boing" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.5,  spring = "boing",        style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2.2,  bezier = "almostLinear",  style = "slidefade vert" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Layouts
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

-- Misc: quiet and cozy, no branding
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo    = true,
    },
})
'';
    };
  };
}
