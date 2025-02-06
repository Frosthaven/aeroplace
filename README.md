# aeroplace

A utility for generating deterministic [Aerospace](https://github.com/nikitabobko/AeroSpace)
application layouts on launch.

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

```sh
aeroplace -w workspaceID -a appName [-t titleContent -m modifyCommand]
        -w The ID of the workspace to move the app to (0-9,a-z)
        -a The name of the app file to open, e.g. 'Google Chrome'
        -t The title content to look for, which indicates the app is loaded
        -m A valid aerospace window modification, e.g. 'move left'
```

```toml
after-startup-command = [

# aeroplace workspace composition - we load our primary workspace last
# so that it is easy to put the focus at the end of the load sequence

"""
exec-and-forget \
aeroplace -w 3 -a 'Microsoft Outlook' -t ' • '; \
aeroplace -w 3 -a 'ForkLift'; \
aeroplace -w 2 -a 'Slack'; \
aeroplace -w 2 -a 'Discord' -t 'Friends' -m 'join-with left'; \
aeroplace -w 2 -a 'Obsidian' -m 'move right'; \
aeroplace -w 1 -a 'Zen Browser'; \
aeroplace -w 1 -a 'WezTerm' -m 'focus'; \
afplay /System/Library/Sounds/Sosumi.aiff; \
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
