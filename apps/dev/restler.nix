# TODO: this is basically useless as-is.
# this puts the source in the store, where we can't build it at all w/out
# manually copying it out.
#
# you can still use this in a devshell to build in non-pure fashion:
#
# cp -rv ${davepkgs.restler-fuzzer} $(pwd)/restler
# chmod -R +w $(pwd)/restler
# python $(pwd)/restler/build-restler.py --dest_dir=$(pwd)/restler/restler_bin


# NOTE: I couldn't get this to build in a pure fashion.
# it uses a python script that installs and configures .net dependencies
# from the internet, at build-time, and that is forbidden.
# i suspect this can be built with the dotnet tools for nix but it didn't seem
# trivial.
# for now, I'm just installing the source and then including it in a devShell.
# then you can build it to your selected output dir for use in the shell.
{ fetchFromGitHub }:
let
  version = "9.2.4";
in
fetchFromGitHub {
  owner = "microsoft";
  repo = "restler-fuzzer";
  rev = "v${version}";
  hash = "sha256-NNNQFnegRgd5ZDmfyqy5U9awM6u93LQj9PPPTxzUr1Y=";
}
