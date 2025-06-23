{config, settings, ...}:
{
    services.mpdscribble = {
        enable = true;
        verbose = 3;
        endpoints = {
            "last.fm" = {
                passwordFile = "/run/secrets/lastfm";
                username = settings.gitusername;
            };
            "listenbrainz" = {
                passwordFile = "/run/secrets/listenbrainz";
                username = settings.gitusername;
            };
        };
    };
}
