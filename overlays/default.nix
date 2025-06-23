/*
 * This contains various packages we want to overlay. Note that the
 * other ".nix" files in this directory are automatically loaded.
 */
final: prev: {
    _nemu = final.callPackage ../packages/nemu.nix {};
    _hydra = final.callPackage ../packages/hydra.nix {};
    _stmp = final.callPackage ../packages/stmp.nix {};
    _subsonic-tui = final.callPackage ../packages/subsonic-tui.nix {};
    _neonmodem = final.callPackage ../packages/neonmodem.nix {};
}