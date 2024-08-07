{
  description = ".NET development environment based on the Filesystem Hierarchy Standard (FHS)";
  # https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard

  inputs = {
    # Use https://www.nixhub.io/ to easily find the exact commit to use in order to pin an input (and its packages) to a specific version
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # TODO: Wait for a fix regarding this issue https://github.com/jetify-com/devbox/issues/2191
    # nixpgs_dotnet_sdk = ""
    nixpkgs_just.url = "github:nixos/nixpkgs/ab82a9612aa45284d4adf69ee81871a389669a9e";
    # TODO: Look into https://github.com/numtide/flake-utils to see if it would be useful
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = "${system}"; config.allowUnfree = true; };

    # .NET SDK
    # Installing multiple SDKs (if needed somehow...) with `dotnetCorePackages.combinePackages` breaks JetBrains Rider - https://youtrack.jetbrains.com/issue/RIDER-85715/Rider-no-longer-automatically-loads-Dotnet-from-a-Nix-Flake-dev-shell-environment
    dotnet_sdk = pkgs.dotnetCorePackages.sdk_8_0;

    # https://github.com/casey/just
    just = inputs.nixpkgs_just.legacyPackages.${system}.pkgs.just;

    # Bundle of SSL certificates
    cacert = pkgs.cacert;
  in
  {
    # Create development shell based on the Filesystem Hierarchy Standard (FHS) with a set of
    # standard packages based on the list maintained by the appimagetools package
    #
    # buildFHSEnv -> https://nixos.org/manual/nixpkgs/stable/#sec-fhs-environments
    #
    # The packages included in appimagetools.defaultFhsEnvArgs are:
    # https://github.com/NixOS/nixpkgs/blob/fd6a510ec7e84ccd7f38c2ad9a55a18bf076f738/pkgs/build-support/appimage/default.nix#L72-L208
    devShells.${system}.default = (pkgs.buildFHSEnv (pkgs.appimageTools.defaultFhsEnvArgs // {
          name = "dotnet-development-environment";
          # Packages installed in the development shell
          targetPkgs = pkgs: with pkgs; [
            # .NET SDK
            dotnet_sdk
            # Run PowerShell scripts, which are sometimes included in NuGet packages like Playwright
            powershell
            # Timezones
            tzdata
            # Locales
            glibcLocales
            # Bundle of SSL certificates
            cacert
            # Command runner
            just
          ];
          # Commands to be executed in the development shell
          profile = ''
            # Ensure that dotnet tools can find the .NET location
            export DOTNET_ROOT="${dotnet_sdk}";

            # Set LANG for locales
            export LANG="C.UTF-8"

            # Remove duplicate commands from Bash shell command history
            export HISTCONTROL=ignoreboth:erasedups

            # Do not pollute $HOME with config files (both paths are ignored in .gitignore)
            export DOTNET_CLI_HOME="$PWD/.net_cli_home";
            export NUGET_PACKAGES="$PWD/.nuget_packages";

            # Put dotnet tools in $PATH to be able to use them
            export PATH="$DOTNET_CLI_HOME/.dotnet/tools:$PATH"

            # Without this, there are warnings about LANG, LC_ALL and locales.
            # Many tests fail due those warnings showing up in test outputs too...
            # This solution is from: https://gist.github.com/aabs/fba5cd1a8038fb84a46909250d34a5c1
            export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"

            # For the bundle of SSL certificates to be used in applications (like curl and others...)
            export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
          '';
        })).env;
  };
}
