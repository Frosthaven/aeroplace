# aeroplace

A helper utility for generating deterministic [Aerospace](https://github.com/nikitabobko/AeroSpace)
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
- application: The application name to launch (as seen in ``)
- title (optional): If provided, the command will wait until the application has
    this text in its title before considering the application launched (useful
    in cases like discord which have a launch screen)

*Note: This command will return the window id of the launchedlication. This
will allow you to feed the ID into other aerospace commands if desired.*

```bash
# Launch Slack and wait for the title to include '- Slack'
aeroplace -w '1' -a 'Slack' -t '- Slack'
```

## Example

```toml
# aeroplace workspace composition - each workspace builds in its own
# parallel process
after-startup-command = [
# workspace 1
"""
exec-and-forget \
aeroplace -w 1 -a 'Zen Browser'; \
aeroplace -w 1 -a 'WezTerm'
""",

# workspace 2
"""
exec-and-forget \
aeroplace -w 2 -a 'Slack'; \
aerospace join left --window-id $(aeroplace -w 2 -a 'Discord' -t '- Discord'); \
aerospace move right --window-id $(aeroplace -w 2 -a 'Obsidian' -t 'Obsidian');
""",

# workspace 3
"""
exec-and-forget \
aeroplace -w 3 -a 'Microsoft Outlook' -t ' • '; \
aeroplace -w 3 -a 'ForkLift'
"""
]
```

## @todo

- [ ] Refactor to support named parameters
- [ ] Add support for startinglications OR commands
- [ ] Add parameters for move, join, and resize on new windows
- [ ] Add support for multiple windows of the samelication type
