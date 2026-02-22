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

3. Install tools to run the commands from the next steps:

   ```bash
   mise install
   ```

4. Generate `.gitignore` from `dotnet new`:

   ```bash
   dotnet new gitignore
   ```

   _Note: By generating `.gitignore`, we don't have to keep track of the changes in the `dotnew new gitignore` template._

5. Generate `.editorconfig` to follow the default .NET code style:

   ```bash
   dotnet new editorconfig
   ```

   _Note: By generating `.editorconfig`, we don't have to keep track of the changes in the `dotnew new editorconfig` template._

6. Generate  `global.json` to enforce a specific .NET SDK version with .NET CLI commands and continuous integration.

   ```bash
   mise run generateGlobalJson
   ```

   _Note: By generating `global.json`, we don't have to manually enter the version number of the .NET SDK installed in the development environment._

7. Adapt this README to the project. This complete section can be deleted...

# Development Environment

Rely on [Mise](https://mise.jdx.dev/) to install tools, set environment
variables, and run tasks. Refer to [mise.toml](mise.toml) for details. The Mise
documentation is there to help you get started, there's no need to repeat it all
here. It boils down to activating Mise (_optional_), installing tools, and
running tasks.

Install tools with:

```bash
mise install
```

See available tasks with:

```bash
mise run
```

## Continuous Integration with GitHub Actions

The [continuous integration](./.github/workflows/continuous_integration.yml)
builds the solution with code analyzers (set in
[Directory.Build.props](./Directory.Build.props)), verifies that all code is
correctly formatted and runs tests to ensure the codebase stays in a workable
state while upholding code quality standards.
