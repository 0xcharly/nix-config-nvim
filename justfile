set shell := ['fish', '-c']

hostname := `hostname`
rebuildOptions := '--option accept-flake-config true --show-trace'

[doc('List all available commands')]
[private]
default:
    @just --list

[doc('Format all files in the repository')]
fmt:
    treefmt

[doc('Update the given flake input')]
[macos]
update input:
    nix flake update {{ input }}

[doc('Update the given flake input')]
[linux]
update input:
    nix flake lock --update-input {{ input }}
