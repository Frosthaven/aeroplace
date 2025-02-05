# aeroplace

A helper utility for generating deterministic [Aerospace](https://github.com/nikitabobko/AeroSpace)
application layouts on launch.

## Installation

```bash
brew tap frosthaven/aeroplace
brew install aeroplace
```

## Usage

aeroplace `<workspace>` `<application>` `<title (optional)>`

- workspace: The workspace identifier to place the application in
- application: The application to launch
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
    "exec-and-forget aeroplace '1' '/Applications/Zen Browser.app'; aeroplace '1' '/Applications/WezTerm.app'",
    # wokspace 2 composition
    "exec-and-forget aeroplace '2' '/Applications/Slack.app' ''; aerospace move left --window-id $(aeroplace '2' '/Applications/Discord.app' '- Discord'); aerospace move right --window-id $(aeroplace '2' '/Applications/Obsidian.app' 'Obsidian')",
    # workspace 3 composition
    "exec-and-forget aeroplace '3' '/Applications/Microsoft Outlook.app' ' • '; aeroplace '3' '/Applications/ForkLift.app' ''",
]
```

## @todo

- [ ] Refactor to support named parameters
- [ ] Add support for starting applications OR commands
- [ ] Add parameters for move, join, and resize on new windows
- [ ] Add support for multiple windows of the same application type
