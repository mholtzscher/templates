{
  description = "{{ cookiecutter.project_name }} - {{ cookiecutter.project_description }}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      gomod2nix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ gomod2nix.overlays.default ];
        };

        releasePleaseManifest = builtins.fromJSON (builtins.readFile ./.github/.release-please-manifest.json);
        version = releasePleaseManifest.".";

        # Add platform-specific build inputs here (e.g., CGO deps)
        buildInputs = [ ];

        # macOS-specific build inputs for CGO
        darwinBuildInputs = pkgs.lib.optionals pkgs.stdenv.isDarwin [
          pkgs.apple-sdk_15
        ];
      in
      {
        packages.default = pkgs.buildGoApplication {
          pname = "{{ cookiecutter.project_slug }}";
          inherit version;
          src = ./.;
          modules = ./gomod2nix.toml;
          go = pkgs.go_{{ cookiecutter.go_version | replace('.', '_') }};

          buildInputs = buildInputs ++ darwinBuildInputs;

          # Set CGO_ENABLED=1 if you need CGO
          CGO_ENABLED = {% if cookiecutter.use_cgo == "yes" %}1{% else %}0{% endif %};

          ldflags = [
            "-s"
            "-w"
            "-X {{ cookiecutter.module_path }}/cmd.Version=${version}"
          ];

          meta = with pkgs.lib; {
            description = "{{ cookiecutter.project_description }}";
            homepage = "https://github.com/{{ cookiecutter.github_owner }}/{{ cookiecutter.github_repo }}";
            license = licenses.{{ cookiecutter.license | lower | replace('-', '_') | replace('apache_2.0', 'asl20') | replace('bsd_3_clause', 'bsd3') | replace('gpl_3.0', 'gpl3') | replace('proprietary', 'unfree') }};
            mainProgram = "{{ cookiecutter.project_slug }}";
            platforms = platforms.all;
          };
        };

        formatter = pkgs.nixfmt-rfc-style;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.go_{{ cookiecutter.go_version | replace('.', '_') }}
            pkgs.gopls
            pkgs.golangci-lint
            pkgs.gotools
            pkgs.gomod2nix
{% if cookiecutter.use_sqlc == "yes" %}
            pkgs.sqlc
{% endif %}
            pkgs.just
            pkgs.cruft
          ]
          ++ buildInputs
          ++ darwinBuildInputs;

          # Set CGO_ENABLED="1" if you need CGO
          CGO_ENABLED = "{% if cookiecutter.use_cgo == "yes" %}1{% else %}0{% endif %}";
        };

        devShells.ci = pkgs.mkShell {
          buildInputs = [
            pkgs.go_{{ cookiecutter.go_version | replace('.', '_') }}
            pkgs.golangci-lint
{% if cookiecutter.use_sqlc == "yes" %}
            pkgs.sqlc
{% endif %}
            pkgs.just
          ]
          ++ buildInputs
          ++ darwinBuildInputs;

          CGO_ENABLED = "{% if cookiecutter.use_cgo == "yes" %}1{% else %}0{% endif %}";
        };
      }
    );
}
