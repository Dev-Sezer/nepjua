{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModule
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    diff-so-fancy.enable = true;
  };

  home.packages = with pkgs; [
    cachix
    nixd

    nil
    nixpkgs-fmt

    wget
    tldr
    jq
    lsd
    starship
    vim
    lsof

    # Python
    python312
    btop
    dos2unix
    alejandra
  ];

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs = {
    home-manager.enable = true;
    java.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    gh.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
