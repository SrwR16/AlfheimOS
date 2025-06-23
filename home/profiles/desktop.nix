{ inputs, config, pkgs, settings, ...}:
{
    imports = [
        ../shared/themes/lib/common.nix
        ../shared/themes/lib/home.nix
        ../shared/programs/terminals/kitty.nix
        ../shared/programs/tools/git.nix
        ../shared/programs/tools/gpg.nix
        ../shared/programs/tools/superfile.nix
        ../shared/programs/tools/zathura.nix
        ../shared/programs/tools/nemu.nix
        ../shared/programs/media/cava.nix
        ../shared/programs/tools/github.nix
        ../shared/programs/tools/neofetch
        ../shared/programs/tools/mangohud.nix
        ../shared/programs/gaming/nethack.nix
        ../shared/programs/gaming/steam.nix
        ../shared/programs/tools/tlaplus.nix
        ../shared/programs/tools/latex.nix
        ../shared/programs/tools/btop
        ../shared/programs/media/mpd
        ../shared/shells/${settings.shell}.nix
    ] ++ (map (wm: ../shared/desktop/${wm}.nix) settings.wms)
      ++ (map (editor: ../shared/programs/editors/${editor}) settings.editors);

    home = {
        username = settings.username;
        homeDirectory = "/home/${settings.username}";
    };

    # Add packages from the pkgs dir
    nixpkgs.overlays = import ../../lib/overlays.nix;
    nixpkgs.config.allowUnfree = true; # Sorry, Stallman(

    home.packages = with pkgs; [
        sysstat
        gnupg
        sway-contrib.grimshot
        libreoffice-fresh
        # obs-studio
        # tty-clock
        qbittorrent
        # rtorrent
        cpulimit
        swayimg
        vesktop
        # revolt-desktop
        telegram-desktop
        # wayvnc
        drawio
        # flacon
        krita
        gimp
        mpv

        # Test.
        weechat

        # Overclock
        dmidecode
        sysbench

        # Sometimes needed for work.
        # zoom-us
        chromium
        unzip
        # translate-shell
    ];

    xdg.enable = true;
    xdg.userDirs = {
        enable = true;
        createDirectories = true;
        music = "${config.home.homeDirectory}/Media/Music";
        videos = "${config.home.homeDirectory}/Media/Videos";
        pictures = "${config.home.homeDirectory}/Media/Pictures";
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        templates = null;
        desktop = null;
        publicShare = null;
        extraConfig = {
            XDG_DOTFILES_DIR = "${settings.dotfilesDir}";
            XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
        };
    };

    home.sessionVariables = {
        EDITOR = settings.preferredEditor;
        BROWSER = settings.preferredBrowser;
    };

    programs.home-manager.enable = true;
    home.stateVersion = settings.stateVersion;
}
