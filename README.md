# ASCII-Runner

An infinite runner in your terminal

If you enjoy ASCII-runner, you might also like [taskell](https://github.com/smallhadroncollider/taskell) - a command-line Kanban board.

![Screenshot](http://files.smallhadroncollider.com/runner-0.2.0.gif)

## Installation

### Binaries

[A binary is available for Mac and Linux](https://github.com/smallhadroncollider/ascii-runner/releases). Download it and copy it to a directory in your `$PATH` (e.g. `/usr/local/bin` or `/usr/bin`).

### Debian/Ubuntu

[A `.deb` package is available for Debian/Ubuntu](https://github.com/smallhadroncollider/ascii-runner/releases). Download it and install with `dpkg -i <package-name>`.

### Fedora

Run `sudo dnf install ncurses-compat-libs` then download and run binary as described below.

### Stack

If none of the above options work you can build ASCII-runner using [Stack](https://docs.haskellstack.org/en/stable/README/). First [install Stack on your machine](https://docs.haskellstack.org/en/stable/README/#how-to-install). Then clone the repo and run `stack build && stack install`: this will build ascii-runner and then install it in `~/.local/bin` (so make sure that directory is in your `$PATH`). Building from scratch can take a long time and occasionally doesn't work the first time (if this happens try running it again).

### Windows

Unfortunately the `vty` package, which this program is heavily dependent on, doesn't currently support Windows. This may change in the future, but for now it means that ASCII-runner is not available for Windows. However, you could [install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) with Ubuntu and then follow the Ubuntu instructions above.

## Usage

Run `runner`

Optionally pass a number for game speed, e.g. `runner 15`. The number represents the number of columns to move per second. 10 is quite easy, 30 is quite hard.

- `Space` to jump
- `q` to quit
- `Enter` to restart after game over

## FAQ

### Why?

Why not

### Seriously?

Yup
