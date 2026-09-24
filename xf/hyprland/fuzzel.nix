# fuzzel.nix — launcher theme to match system (plum/pink)
{ ... }: {
  hjem.users.xf = {
    enable = true;

    files = {
      ".config/fuzzel/fuzzel.ini".text = ''
        [colors]
        background=1e0828ee
        text=ffd9f0ff
        match=ff2fa0ff
        selection=ff2fa0ff
        selection-text=1e0828ff
        border=ff8cc6ff

        [main]
        font=JetBrainsMono Nerd Font:size=12
        layer=overlay
        prompt="❯ "
        anchor=top
        x-margin=12
        y-margin=12
        lines=10
        width=35
        inner-pad=14
        horizontal-pad=18
        vertical-pad=10

        [border]
        width=2
        radius=8
      '';
    };
  };
}
