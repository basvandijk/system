let
  pkgs = import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (self: super: { inherit sources; })
    ];
  };

  sources = import sourcesnix { sourcesFile = ./sources.json; inherit pkgs; };

  sourcesnix = builtins.fetchurl {
    url = https://raw.githubusercontent.com/nmattia/niv/506b896788d9705899592a303de95d8819504c55/nix/sources.nix;
    sha256 = "007bgq4zy1mjnnkbmaaxvvn4kgpla9wkm0d3lfrz3y1pa3wp9ha1";
  };
in
pkgs
