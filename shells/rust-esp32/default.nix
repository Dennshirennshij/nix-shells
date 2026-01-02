{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "esp32c6-rust-dev";

  buildInputs = [
    pkgs.git
    pkgs.cmake
    pkgs.ninja
    #pkgs.dfutool
    pkgs.python3
    pkgs.python3Packages.pip
    pkgs.openssl
    pkgs.libffi
    pkgs.flex
    pkgs.bison
    pkgs.gperf
    pkgs.ccache
    #pkgs.riscv32-elf-gcc  # RISC-V cross compiler
    pkgs.cargo
  ];

  shellHook = ''
    export IDF_PATH=$PWD/esp-idf

    # Install Rust if not present
    if ! command -v rustc >/dev/null 2>&1; then
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      source $HOME/.cargo/env
    fi

    # Add RISC-V target
    rustup target add riscv32imc-unknown-none-elf

    # Install cargo-espflash if not present
    if ! cargo install --list | grep -q cargo-espflash; then
      cargo install cargo-espflash
    fi

    # Clone ESP-IDF if not exists
    if [ ! -d "$IDF_PATH" ]; then
      git clone --recursive https://github.com/espressif/esp-idf.git $IDF_PATH
      cd $IDF_PATH
      git checkout release/v5.1
      ./install.sh
      cd -
    fi

    # Export ESP-IDF environment
    source $IDF_PATH/export.sh

    echo "ESP32-C6 Rust + ESP-IDF environment ready!"
  '';
}

