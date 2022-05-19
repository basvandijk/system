let
  pkgs = import ./nix;
in {
  emacs = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs:
    with epkgs.melpaPackages; [
      magit
      forge
      flycheck
      company
      github-review
      haskell-mode
      zenburn-theme
      solarized-theme
      yaml-mode
      markdown-mode
      nix-mode
      nix-sandbox
      ormolu
      graphviz-dot-mode
      direnv
      projectile
      terraform-mode
      go-mode
      rust-mode
      #rustic
      lsp-mode
      lsp-ui
      adoc-mode
      plantuml-mode
      use-package
      rg
      tt-mode
      elixir-mode
      yasnippet
    ]);

  inherit (pkgs)
    coreutils
    git
    git-filter-repo
    #git-lfs
    htop
    zsh
    oh-my-zsh
    powerline-fonts # Make sure to run ~/Library/Fonts/update.sh
    tree
    gnupg
    openssl
    ormolu
    plantuml
    # jre
    ripgrep
    jq
    direnv
    graphviz
    cabal2nix
    cabal-install
    colordiff
    ;

  nix-diff = pkgs.haskell.lib.doJailbreak pkgs.nix-diff;

  #splot = pkgs.haskell.lib.justStaticExecutables pkgs.haskellPackages.splot;

  #vulnix = pkgs.vulnix.overrideAttrs (_oldAttrs: { src = pkgs.sources.vulnix; });

  inherit (pkgs.haskellPackages) ghc;

  #inherit (pkgs.gitAndTools) git-crypt;

  #inherit (import pkgs.sources.niv { inherit pkgs; }) niv;
  inherit (pkgs) niv;

  #lorri = import pkgs.sources.lorri { inherit pkgs; };
}
