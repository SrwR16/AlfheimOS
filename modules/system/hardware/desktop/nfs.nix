{pkgs, settings, ...}:
{
    environment.systemPackages = with pkgs; [ nfs-utils ];
    boot.supportedFilesystems = [ "nfs" ];
    services.nfs = {};
    fileSystems."/home/${settings.username}/Drives/network" = {
        device = "192.168.1.218:/home/${settings.username}/media";
        fsType = "nfs";
    };
}
