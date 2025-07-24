{
  pkgs ? import <nixpkgs> { },
  version ? "0.53",
  ...
}:

pkgs.stdenv.mkDerivation rec {
  inherit version;

  pname = "gcide";

  src = pkgs.fetchurl {
    url = "https://ftp.gnu.org/gnu/gcide/${pname}-${version}.tar.xz";
    hash = "sha256-06y9mE3hzgItXROZA4h7NiMuQ24w7KLLD7HAWN1/MZ8=";
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatch = true;

  installPhase = ''
    mkdir -vp $out/
    cp ../${pname}-${version}/* $out/
  '';

  dontFixup = true;
  doInstallCheck = false;
  doCheck = false;

  meta = {
    description = "GNU version of the Collaborative International Dictionary of English for dictd et al";
    homepage = "https://gcide.gnu.org.ua/";
    license = pkgs.lib.licenses.gpl3Plus;
    maintainers = [
      {
        email = "S0AndS0@digital-mercenaries.com";
        github = "S0AndS0";
        githubId = 4116150;
        name = "S0AndS0";
      }
    ];
    platforms = pkgs.lib.platforms.unix;
  };
}
# vim: expandtab shiftwidth=2 tabstop=2
