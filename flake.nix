{
  description = "liquidctl dev shell (fork)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (ps:
            pkgs.liquidctl.propagatedBuildInputs
            ++ (with ps; [ pycairo pygobject3 ])   # only needed for text overlay
          ))
          pkgs.pango pkgs.cairo                    # native libs that pycairo/pygobject load
        ];
      };
    };
}