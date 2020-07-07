let
  pkgs = import ./nix;
in {
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
      tt-mode
    ]);

  inherit (pkgs)
    coreutils
    git
    git-lfs
    htop
    zsh
    oh-my-zsh
    powerline-fonts # Make sure to run ~/Library/Fonts/update.sh
    tree
    gnupg
    openssl
    plantuml
    # jre
    ripgrep
    jq
    direnv
    graphviz
    cabal2nix
    cabal-install
    nix-diff
    ;

  vulnix = pkgs.vulnix.overrideAttrs (_oldAttrs: { src = pkgs.sources.vulnix; });

  inherit (pkgs.haskellPackages) ghc;

  inherit (pkgs.gitAndTools) git-crypt;

  inherit (import pkgs.sources.niv { inherit pkgs; }) niv;

  lorri = import pkgs.sources.lorri { inherit pkgs; };
}
