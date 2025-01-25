# Pomodoro Timer (Command Line App)

A macOS command-line Pomodoro timer designed to boost your productivity and focus. This app includes features such as progress bars, pause/resume functionality, macOS notifications, sound alarms, detailed session logging, and cumulative session statistics.

---

## Features

- **Customizable Durations:** Set your own work and break session lengths.
- **Progress Bar:** Visual representation of elapsed time for each session.
- **Pause/Resume Functionality:** Pause and resume sessions as needed.
- **MacOS Notifications:** Receive desktop alerts at the start of work and break sessions.
- **Sound Alerts:** Plays an audio notification when a session ends.
- **Session Logging:** Logs all session activities with timestamps into `pomodoro_log.txt`.
- **Statistics Tracking:** Tracks completed work and break sessions in `pomodoro_stats.txt` and displays updated stats after every cycle.
- **Themes:** Personalize your Pomodoro experience with different themes.

---

## Requirements

- **macOS**
- **Bash Shell** (pre-installed on macOS)

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/urbanevac/pomodoro.git
   cd pomodoro-timer
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x pomodoro.sh
   ```

3. **Optional: Install the Man Page**:
   Save the provided man page file (`pomodoro.1`) to a directory in your `MANPATH` (e.g., `/usr/local/share/man/man1/`):
   ```bash
   sudo mv pomodoro.1 /usr/local/share/man/man1/
   man -w  # Update the man database
   ```
   Access the manual with:
   ```bash
   man pomodoro
   ```

---

## Usage

Run the app with customizable durations or defaults:

- **Default Usage** (25 minutes work, 5 minutes break):
  ```bash
  ./pomodoro.sh
  ```

- **Custom Durations**:
  ```bash
  ./pomodoro.sh [work_minutes] [break_minutes]
  ```
  Example:
  ```bash
  ./pomodoro.sh 30 10
  ```

---

## Controls

- **Pause:** Press `p` during a session to pause the timer.
- **Resume:** Press `r` to resume the timer.
- **Stop:** Press `Ctrl+C` to exit the app.

---

## Logs and Statistics

- **Session Logs:**
  - Saved in `pomodoro_log.txt` in the script's directory.
  - Example entry:
    ```
    [2025-01-25 12:30:00] Work Session Started for 25 minutes.
    [2025-01-25 12:55:00] Break Session Started for 5 minutes.
    ```

- **Statistics:**
  - Saved in `pomodoro_stats.txt` in the script's directory.
  - Example:
    ```
    Work Sessions Completed: 3
    Break Sessions Taken: 3
    ```

---

## Example Output

When running the script, you will see the following:

- **Progress Bar:**
  ```
  Work: [####################--------------------] 50%
  ```

- **Statistics Display:**
  ```
  Session Statistics:
  Work Sessions Completed: 3
  Break Sessions Taken: 3
  ```

---

## Customization

1. **Themes:**
   Modify the `THEME` variable in the script to change the session theme (e.g., "🔴 Focus Mode").

2. **Sounds:**
   Replace the sound file used in the `play_sound` function with your custom audio file.
   ```bash
   afplay /path/to/your/custom_sound.aiff
   ```

---

## Author

[Your Name]

---

## License

This project is licensed under the MIT License. Feel free to use, modify, and distribute it as needed.

---

## Future Enhancements

- **Daily/Weekly Summary:** Show completed sessions by day or week.
- **Focus Sounds:** Optionally play ambient sounds during work sessions.
- **Custom Themes:** Allow users to define their own themes in a configuration file.
- **Interactive Menus:** Provide a user-friendly interactive menu for controlling sessions.

---

Enjoy staying productive with your new Pomodoro Timer!

