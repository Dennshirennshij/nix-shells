{ pkgs }:
let

  nativeBuildInputs = with pkgs; [ rustup gcc pkg-config ];
  buildInputs = with pkgs; [
    # misc
    openssl

    # x11 libs
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libX11

    # wayland
    wayland

    # GUI libs
    libxkbcommon
    libGL
    fontconfig
  ];
  libaryPath = pkgs.lib.makeLibraryPath buildInputs;

in pkgs.mkShell {
  name = "rust-stable";

  inherit nativeBuildInputs buildInputs;

  LD_LIBRARY_PATH = "${libaryPath}:$LD_LIBRARY_PATH";

  shellHook = ''
    echo "🚀 Development shell for generic Rust development"

    # Initialize Rust via rustup if missing
    if ! command -v rustc &>/dev/null; then
      echo "📦 Installing stable Rust toolchain via rustup..."
      rustup install stable
      rustup default stable
    fi
  '';
}

