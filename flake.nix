{
  description = "Advent of Code 2026 - Elixir Solutions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            elixir
            elixir_ls  # Language server for editor support
          ];

          shellHook = ''
            echo "Advent of Code 2026 - Elixir Development Environment"
            echo "Elixir version: $(elixir --version | head -n 1)"
            echo ""
            echo "Available commands:"
            echo "  mix test              - Run all tests"
            echo "  mix test.watch        - Run tests on file changes"
            echo "  mix test test/dayXX*  - Run specific day's tests"
            echo ""
          '';
        };
      }
    );
}
