{
  outputs =
    { nixpkgs, self }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      formatter = forAllSystems (system: 
        nixpkgs.legacyPackages.${system}.nixfmt-tree
      );

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { 
            inherit system;
            config.allowUnfree = true;
          };
        in {
          default = pkgs.callPackage ./default.nix { };
        }
      );
      
      overlays.default = final: prev: {
        dict-gcide = final.callPackage ./default.nix { };
      };
    };
}
