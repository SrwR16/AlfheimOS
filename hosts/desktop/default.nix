{ pkgs, lib, settings, ... }:
{
    imports = [
        ./hardware.nix
        ../../modules/system/hardware/sound.nix
        ../../modules/system/hardware/bluetooth.nix
        ../../modules/system/hardware/desktop/graphic.nix
        ../../modules/system/hardware/desktop/mouse.nix
        # ../../modules/system/hardware/desktop/printing.nix
        ../../modules/system/hardware/desktop/boot.nix
        ../../modules/system/hardware/desktop/nfs.nix
        ../../modules/system/security/desktop/firewall.nix
        ../../modules/system/security/virtualization/general.nix
        ../../modules/system/security/virtualization/nemu/default.nix
        ../../modules/system/security/sops.nix
        ../../modules/system/programs/apps/thunar.nix
        ../../modules/system/programs/apps/guix.nix
        # ../../modules/system/programs/apps/ollama.nix
        ../../modules/system/programs/gaming/steam.nix
        ../../modules/system/programs/gaming/lutris.nix
        # ../../modules/system/programs/gaming/retroarch.nix
        ../../modules/system/programs/gaming/aagl.nix
        ../../modules/system/programs/gaming/nethack.nix
        # ../../modules/system/programs/gaming/minecraft.nix
        ../../modules/system/security/vpn/xray.nix
        ../../home/shared/themes/lib/common.nix
    ] ++ (map (wm: ../../modules/system/desktop/${wm}.nix) settings.wms);

    boot.kernelPackages = pkgs.linuxPackages_latest;

    nixpkgs.overlays = import ../../lib/overlays.nix;
    nixpkgs.config.allowUnfree = true; # Sorry, Stallman(
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Netorking
    networking.hostName = settings.hostname;
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "dnsmasq";
    networking.extraHosts = ''
        127.0.0.1 serpentian.home
    '';

    # Timezone
    time.timeZone = settings.timezone;
    services.chrony.enable = true;

    # Locale.
    i18n.defaultLocale = settings.locale;
    i18n.extraLocaleSettings = {
        LC_ALL = settings.locale;
    };

    programs.${settings.shell}.enable = true;

    # Users.
    users.users.${settings.username} = {
        isNormalUser = true;
        shell = settings.shellPkg;
        description = settings.username;
        extraGroups = [ "wheel" "gamemode" ];
    };

    # See https://nix.dev/permalink/stub-ld.
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc
    ];

    # List of globally installed packages.
    environment.systemPackages = with pkgs; [
        home-manager
        nix-index
        pciutils
        go-mtpfs
        ntfs3g
        inetutils
        lsof
        wget
        git
        vim
    ];

    fonts.packages = [ settings.themeDetails.fontPkg ];

    # A lot of mpris packages require it.
    services.gvfs.enable = true;

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
}
