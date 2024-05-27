# <a href="https://github.com/dmarcoux/dotnet_templates">dmarcoux/dotnet_templates</a>

Templates for common files/configs in [.NET](https://dotnet.microsoft.com/)
projects. Here's what's included:

- _.NET Development Environment with nix-shell_

  Reproducible development environment for .NET projects which relies on
  [Nix](https://github.com/NixOS/nix), a purely functional and cross-platform
  package manager.

## How to Use This Template

1. Create a new repository based on this repository:

- Go to this [repository's page](https://github.com/dmarcoux/dotnet_templates),
  click on the `Use this template` button and follow instructions.

  *OR*

- With [GitHub's CLI](https://github.com/cli/cli), run:

  ```bash
  gh repo create NEW_REPOSITORY_NAME --template=dmarcoux/dotnet_templates --clone --private/--public
  ```

2. Search for `CHANGEME` in the newly created repository to adapt it to your
   needs.

3. I use the [JetBrains Rider](https://www.jetbrains.com/rider/) IDE, launch it
   within the nix-shell environment with:

   ```bash
   nix-shell --run 'nohup rider &'
   ```

4. Start development environment with only the packages from the nix-shell:

   ```bash
   nix-shell --pure
   ```

5. Generate `.gitignore` from `dotnet new` and append the content of [.gitignore](./.gitignore):

   ```bash
   dotnet new gitignore && cat .gitignore.template >> .gitignore && rm .gitignore.template
   ```

6. Adapt this README to the project.
