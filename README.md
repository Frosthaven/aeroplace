# AeroPlace

A utility for generating deterministic [AeroSpace](https://github.com/nikitabobko/AeroSpace)
application layouts on launch.

THIS IS CURRENTLY IN PRE-RELEASE AND SUBJECT TO CHANGE

## How it works

Each call to this utility will:

- Create an application window on the designated workspace
- Wait for the window to load (and optionally wait for the title to contain specific text)
- Optionally manipulate the window using aerospace commands
- Exit

This allows you to build a deterministic layout of applications by placing several calls
in sequence.

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

```shell
aeroplace -w workspaceID -a appName [-t titleContent -m modifyCommands]
        -w The ID of the workspace to move the app to (0-9,a-z)
        -a The name of the app file to open, e.g. 'Google Chrome'
        -t The title content to look for, which indicates the app is loaded
        -m Aerospace window commands, e.g. 'move left, resize smart -100'
```

```toml
after-startup-command = [

"""
exec-and-forget \

aeroplace -w 1 -a 'Zen Browser'; \
aeroplace -w 1 -a 'WezTerm' -m 'resize smart -300, focus'; \

aeroplace -w 2 -a 'Microsoft Outlook' -t ' • '; \
aeroplace -w 2 -a 'Slack'; \
aeroplace -w 2 -a 'Discord' -t 'Friends' -m 'join-with left, resize width -100'; \

aeroplace -w 3 -a 'ForkLift'; \
aeroplace -w 3 -a 'Obsidian'; \

afplay /System/Library/Sounds/Sosumi.aiff; \
"""

]
```

## Sequence of Events

This is what the sequence of events looks like for the workspace 2 placements above (`-w 2`):

![image](https://github.com/user-attachments/assets/a4029aca-5c3d-4c7e-9eb0-f1ec181093cd)

## Roadmap

- [x] Support getopt parameters
- [ ] Extend parameters
    - [x] Add `-m` to enable modification on window creation (join-with, move, etc)
        - [x] Allow multiple commands in `-m` (comma separated)
    - [ ] Add `-c` (execute command) as an alternative to `-a` (launch app)
    - [ ] Add `--if-monitor` conditional flag
    - [ ] Add `--if-network` conditional flag
- [ ] Improve window and title detection
    - Currently, we're grepping an entire row from `aerospace list-windows --all` for both the application and the title. We should handle this more intelligently to separate the values out before for comparison.
    - This will allow us to consider *which* index of a window we have to handle cases where we want several windows for the same application
- [ ] Add mechanism to track when all workspaces have completed
    - thought: `aerospace await 3` would initialize and wait for 3 done events before continuing. `aerospace mark done` would increase the curent done counter by 1.
