# Documentation: https://github.com/casey/just

# TODO: Look into the following to improve the recipes below
#   https://github.com/casey/just?tab=readme-ov-file#recipe-parameters
#   https://github.com/casey/just?tab=readme-ov-file#selecting-recipes-to-run-with-an-interactive-chooser

# TODO: Create recipes to update the revision of every input (nix flake update)

# Default recipe will list all just recipes in the order they appear in this justfile
default:
  just --list --unsorted

[doc("Restore dependencies of the solution without updating `packages.lock.json`")]
restore:
  dotnet restore --locked-mode

[doc("Verify that all code of the solution is correctly formatted")]
format:
  dotnet format --no-restore --verify-no-changes

[doc("Build the solution without restoring its dependencies")]
build:
  dotnet build --no-restore

[doc("Run tests for the solution without building it")]
test:
  dotnet test --no-build --verbosity normal

[doc("Run the same recipes as in the continous integration, and in the same order")]
ci: restore format build test

[doc("Run the specified project (defaults to the current directory if there is only one project)")]
[no-cd] # Run in the directory where the just recipe is called
run project=("." / "") *options='':
  dotnet run --project "{{project}}" {{options}}

[doc("Generate global.json after manually changing the .NET SDK package in `flake.nix` or updating `flake.lock`")]
generateGlobalJson:
  # The .NET SDKs have been updated when manually changing the packages in `flake.nix` or by recreating `flake.lock` to update
  # the revision of every input to its current revision with `nix flake update`.
  #
  # Without removing global.json, the dotnet CLI won't execute commands due to a mismatch in the .NET SDK version. So global.json has to be removed first.
  rm --force global.json
  dotnet new globaljson --roll-forward disable
  # Mention documentation in comments at the top of global.json
  sed -i -e '1s|^|// Documentation: https://learn.microsoft.com/en-us/dotnet/core/tools/global-json\n// Comments are supported in this JSON file. Refer to the documentation above\n|' global.json

just_version := replace(`just --version`, 'just ', '')

[doc("Pin the just version in the continuous integration")]
pinJustVersionCI:
  sed -i -E 's|(^\s*just-version: )(.*)|\1{{just_version}}|g' .github/workflows/continuous_integration.yml
