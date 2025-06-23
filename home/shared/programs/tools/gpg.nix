{ config, pkgs, settings, ... }:

{
    programs.gpg = {
        enable = true;
        settings = {
            # Use a more secure default cipher
            default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
            # Disable inclusion of the version string
            no-version = true;
            # Disable comment string in clear text signatures and ASCII armored messages
            no-comments = true;
            # Display long key IDs
            keyid-format = "0xlong";
            # List all keys (or the specified ones) along with their fingerprints
            with-fingerprint = true;
            # Display the calculated validity of user IDs during key listings
            list-options = "show-uid-validity";
            verify-options = "show-uid-validity";
            # Auto-retrieve keys when verifying signatures
            auto-key-retrieve = true;
            # Use keyserver for auto-retrieval
            keyserver = "hkps://keys.openpgp.org";
        };
    };

    services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        defaultCacheTtlSsh = 1800;
        maxCacheTtl = 7200;
        maxCacheTtlSsh = 7200;
        enableSshSupport = true;
        pinentryPackage = pkgs.pinentry-gtk2;
        extraConfig = ''
            allow-loopback-pinentry
        '';
    };

    # Add GPG to packages
    home.packages = with pkgs; [
        gnupg
        pinentry-gtk2
    ];
}
