# Vibox

VSCode Dev Container sandbox for vibe coding. It mounts `~/.claude` and `~/.claude.json` from your host so you can keep your Claude settings.

## Usage

1. Clone and rename. 

    ```sh
    git clone https://github.com/regata/vibox project-name
    ```
2. Open in VSCode.

    ```sh
    code ./project-name
    ```

3. Optionally rename `vibox` references to `project-name`. Paths in devcontainer.json must match the Dockerfile's `NAME` arg.

4. Run `Reopen in Container` from Command Palette in VSCode.

5. Launch Claude inside the dev container.

    ```sh
    claude
    ```