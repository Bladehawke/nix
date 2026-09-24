# hypr-rules.nix — deploys rules.lua
{ ... }: {
  hjem.users.xf = {
    enable = true;
    files = {
      ".config/hypr/rules.lua".text = ''
-- -- -- -- -- -- -- -- -- -- -- --
-- WINDOWS AND WORKSPACES       --
-- -- -- -- -- -- -- -- -- -- -- --

-- Suppress maximize events globally
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix xwayland ghost windows
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Helper launchers float
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    float = true,
})

-- Helper windows float instead of tiling
hl.window_rule({
    name  = "floating-helpers",
    match = { class = "^(pavucontrol|nm-connection-editor|blueman-manager)$" },
    float = true,
})
'';
    };
  };
}
