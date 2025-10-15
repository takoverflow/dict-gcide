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
    };
}
