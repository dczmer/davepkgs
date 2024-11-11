Collection of one-off packages I had to assemble myself.

Not including things like my NeoVim flake (which I keep separate because I am
constantly tweaking it and run it directly), or my CDDA flake, because that is
intentionally following the main branch and NOT pinning to specific, stable
versions.

You can test with repl and/or build with `nix-build default.nix -A <pkgname>`
```
:l <nixpkgs>
:l default.nix
:b swagger-ui.override { port = "8088"; }
```

TODO:

- [ ] add meta sections and docs/notes/example usage
- [ ] include a flake.nix and maybe a shell.nix with tools for working on this repo
- [ ] documentation and/or dev shell for building restler-fuzzer in non-pure fashion
