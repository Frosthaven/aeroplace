# aeroplace

A helper utility for generating deterministic [Aerospace](https://github.com/nikitabobko/AeroSpace)
application layouts on launch.

## Installation

```bash
brew tap frosthaven/aeroplace
brew install aeroplace
```

## Usage

aeroplace -w `<workspace>` -a `<application>` -t `<title (optional)>`

- workspace: The workspace identifier to place the application in
- application: The application PATH to launch (e.g. /Applications/Slack.app)
- title (optional): If provided, the command will wait until the application has
    this text in its title before considering the application launched (useful
    in cases like discord which have a launch screen)

*Note: This command will return the window id of the launched application. This
will allow you to feed the ID into other aerospace commands if desired.*

```bash
aeroplace '1' '/Applications/Slack.app' '- Slack'
```

## Example

```toml
after-startup-command = [
    # workspace 1 composition
    "exec-and-forget aeroplace -w 1 -a '/Applications/Zen Browser.app'; aeroplace -w 1 '/Applications/WezTerm.app'",
    # wokspace 2 composition
    "exec-and-forget aeroplace -w 2 -a '/Applications/Slack.app'; aerospace move left --window-id $(aeroplace -w 2 -a '/Applications/Discord.app' -t '- Discord'); aerospace move right --window-id $(aeroplace -w '2' -a '/Applications/Obsidian.app' -t 'Obsidian')",
    # workspace 3 composition
    "exec-and-forget aeroplace '3' '/Applications/Microsoft Outlook.app' ' • '; aeroplace '3' '/Applications/ForkLift.app' ''",
]
```

## @todo

- [ ] Refactor to support named parameters
- [ ] Add support for starting applications OR commands
- [ ] Add parameters for move, join, and resize on new windows
- [ ] Add support for multiple windows of the same application type
