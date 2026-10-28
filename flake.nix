{
  description = "project - TODO";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: pkgs: rec {
        default = project;
        project = pkgs.stdenvNoCC.mkDerivation {
          pname = "project";
          version = "1.0.0";
          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/bin $out/share/zsh/site-functions
            install -D -m 0755 bin/project $out/bin/project
            wrapProgram $out/bin/project \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.coreutils pkgs.jq ]}
            if [ -d completion ]; then
              cp -r completion/* $out/share/zsh/site-functions/ 2>/dev/null || true
            fi
          '';

          meta = {
            description = "TODO";
            mainProgram = "project";
            platforms = pkgs.lib.platforms.unix;
          };
        };
      });

      apps = forAllSystems (system: pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/project";
        };
      });
    };
}
