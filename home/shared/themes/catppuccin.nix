{ pkgs, ...}:
{
    themeName = "catppuccin-mocha";
    wallpaper = ../../../assets/wallpapers/evening-sky.png;
    # Stylix palette override.
    override = {
        base00 = "11111b";
    };

    # Override stylix theme of btop.
    btopTheme = "catppuccin";

    # Hyprland and ags.
    opacity = 0.8; # affects theme.blur in ags.
    rounding = 25; # affects theme.rounding in ags.
    shadow = false; # affects theme.shadows in ags.
    bordersPlusPlus = false;

    # Override default settings in ags.
    ags = {
        theme = {
            palette = {
                widget = "#25253a";
            };
            border = {
                width = 1;
                opacity = 96;
            };
        };
        bar = {
            curved = true;
        };
        widget = {
            opacity = 0;
        };
    };

    font = "FiraCode Nerd Font"; # Selected font
    fontPkg = (pkgs.nerd-fonts.fira-code);
    fontSize = 13; # Font size

    icons = "Papirus";
    iconsPkg = pkgs.papirus-icon-theme;
}
