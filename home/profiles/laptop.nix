{ config, pkgs, settings, ...}:
{
    imports = [
        ../shared/themes/lib/common.nix
        ../shared/themes/lib/home.nix
        ../shared/programs/media/spotify.nix
        ../shared/programs/terminals/kitty.nix
        ../shared/programs/tools/git.nix
        ../shared/programs/tools/btop
        ../shared/programs/tools/superfile.nix
        ../shared/programs/tools/zathura.nix
        ../shared/programs/tools/nemu.nix
        ../shared/programs/media/cava.nix
        ../shared/programs/tools/khal.nix
        ../shared/programs/tools/neofetch
        ../shared/programs/gaming/nethack.nix
        ../shared/programs/tools/tlaplus.nix
        ../shared/programs/tools/latex.nix
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
        sway-contrib.grimshot
        libreoffice-fresh
        yubikey-manager
        obs-studio
        tty-clock
        teleport
        rtorrent
        tigervnc
        swayimg
        openvpn
        update-resolv-conf
        drawio
        gimp
        mpv

        # Sometimes needed for work.
        chromium
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
    home.stateVersion = "23.05";
}
