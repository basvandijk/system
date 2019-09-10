{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
  }
}: {
  emacs = (pkgs.emacsPackagesNgGen pkgs.emacs).emacsWithPackages (epkgs:
    with epkgs.melpaPackages; [
      magit
      forge
      github-review
      haskell-mode
      zenburn-theme
      solarized-theme
      yaml-mode
      markdown-mode
      nix-mode
      nix-sandbox
      graphviz-dot-mode
      direnv
      projectile
      terraform-mode
      go-mode
      rust-mode
      adoc-mode
      plantuml-mode
      use-package
      rg
    ]);

  inherit (pkgs)
    git
    htop
    zsh
    oh-my-zsh
    powerline-fonts # Make sure to run ~/Library/Fonts/update.sh
    tree
    gnupg
    openssl
    nix-diff
    plantuml
    jre
    ripgrep
    jq
    direnv;

  inherit (pkgs.gitAndTools) git-crypt;

  niv = pkgs.haskell.lib.justStaticExecutables (import sources.niv { inherit pkgs; }).niv;
}
