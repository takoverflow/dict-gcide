{
  version ? "0.53",
  pkgs ? import <nixpkgs> { },
  ...
}:

let
  ## Sed scripts are versioned to discourage forgetting to yoink updates from AUR
  sed-scripts = {
    check = ./sed-scripts/${version}-check.sed;
    fixes = ./sed-scripts/${version}-fixes.sed;
    post_webfilter = ./sed-scripts/${version}-post_webfilter.sed;
  };

  ## TODO: make this not ugly?
  libmaa = builtins.head (builtins.filter (x: x.pname == "libmaa") pkgs.dict.buildInputs);

  gcide = pkgs.callPackage ./gcide.nix { inherit version pkgs; };

  _major_debver = "0.48";
  _debver = "${_major_debver}.5+nmu4";
in
pkgs.stdenv.mkDerivation rec {
  inherit version;

  pname = "dict-gcide";
  name = pname;
  dbName = pname;
  locale = "en_US.UTF-8";

  src = pkgs.fetchurl {
    url = "https://deb.debian.org/debian/pool/main/d/${pname}/${pname}_${_debver}.tar.xz";
    hash = "sha256-45ITB4SnyRycjchdseFP5J+XhZfp6J2Dm5q+DJ/N4A4=";
  };

  buildInputs =
    with pkgs;
    [
      ## Needed for: autoreconf
      autoconf
      automake
      ## Needed for: make
      bison
      flex
      ## Needed for: dictzip
      dict
    ]
    ++ [
      gcide
      libmaa
    ];

  patchPhase = ''
    sed -Ei "/The Collaborative International Dictionary of English v.${_major_debver}/ {
      s/${_major_debver}/${version}/ ;
    }" scan.l;

    rm config.guess config.h.in config.sub configure install-sh;
  '';

  configurePhase = ''
    autoreconf -fis;
    ./configure;
  '';

  enableParallelBuilding = false;
  buildPhase = ''
    make -j1;

    ## Do the conversion explicitly, instead of `make db', to account for all
    ## the differences to the original build process.
    ## LANG=C is required so that the index file is properly sorted.
    sed -Ef "${sed-scripts.fixes}" "${gcide.out}"/CIDE.?  |
      sed -f debian/sedfile |
      ./webfilter |
      sed -Ef "${sed-scripts.post_webfilter}" |
      tee pre_webfmt.data |
      LANG=C ./webfmt -c;

    ## `dictzip -v' neglects to print a final newline.
    dictzip -v gcide.dict;
    printf '\n';
  '';

  doCheck = true;
  checkPhase = ''
    errors="$(sed -nEf "${sed-scripts.check}" < ./pre_webfmt.data)";

    if test -n "$errors"; then
      printf >&2 'Errors found:\n'
      printf >&2 '%s\n' "$errors"
      exit 1
    fi
  '';

  installPhase = ''
    install -m 0755 -d "$out/share/dictd";
    install -m 0644 -t "$out/share/dictd/" ./gcide.{dict.dz,index};

    echo "${locale}" > "$out/share/dictd/locale";

    install -m 0755 -d "$out/share/doc/dict-gcide";
    install -m 0644 -t "$out/share/doc/dict-gcide/" "${gcide.out}"/{README,INFO,pronunc.txt};
  '';

  meta = {
    description = "GNU version of the Collaborative International Dictionary of English for dictd et al";
    homepage = "https://deb.debian.org/debian/pool/main/d/${pname}";
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
