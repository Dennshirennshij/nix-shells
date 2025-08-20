{
  description = "A collection of dev shells for various languages";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux = {
        rust = import ./shells/rust { inherit pkgs; };
        rust-esp32 = import ./shells/rust-esp32 { inherit pkgs; };
      };
    };
}
