{ pkgs, ... }:
pkgs.mkShell {
  
  name = "rust-soc";

  buildInputs = with pkgs; [
    rustup
    cargo-generate

    usbutils
    picocom

    esp-generate
    espflash
    probe-rs

    avrdude
    ravedude
    pkgsCross.avr.buildPackages.gcc

    (pkgs.writeShellScriptBin "avr-generate" ''
      echo "creating a new arduino project"
      cargo generate --git https://github.com/Rahix/avr-hal-template.git
    '')
  ];

  shellHook = ''
    echo "🚀 Development shell for SOCs (RISC-V for ESP32, Arduino) using Rust"
    echo "⬇️ Updating the nightly Rust toolchain"
    rustup update nightly
    export RUSTUP_TOOLCHAIN=nightly
    echo "✅ Updated and applied the nightly toolchain"

    # Required targets
    ## ESP32
    ### For C3 - Chips
    echo "⬇️ Adding targets"
    rustup target add riscv32imc-unknown-none-elf
    ### For C6 - Chips
    rustup target add riscv32imac-unknown-none-elf

    ## Arduino
    #rustup target add avr-none
    echo "✅ Added the targets"

    echo "For Arduino just do cargo run. By using the template it will upload it"

  '';
}
