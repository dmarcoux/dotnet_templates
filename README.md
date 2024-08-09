# <a href="https://github.com/dmarcoux/dotnet_templates">dmarcoux/dotnet_templates</a>

Templates for common files/configs in [.NET](https://dotnet.microsoft.com/)
projects. The continuous integration is
[disabled](https://docs.github.com/en/actions/using-workflows/disabling-and-enabling-a-workflow)
in this template repository since there is no solution, thus avoiding
unnecessary runs.

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

3. Start the development environment to run the commands from the next steps:

   ```bash
   nix develop
   ```

4. Generate `.gitignore` from `dotnet new` and append the content of [.gitignore](./.gitignore):

   ```bash
   dotnet new gitignore && cat .gitignore.template >> .gitignore && rm .gitignore.template
   ```

   _Note: By generating `.gitignore`, we don't have to keep track of the changes in the `dotnew new gitignore` template._

5. Generate `.editorconfig` to follow the default .NET code style:

   ```bash
   dotnet new editorconfig
   ```

   _Note: By generating `.editorconfig`, we don't have to keep track of the changes in the `dotnew new editorconfig` template._

6. Generate  `global.json` to enforce a specific .NET SDK version with .NET CLI commands and continuous integration.

   ```bash
   just generateGlobalJson
   ```

   _Note: By generating `global.json`, we don't have to manually enter the version number of the .NET SDK installed in the development environment._

7. Adapt this README to the project. This complete section can be deleted...

## .NET Development Environment with Nix Flakes

Reproducible development environment for .NET projects which relies on
[Nix](https://github.com/NixOS/nix) [Flakes](https://nixos.wiki/wiki/Flakes),
a purely functional and cross-platform package manager.

**Start development environment:**

```bash
nix develop
```

**Once inside the development environment...**

_...launch [JetBrains Rider](https://www.jetbrains.com/rider/) or another IDE:_

```bash
# Launch JetBrains Rider
just code
# Launch Visual Studio Code
just code code
```

_...or perhaps execute any of the other [just](https://github.com/casey/just)
recipes/commands included in the [justfile](./justfile):_

```bash
# List all available just recipes
just
```

## Continuous Integration with GitHub Actions

The [continuous integration](./.github/workflows/continuous_integration.yml)
builds the solution with code analyzers (set in
[Directory.Build.props](./Directory.Build.props)), verifies that all code is
correctly formatted and runs tests to ensure the codebase stays in a workable
state while upholding code quality standards.
