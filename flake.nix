{
  description = "ilo4 patcher for modding fan speed";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        nativeBuildInputs = with pkgs; [
          python311Full
          python311Packages.paramiko
          python311Packages.keystone-engine

          which
        ];

        buildInputs = with pkgs; [];

        firmware = pkgs.fetchurl {
          url = "https://downloads.hpe.com/pub/softlib2/software1/sc-linux-fw-ilo/p192122427/v188589/CP046020.scexe";
          hash = "sha256-Fk+EAoBmAmQuiNtVlpZTrgR8s6WbTEQpHZWzQpAGxcE=";
        };
        pointRelease = "277";
        binaryName = "ilo4_${pointRelease}.bin";
      in {
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};

        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "ilo4-unlock";
          version = "2.77";
          format = "setuptools";

          src = ./.;
          
          unpackPhase = ''
            cp ${firmware} ./firmware.scexe
            chmod +x firmware.scexe
            mkdir unpacked dumped executable
            ./firmware.scexe --unpack=unpacked > /dev/null

            chmod 700 executable
            cp -r $src/. executable/.
            chmod -R 700 executable
           
            python3 executable/ilo4_toolbox/scripts/iLO4/ilo4_extract.py unpacked/${binaryName} dumped
          '';

          patchPhase = ''
            python3 executable/util/patch.py dumped/bootloader.bin patches/${pointRelease}/patch_bootloader.json dumped/bootloader.bin.patched

            python3 executable/util/patch.py dumped/kernel_main.bin patches/${pointRelease}/patch_kernel.json dumped/kernel_main.bin.patched

            python3 executable/util/patch.py dumped/elf.bin patches/${pointRelease}/patch_userland.json dumped/elf.bin.patched
          '';

          buildPhase = ''
            python3 executable/ilo4_toolbox/scripts/iLO4/ilo4_extract.py unpacked/${binaryName} dumped/firmware.map dumped/elf.bin.patched dumped/kernel_main.bin.patched dumped/bootloader.bin.patched
            cp ./${binaryName}.backdoored.toflash $OUT/${binaryName}.patched
          '';
          # True if tests
          doCheck = false;

          inherit nativeBuildInputs buildInputs;
        };
      }
    );
}
