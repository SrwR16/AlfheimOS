{ config, pkgs, settings, ...}:

{
    programs.git = {
        enable = true;
        userName = settings.name;
        userEmail = settings.email;
        extraConfig = {
            core = {
                editor = settings.preferredEditor;
                autocrlf = "input";
            };
            init.defaultBranch = "main";
            commit.gpgsign = true;
            tag.gpgsign = true;
            user.signingkey = settings.users.${settings.primaryUser}.gitKey;
            gpg.program = "${pkgs.gnupg}/bin/gpg";
            pull.rebase = true;
            push.autoSetupRemote = true;
            # Better diff algorithms
            diff.algorithm = "patience";
            # Automatically setup tracking branches
            branch.autosetupmerge = "always";
            branch.autosetuprebase = "always";
        };
        # Enable git aliases
        aliases = {
            st = "status";
            co = "checkout";
            br = "branch";
            ci = "commit";
            ca = "commit -a";
            cam = "commit -am";
            l = "log --oneline --graph --decorate";
            la = "log --oneline --graph --decorate --all";
            unstage = "reset HEAD --";
            last = "log -1 HEAD";
            visual = "!gitk";
        };
    };

    programs.lazygit = {
        enable = true;
        settings = {
            gui = {
                theme = {
                    selectedLineBgColor = ["reverse"];
                };
            };
            git = {
                paging = {
                    colorArg = "always";
                    pager = "${pkgs.delta}/bin/delta --dark --paging=never";
                };
            };
        };
    };

    # Enhanced git tools
    home.packages = with pkgs; [
        delta  # Better git diffs
        gh     # GitHub CLI
        git-lfs # Large file support
    ];
}
