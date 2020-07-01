let
  pkgs = import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
  };

  sources = import sourcesnix { sourcesFile = ./nix/sources.json; inherit pkgs; };

  sourcesnix = builtins.fetchurl {
    url = https://raw.githubusercontent.com/nmattia/niv/506b896788d9705899592a303de95d8819504c55/nix/sources.nix;
    sha256 = "007bgq4zy1mjnnkbmaaxvvn4kgpla9wkm0d3lfrz3y1pa3wp9ha1";
  };
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
    nix-diff
    ;

  vulnix = pkgs.vulnix.overrideAttrs (_oldAttrs: { src = sources.vulnix; });

  inherit (pkgs.haskellPackages) ghc;

  inherit (pkgs.gitAndTools) git-crypt;

  inherit (import sources.niv { inherit pkgs; }) niv;

  lorri = import sources.lorri { inherit pkgs; };
}
