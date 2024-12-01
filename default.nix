{
  pkgs ? null,
}:
let
  packages = if pkgs == null then (import <nixpkgs> { }) else pkgs;
in
with packages;
{
  # TODO the `docker run` command is a bit complicated.
  #      maybe port/volumes/etc should be run-time options, or else
  #      the entire run command could be an overridable argument.
  swagger-ui = callPackage ./apps/dev/swagger-ui.nix { };
  swagger-editor = callPackage ./apps/dev/swagger-editor.nix { };

  # restler; just the source checkout and help with instructions
  # for building and running in a devShell.
  restler-fuzzer-src = callPackage ./apps/dev/restler.nix { };

  # prism mock swagger server
  prism-mock = callPackage ./apps/dev/prism-mock.nix { };
}
