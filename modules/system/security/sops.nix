{pkgs, inputs, config, settings, ...}:
{
    environment.systemPackages = with pkgs; [ sops age ];
    imports = [ inputs.sops-nix.nixosModules.sops ];

    # This will add secrets.yml to the nix store
    sops.defaultSopsFile = ../../../secrets/default.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";
    # This will generate a new key if the key specified above does not exist
    sops.age.generateKey = false;

    sops.secrets.lastfm = {
        owner = config.users.users.${settings.username}.name;
    };

    sops.secrets.listenbrainz = {
        owner = config.users.users.${settings.username}.name;
    };
}
