{
  description = "Development shell for school projects";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixfmt;
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          erlang
          gleam
          nixd
          python3
          python3Packages.venvShellHook
          ruff
          ty
        ];

        venvDir = ".venv";
      };
    };
}
