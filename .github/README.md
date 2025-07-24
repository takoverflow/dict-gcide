# Dict GCIDE
[heading__top]:
  #dict-gcide
  "&#x2B06; Nix package for GNU version of the Collaborative International Dictionary of English for dictd et al."


Nix package for GNU version of the Collaborative International Dictionary of
English for dictd et al.

## [![Byte size of Dict Gcide][badge__main__dict_gcide__source_code]][dict_gcide__main__source_code] [![Open Issues][badge__issues__dict_gcide]][issues__dict_gcide] [![Open Pull Requests][badge__pull_requests__dict_gcide]][pull_requests__dict_gcide] [![Latest commits][badge__commits__dict_gcide__main]][commits__dict_gcide__main]  [![License][badge__license]][branch__current__license]


---


- [:arrow_up: Top of Document][heading__top]
- [:building_construction: Requirements][heading__requirements]
- [&#x1F9F0; Usage][heading__usage]
- [:chart_with_upwards_trend: Contributing][heading__contributing]
  - [:trident: Forking][heading__forking]
  - [:currency_exchange: Sponsor][heading__sponsor]
- [:card_index: Attribution][heading__attribution]
- [:balance_scale: Licensing][heading__license]


---


## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; Prerequisites and/or dependencies that this project needs to function properly"


Install the NixOS and/or Nix package manager via official instructions;

> `https://nixos.org/nixos/manual/`


______


## Usage
[heading__usage]:
  #usage
  "&#x1F9F0; How to utilize this repository"


This repository may be installed, and managed, via Nix Flake

> `flake.nix` **(example)**

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs-24.05";

    dict-gcide = {
      url = "github:nix-utilities/dict-gcide-main";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, dict-gcide }@attrs: {
    nixosConfigurations."your-host-name" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
  };
}
```

> `configuration.nix` **(snipet)**

```nix
{ config, pkgs, nixpkgs, dict-gcide, ... }:

{
  ## ... other configurations redacted...

  ## Add `dict-gcide` to `services.dictd.DBs` list
  services.dictd = {
    enable = true;
    DBs = [
      (pkgs.callPackage  dict-gcide { inherit pkgs; })
    ];
  };
}
```

Then rebuild as usual;

```bash
sudo nixos-rebuild switch --flake '.#'
```


______


## Contributing
[heading__contributing]:
  #contributing
  "&#x1F4C8; Options for contributing to dict-gcide and nix-utilities"


Options for contributing to dict-gcide and nix-utilities


---


### Forking
[heading__forking]:
  #forking
  "&#x1F531; Tips for forking dict-gcide"


Start making a [Fork][dict_gcide__fork_it] of this repository to an account
that you have write permissions for.


- Add remote for fork URL. The URL syntax is _`git@github.com:<NAME>/<REPO>.git`_...


```Bash
cd ~/git/hub/nix-utilities/dict-gcide

git remote add fork git@github.com:<NAME>/dict-gcide.git
```


- Commit your changes and push to your fork, eg. to fix an issue...


```Bash
cd ~/git/hub/nix-utilities/dict-gcide


git commit -F- <<'EOF'
:bug: Fixes #42 Issue


**Edits**


- `<SCRIPT-NAME>` script, fixes some bug reported in issue
EOF


git push fork main
```


> Note, the `-u` option may be used to set `fork` as the default remote, eg.
> _`git push -u fork main`_ however, this will also default the `fork` remote
> for pulling from too! Meaning that pulling updates from `origin` must be done
> explicitly, eg. _`git pull origin main`_


- Then on GitHub submit a Pull Request through the Web-UI, the URL syntax is
  _`https://github.com/<NAME>/<REPO>/pull/new/<BRANCH>`_


> Note; to decrease the chances of your Pull Request needing modifications
> before being accepted, please check the
> [dot-github](https://github.com/nix-utilities/.github) repository for
> detailed contributing guidelines.


---


### Sponsor
  [heading__sponsor]:
  #sponsor
  "&#x1F4B1; Methods for financially supporting nix-utilities that maintains dict-gcide"


Thanks for even considering it!


Via Liberapay you may
<sub>[![sponsor__shields_io__liberapay]][sponsor__link__liberapay]</sub> on a
repeating basis.


Regardless of if you're able to financially support projects such as dict-gcide
that nix-utilities maintains, please consider sharing projects that are useful
with others, because one of the goals of maintaining Open Source repositories
is to provide value to the community.


______


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [AUR -- `dict-gcide`](https://aur.archlinux.org/packages/dict-gcide)
- [GNU -- GCIDE](https://gcide.gnu.org.ua/)
- [GitHub -- `NixOs/nixpkgs` -- Issue `248974` -- Package request: dict-gcide](https://github.com/NixOs/nixpkgs/issues/248974)
- [GitHub -- `github-utilities/make-readme`](https://github.com/github-utilities/make-readme)
- [Nix Book -- Simple C program](https://book.divnix.com/ch06-01-simple-c-program.html)
- [NixOS Manual -- Quick Start to Adding a Package](https://nixos.org/manual/nixpkgs/stable/#chap-quick-start)
- [NixOS Wiki -- Nixpkgs/Create and debug packages](https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages)


______


## License
[heading__license]:
  #license
  "&#x2696; Legal side of Open Source"


```
Nix package for GNU version of the Collaborative International Dictionary of English for dictd et al.
Copyright (C) 2025 S0AndS0

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <https://www.gnu.org/licenses/>.
```


For further details review full length version of
[GPL-3.0][branch__current__license] License.



[branch__current__license]:
  /LICENSE
  "&#x2696; Full length version of GPL-3.0 License"

[badge__license]:
  https://img.shields.io/github/license/nix-utilities/dict-gcide

[badge__commits__dict_gcide__main]:
  https://img.shields.io/github/last-commit/nix-utilities/dict-gcide/main.svg

[commits__dict_gcide__main]:
  https://github.com/nix-utilities/dict-gcide/commits/main
  "&#x1F4DD; History of changes on this branch"

[dict_gcide__community]:
  https://github.com/nix-utilities/dict-gcide/community
  "&#x1F331; Dedicated to functioning code"

[issues__dict_gcide]:
  https://github.com/nix-utilities/dict-gcide/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."

[dict_gcide__fork_it]:
  https://github.com/nix-utilities/dict-gcide/fork
  "&#x1F531; Fork it!"

[pull_requests__dict_gcide]:
  https://github.com/nix-utilities/dict-gcide/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"

[dict_gcide__main__source_code]:
  https://github.com/nix-utilities/dict-gcide/
  "&#x2328; Project source!"

[badge__issues__dict_gcide]:
  https://img.shields.io/github/issues/nix-utilities/dict-gcide.svg

[badge__pull_requests__dict_gcide]:
  https://img.shields.io/github/issues-pr/nix-utilities/dict-gcide.svg

[badge__main__dict_gcide__source_code]:
  https://img.shields.io/github/repo-size/nix-utilities/dict-gcide

[sponsor__shields_io__liberapay]:
  https://img.shields.io/static/v1?logo=liberapay&label=Sponsor&message=nix-utilities

[sponsor__link__liberapay]:
  https://liberapay.com/nix-utilities
  "&#x1F4B1; Sponsor developments and projects that nix-utilities maintains via Liberapay"

