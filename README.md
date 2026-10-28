# project

`project` is a Bash utility for saving project directories by name, retrieving their paths, updating descriptions, and listing projects grouped by path. It includes Zsh completion and can be packaged for Debian, RPM-based Linux, and Nix.

## Repository Structure
```
├── .github/workflows/
│   ├── release.yaml             # Automated packaging and release pipeline
│   └── test.yaml                # CI test workflow
├── bin/
│   └── project                  # Main executable script
├── completion/
│   └── _project                 # Zsh completion definition
├── packaging/
│   ├── debian/                  # Debian package metadata
│   └── rpm/                     # RPM spec file
├── flake.nix                    # Nix package & app definition
├── flake.lock                   # Nix lockfile
├── LICENSE
└── README.md
```

## Usage

```bash
project -a myproj ~/src/myproj
project -d myproj "Cool service"
project myproj
project --print-path myproj
project -i myproj
project -l
```

The database defaults to `~/.local/share/projectctl`; set `PROJECT_DB_DIR` to use a different location. `project` prints a path but cannot change the current shell's directory when run as an executable.

## Releases

Push a `v*` tag to build Debian (`.deb`) and RPM (`.rpm`) packages and publish the source archive and registry manifest. The Nix package is defined in `flake.nix`.
