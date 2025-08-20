{ pkgs, ... }:
pkgs.mkShell {
  
  name = "rust-esp32";

  packages = with pkgs; [
    rustup

    esp-generate
    espflash
  ];

  shellHook = ''
    echo "🚀 Development shell for ESP32 (RISC-V only) using Rust"
    echo "⬇️ Updating the nightly Rust toolchain"
    rustup update nightly
    export RUSTUP_TOOLCHAIN=nightly
    echo "✅ Updated and applied the nightly toolchain"

    # Required targets
    ## For C3 - Chips
    echo "⬇️ Adding toolchains"
    rustup target add riscv32imc-unknown-none-elf
    ## For C6 - Chips
    rustup target add riscv32imac-unknown-none-elf
    echo "✅ Added the toolchains"

    echo "Todo: Add instructions for flashing"

  '';
}
