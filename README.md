# <a href="https://github.com/dmarcoux/dotnet_templates">dmarcoux/dotnet_templates</a>

Templates for common files/configs in [.NET](https://dotnet.microsoft.com/)
projects. Here's what's included:

- _.NET Development Environment with Nix Flakes_

  Reproducible development environment for .NET projects which relies on
  [Nix](https://github.com/NixOS/nix) [Flakes](https://nixos.wiki/wiki/Flakes),
  a purely functional and cross-platform package manager.

## How to Use This Template

1. Create a new repository based on this repository:

- Go to this [repository's page](https://github.com/dmarcoux/dotnet_templates),
  click on the `Use this template` button and follow instructions.

  *OR*

- With [GitHub's CLI](https://github.com/cli/cli), run:

  ```bash
  gh repo create NEW_REPOSITORY_NAME --template=dmarcoux/dotnet_templates --clone --private/--public
  ```

2. Search for `CHANGEME` in the newly created repository to adapt it to the
   project's needs.

3. Start development environment:

   ```bash
   nix develop
   ```

4. Once inside the development environment, launch [JetBrains Rider](https://www.jetbrains.com/rider/)
   or another IDE with:

   ```bash
   nohup rider &
   ```

5. Generate `.gitignore` from `dotnet new` and append the content of [.gitignore](./.gitignore):

   ```bash
   dotnet new gitignore && cat .gitignore.template >> .gitignore && rm .gitignore.template
   ```

   _Note: By generating `.gitignore`, we don't have to keep track of the changes in the `dotnew new gitignore` template._

6. Generate `.editorconfig` to follow the default .NET code style:

   ```bash
   dotnet new editorconfig
   ```

   _Note: By generating `.editorconfig`, we don't have to keep track of the changes in the `dotnew new editorconfig` template._

7. Generate  `global.json` to enforce a specific .NET SDK version with .NET CLI commands and continuous integration.

   ```bash
   dotnet new globaljson --roll-forward disable && sed -i -e '1s|^|// Documentation: https://learn.microsoft.com/en-us/dotnet/core/tools/global-json\n// Comments are supported in this JSON file. Refer to the documentation above\n|' global.json
   ```

   _Note: By generating `global.json`, we don't have to manually enter the version number of the .NET SDK installed in the development environment._

8. Adapt this README to the project.
