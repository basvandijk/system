let
  pkgs = import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (self: super: {
        inherit sources;

        haskellPackages = super.haskellPackages.override {
          overrides = hself: hsuper: let v = "1.28"; in {
            hledger = hsuper.callHackage "hledger" v {};
            hledger-lib = hsuper.callHackage "hledger-lib" v {};
            hledger-ui = hsuper.callHackage "hledger-ui" v {};
            hledger-web = self.haskell.lib.dontCheck (
              hsuper.callHackage "hledger-web" v {}
            );

            brick = hsuper.callHackage "brick" "1.5" {};
            fsnotify = hsuper.callHackage "fsnotify" "0.4.1.0" {};
            bimap = hsuper.callHackage "bimap" "0.5.0" {};
            text-zipper = hsuper.callHackage "text-zipper" "0.12" {};
            vty = hsuper.callHackage "vty" "5.37" {};
          };
        };

        all-cabal-hashes =
          let
            commit = "8dfd43e7ddb78c375d214853b3d1ae8de76e6368";
          in
          self.fetchurl {
            url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/${commit}.tar.gz";
            name = "all-cabal-hashes-${self.lib.substring 0 7 commit}.tar.gz";
            sha256 = "sha256-4uyHV0Hz95DMOBkHGC8ZIjFzTbRXY5buM45BT9AhoBk=";
          };
      })
    ];
  };

  sources = import sourcesnix { sourcesFile = ./sources.json; inherit pkgs; };

  sourcesnix = builtins.fetchurl {
    url = https://raw.githubusercontent.com/nmattia/niv/506b896788d9705899592a303de95d8819504c55/nix/sources.nix;
    sha256 = "007bgq4zy1mjnnkbmaaxvvn4kgpla9wkm0d3lfrz3y1pa3wp9ha1";
  };
in
pkgs
