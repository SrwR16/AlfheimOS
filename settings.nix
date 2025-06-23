{pkgs, inputs, ...}:
rec {
    system = "x86_64-linux";
    hostname = "alfheim"; # Hostname
    username = "serpentian"; # Username
    profile = "desktop"; # Select from profiles directory
    timezone = "Europe/Moscow"; # Select timezone
    locale = "en_US.UTF-8"; # Select locale
    name = "Nikita Zheleztsov"; # Name (git config)
    email = "n.zheleztsov@proton.me"; # Email (git config)
    dotfilesDir = "/home/${username}/.dotfiles"; # Absolute path of the repo;

    theme = "catppuccin"; # Selected theme from home/shared/themes directory
    themeDetails = import (./. + "/home/shared/themes/${theme}.nix") {inherit pkgs;};

    shell = "zsh"; # See home/shared/shells directory.
    shellPkg = pkgs.zsh;

    wms = ["hyprland"]; # See home/shared/desktop/ and modules/system/desktop directories.
    editors = ["neovim"]; # See home/shared/programs/editors directory.
    browsers = ["zen-browser"]; # See home/shared/programs/browsers directory.
    preferredEditor = "nvim"; # Session variable $TERM.
    preferredBrowser = "zen"; # Session variable $BROWSER.
}
