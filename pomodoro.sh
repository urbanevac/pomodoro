#!/bin/bash

# Pomodoro Timer Script with Enhanced Error Handling and Comments

# Default work and break durations in minutes
WORK_MINUTES=${1:-25}
BREAK_MINUTES=${2:-5}

# Files for logging and statistics
LOG_FILE="pomodoro_log.txt"
STATS_FILE="pomodoro_stats.txt"

# Theme for display
THEME="🔴 Focus Mode"

# Initialize statistics if the file doesn't exist
if [[ ! -f $STATS_FILE ]]; then
  echo "Work Sessions Completed: 0" > $STATS_FILE
  echo "Break Sessions Taken: 0" >> $STATS_FILE
fi

# Function to play a system sound notification
play_sound() {
  afplay /System/Library/Sounds/Glass.aiff 
}

# Function to log a message with timestamp to the log file
log_activity() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG_FILE
}

# Function to update session statistics in the stats file
update_stats() {
  local type=$1

  if [[ "$type" == "work" ]]; then
    # Update work session count using sed
    sed -i.bak "s/\(Work Sessions Completed: \)\([0-9]\+\)/\1$((\2 + 1))/g" "$STATS_FILE"
  elif [[ "$type" == "break" ]]; then
    # Update break session count using sed
    sed -i.bak "s/\(Break Sessions Taken: \)\([0-9]\+\)/\1$((\2 + 1))/g" "$STATS_FILE"
  fi
}

# Function to display a progress bar during a session
show_progress_bar() {
  local duration=$1
  local elapsed=0

  # Validate duration input
  if [[ $duration -eq 0 ]]; then
    echo "Error: Duration cannot be zero."
    return 1
  fi

  while [[ $elapsed -lt $duration ]]; do
    sleep 1
    elapsed=$((elapsed + 1))
    local progress=$((elapsed * 100 / duration))
    local bar_length=$((progress * 50 / 100))

    # Handle case where bar_length is 0 to avoid errors
    if [[ $bar_length -eq 0 ]]; then
      printf "\rWork: [--------------------------------------------------] 0%%"
    else
      printf "\rWork: [%-50s] %d%%" "$(printf "#%.0s" $(seq 1 $bar_length))" $progress
    fi
    sleep 0.1  # Add a slight delay for smoother progress bar animation
  done
  echo ""
}

# Function to run a single work or break session
run_session() {
  local duration=$1
  local message=$2

  echo "$message"
  log_activity "$message"
  show_progress_bar $((duration * 60))  # Convert minutes to seconds
  play_sound
}

# Main program loop
while true; do
  # Run a work session
  run_session $WORK_MINUTES "$THEME: Work Session Started for $WORK_MINUTES minutes."
  update_stats "work"

  echo "Take a break!"
  sleep 1

  # Run a break session
  run_session $BREAK_MINUTES "$THEME: Break Session Started for $BREAK_MINUTES minutes."
  update_stats "break"

  echo "Back to work!"
  sleep 1

  # Display current session statistics
  echo "\nSession Statistics:"
  cat $STATS_FILE
  echo ""
done