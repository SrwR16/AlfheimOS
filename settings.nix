{pkgs, inputs, ...}:
rec {
    # Primary user configuration
    primaryUser = "sarw";

    # System architecture
    system = "x86_64-linux";

    # System configuration
    hostname = "X"; # Hostname
    username = primaryUser; # Username
    profile = "laptop"; # Select from hosts/ and home/profiles/ directories
    stateVersion = "24.05"; # NixOS state version

    # User configurations
    users = {
        sarw = {
            avatar = ../assets/avatars/makise.png; # Using existing avatar from assets
            email = "sarrwar16@gmail.com";
            fullName = "SARWAR";
            gitKey = "0x2226229F5F5AB870";
            name = "sarw";

            # System configuration for this user
            system = {
                # Time and locale
                timeZone = "Asia/Dhaka";
                locale = {
                    default = "en_US.UTF-8";
                    extra = {
                        LC_ADDRESS = "en_US.UTF-8";
                        LC_IDENTIFICATION = "en_US.UTF-8";
                        LC_MEASUREMENT = "en_US.UTF-8";
                        LC_MONETARY = "en_US.UTF-8";
                        LC_NAME = "en_US.UTF-8";
                        LC_NUMERIC = "en_US.UTF-8";
                        LC_PAPER = "en_US.UTF-8";
                        LC_TELEPHONE = "en_US.UTF-8";
                        LC_TIME = "en_US.UTF-8";
                    };
                };
                keyMap = "us";
            };
        };
    };

    # Legacy compatibility fields (for existing configuration)
    timezone = users.sarw.system.timeZone;
    locale = users.sarw.system.locale.default;
    name = users.sarw.fullName;
    gitusername = "SrwR16";
    email = users.sarw.email;
    dotfilesDir = "/home/${username}/sarwnix"; # Absolute path of the repo;

    theme = "catppuccin"; # Selected theme from home/shared/themes directory
    themeDetails = import (./. + "/home/shared/themes/${theme}.nix") {inherit pkgs;};

    shell = "zsh"; # See home/shared/shells directory.
    shellPkg = pkgs.zsh;

    wms = ["hyprland"]; # See home/shared/desktop/ and modules/system/desktop directories.
    editors = ["neovim" "vscode"]; # See home/shared/programs/editors directory.
    browsers = ["zen-browser"]; # See home/shared/programs/browsers directory.
    preferredEditor = "nvim"; # Session variable $TERM.
    preferredBrowser = "zen"; # Session variable $BROWSER.
}
