{ pkgs }:
pkgs.mkShell {
  name = "rust";
  buildInputs = [
    pkgs.rustup
  ];
}

