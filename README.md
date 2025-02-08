# AeroPlace

A utility for generating deterministic [AeroSpace](https://github.com/nikitabobko/AeroSpace)
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

## How it works

Each call to this utility will:

- Create an application window on the designated workspace
- Wait for the window to load (and optionally wait for the title to contain specific text)
- Manipulate the window using aerospace commands
- Exit, outputting the window ID as a response

This allows you to build a deterministic layout of applications by placing several calls
in sequence. You can also use the output of this utility's call as the input to any command
that requires a window id.


## Sequence of Events

Using the commands from above for workspace 2, we can illustrate the sequence of events:

```sh
aeroplace -w 2 -a 'Microsoft Outlook' -t ' • '; 
aeroplace -w 2 -a 'Slack';
aeroplace -w 2 -a 'Discord' -t 'Friends' -m 'join-with left, resize width -100';
```

![image](https://github.com/user-attachments/assets/b15b8dda-20be-4f67-b03c-5cb58242d807)

## Current Limitations

This utility currently has the following limitations:

- Only one instance of an application can be handled at a time. This will change.
- Avoid placing the application's name in the optional `-t` flag, as the search
  comparison gets confused and will return a false positive. This will change.

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
