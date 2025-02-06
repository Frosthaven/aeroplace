# aeroplace

A utility for generating deterministic [Aerospace](https://github.com/nikitabobko/AeroSpace)
application layouts on launch.

Load and modify your applications in sequence to gain repeatable layout composition between starts.

THIS IS CURRENTLY IN PRE-RELEASE AND SUBJECT TO CHANGE

## Installation

Install
```bash
brew tap frosthaven/aeroplace
brew install aeroplace
```

Update
```bash
brew update
brew upgrade aeroplace
```

## Usage

aeroplace -w `<workspace>` -a `<application>` [-t `<title>` -m `<modifyCommand>`]

- workspace: The workspace identifier to place the application in
- application: The application name to launch
- title (optional): If provided, the command will wait until the application has
    this text in its title before considering the application launched (useful
    in cases like discord which have a launch screen)
- modifyCommand (optional): A valid aerospace window modification, e.g. `move left`

```bash
# Launch Slack and wait for the title to include '- Slack' before joining it left
aeroplace -w '1' -a 'Slack' -t '- Slack' -m 'join-with left'
```

*Note: Because `aeroplace` commands echo out the window id of the launched
application, you can use the output as the input to any aerospace command that
requires `--window-id`.

## Example

```toml
after-startup-command = [
# aeroplace workspace composition
"""
exec-and-forget \
aeroplace -w 3 -a 'Microsoft Outlook' -t ' • '; \
aeroplace -w 3 -a 'ForkLift'; \
aeroplace -w 2 -a 'Slack'; \
aeroplace -w 2 -a 'Discord' -t 'Friends' -m 'join-with left'; \
aeroplace -w 2 -a 'Obsidian' -m 'move right'; \
aeroplace -w 1 -a 'Zen Browser'; \
aeroplace -w 1 -a 'WezTerm' -m 'focus'; \
""",
]
```

## Roadmap

- [x] Support getopt parameters
- [ ] Extend parameters
    - [x] Add `-m` to enable modification on window creation (join-with, move, etc)
    - [ ] Add `-c` (execute command) as an alternative to `-a` (launch app)
    - [ ] Add `--if-monitor` conditional flag
    - [ ] Add `--if-network` conditional flag
- [ ] Improve window and title detection
    - Currently, we're grepping an entire row from `aerospace list-windows --all` for both the application and the title. We should handle this more intelligently to separate the values out before for comparison.
    - This will allow us to consider *which* index of a window we have to handle cases where we want several windows for the same application
- [ ] Add mechanism to track when all workspaces have completed
    - thought: `aerospace await 3` would initialize and wait for 3 done events before continuing. `aerospace mark done` would increase the curent done counter by 1.
