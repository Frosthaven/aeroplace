# aeroplace

THIS IS CURRENTLY IN PRE-RELEASE AND SUBJECT TO CHANGE

A utility for generating deterministic [Aerospace](https://github.com/nikitabobko/AeroSpace)
application layouts on launch.

## Installation

```bash
brew tap frosthaven/aeroplace
brew install aeroplace
```

## Updating

```bash
brew update
brew upgrade aeroplace
```

## Usage

aeroplace -w `<workspace>` -a `<application>` [-t `<title>`]

- workspace: The workspace identifier to place the application in
- application: The application name to launch
- title (optional): If provided, the command will wait until the application has
    this text in its title before considering the application launched (useful
    in cases like discord which have a launch screen)

```bash
# Launch Slack and wait for the title to include '- Slack'
aeroplace -w '1' -a 'Slack' -t '- Slack'
```

## Example
*Note: Because `aeroplace` commands echo out the window id of the launched
application, you can use the output of one command as the input to another.
This is shown below, where we manipulate the Discord and Obsidian windows on
workspace 2.*

```toml
# aeroplace workspace composition - each workspace builds in its own
# parallel process
after-startup-command = [
# workspace 1
"""
exec-and-forget \
aeroplace -w 1 -a 'Zen Browser'; \
aeroplace -w 1 -a 'WezTerm';
""",

# workspace 2
"""
exec-and-forget \
aeroplace -w 2 -a 'Slack'; \
aerospace join left --window-id $(aeroplace -w 2 -a 'Discord' -t 'Friends'); \
aerospace move right --window-id $(aeroplace -w 2 -a 'Obsidian');
""",

# workspace 3
"""
exec-and-forget \
aeroplace -w 3 -a 'Microsoft Outlook' -t ' • '; \
aeroplace -w 3 -a 'ForkLift';
"""
]
```

## Roadmap

- [x] Support getopt parameters
- [ ] Extend parameters
    - [ ] Add `-c` (execute command) as an alternative to `-a` (launch app)
    - [ ] Add `-m` to move window up|down|left|right
    - [ ] Add `-j` to join window up|down|left|right
    - [ ] Add `-s` to smart resize up and down
    - [ ] Add `--if-monitor` conditional flag
    - [ ] Add `--if-network` conditional flag
- [ ] Improve window and title detection
    - Currently, we're grepping an entire row from `aerospace list-windows --all` for both the application and the title. We should handle this more intelligently to separate the values out before for comparison.
    - This will allow us to consider *which* index of a window we have to handle cases where we want several windows for the same application
- [ ] Add mechanism to track when all workspaces have completed
    - thought: `aerospace await 3` would initialize and wait for 3 done events before continuing. `aerospace mark done` would increase the curent done counter by 1.
