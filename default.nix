{ pkgs ? import <nixpkgs> {}, ... }:

with pkgs; stdenv.mkDerivation {
  name = "barsim";
  src = ./barsim.tar.gz;
  installPhase = ''
    mkdir $out
    cp -r ./* $out
  '';
}
