# This file is based on:
# https://github.com/NixOS/nixpkgs/blob/3ab807f275232d227e846b5947775dc99e24e63c/doc/languages-frameworks/dotnet.section.md
# https://nixos.wiki/wiki/DotNET

# To ensure this nix-shell is reproducible, we pin the packages index to a commit SHA taken from a channel on https://status.nixos.org/
# This commit is from NixOS 24.05 (28-06-2024)
with (import (fetchTarball https://github.com/NixOS/nixpkgs/archive/89c49874fb15f4124bf71ca5f42a04f2ee5825fd.tar.gz) { config.allowUnfree = true; });

let
  # Define variables for packages which are referenced more than once in this nix-shell
  dotnet_sdk = (with dotnetCorePackages; combinePackages [
    # Install all the .NET versions needed here...
    sdk_8_0
    # sdk_7_0
  ]);
in
  mkShell {
    name = "dotnet-env";

    packages = [
      # .NET SDK
      dotnet_sdk
      # Run PowerShell scripts, which are sometimes included in NuGet packages like Playwright
      powershell
      # Timezones
      tzdata
      # Locales
      glibcLocales
    ];

    shellHook = ''
      # Ensure that dotnet tools can find the .NET location
      export DOTNET_ROOT="${dotnet_sdk}";

      # Set LANG for locales, otherwise it is unset when running "nix-shell --pure"
      export LANG="C.UTF-8"

      # Remove duplicate commands from Bash shell command history
      export HISTCONTROL=ignoreboth:erasedups

      # Do not pollute $HOME with config files (both paths are ignored in .gitignore)
      export DOTNET_CLI_HOME="$PWD/.net_cli_home";
      export NUGET_PACKAGES="$PWD/.nuget_packages";

      # Put dotnet tools in $PATH to be able to use them
      export PATH="$DOTNET_CLI_HOME/.dotnet/tools:$PATH"
    '';

    # Without this, there are warnings about LANG, LC_ALL and locales.
    # Many tests fail due those warnings showing up in test outputs too...
    # This solution is from: https://gist.github.com/aabs/fba5cd1a8038fb84a46909250d34a5c1
    LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
  }
