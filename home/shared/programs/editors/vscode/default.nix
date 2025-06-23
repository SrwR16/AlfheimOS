{pkgs, ...}:
{
    # Using vscode-fhs for better compatibility with extensions
    home.packages = with pkgs; [
        vscode-fhs
    ];

    # VSCode configuration
    programs.vscode = {
        enable = false; # We're using vscode-fhs package instead
        extensions = with pkgs.vscode-extensions; [
            vscodevim.vim
        ];
    };
}
