
# Pomodoro Timer Bash Script

A simple and customizable Pomodoro timer implemented in Bash. It helps you stay focused by alternating between work sessions and breaks, following the Pomodoro technique.

## Features
- **Work Sessions**: Customizable work duration (default: 25 minutes).
- **Breaks**: Short (default: 5 minutes) and long (default: 15 minutes) breaks.
- **Cycles**: Configurable number of work cycles before a long break (default: 4).
- **Progress Bar**: Visual progress bar to show remaining time for each session.
- **Cross-Platform Notifications**: Notifications for MacOS (via `osascript`) and Linux (via `notify-send`).
- **Logging**: All session events are logged for later review.
- **Clean Exit**: Handles exit signals gracefully with a message.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/urbanevac/pomodoro.git
   cd pomodoro
   ```

2. Make the script executable:
   ```bash
   chmod +x pomodoro.sh
   ```

3. Run the script:
   ```bash
   ./pomodoro.sh
   ```

## Configuration
Configuration is stored in a file at `~/.config/pomodoro/config.sh`. You can modify the default values there or set custom values using command-line options.

### Default Settings:
- Work Duration: 25 minutes
- Break Duration: 5 minutes
- Long Break Duration: 15 minutes
- Cycles Before Long Break: 4

## Command-Line Options
You can customize the timer duration and number of cycles using the following options:

```bash
Usage: ./pomodoro.sh [options]
Options:
  -w, --work     Set work session duration (default: 25 min)
  -b, --break    Set short break duration (default: 5 min)
  -l, --long     Set long break duration (default: 15 min)
  -c, --cycles   Set cycles before long break (default: 4)
  -h, --help     Show this help message
```

Example:
```bash
./pomodoro.sh -w 30 -b 10 -l 20 -c 3
```
This will set the work session to 30 minutes, short break to 10 minutes, long break to 20 minutes, and require 3 cycles before a long break.

## Logging
Logs are stored in `~/.config/pomodoro/logs/pomodoro.log`. Each event, such as starting a work session or taking a break, is logged with a timestamp.

## Cross-Platform Support
This script supports notifications on both macOS and Linux:
- macOS: Uses `osascript` for native notifications.
- Linux: Uses `notify-send` for notifications.

## Exit Handling
Press `Ctrl+C` or `Ctrl+Z` to stop the timer. The script will display a message and exit cleanly.

## Example Output
```bash
🍅 Pomodoro Timer Started 🍅
[2025-01-25 10:00:00] Starting Work Session
🍅 Focus: Work Session [##########################------------------] 50%
...
[2025-01-25 10:25:00] Long Break Session
🌿 Long Break [#######################----------------------------] 60%
...
```

## License
MIT License. See [LICENSE](LICENSE) for more details.
