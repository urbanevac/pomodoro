#!/usr/bin/env bash

# Strict error handling
set -euo pipefail

# Configuration and Default Settings
readonly CONFIG_DIR="${HOME}/.config/pomodoro"
readonly LOG_DIR="${CONFIG_DIR}/logs"
readonly CONFIG_FILE="${CONFIG_DIR}/config.sh"

# Default settings
declare -i WORK_DURATION=25
declare -i BREAK_DURATION=5
declare -i LONG_BREAK_DURATION=15
declare -i CYCLES_BEFORE_LONG_BREAK=4

# Color Codes
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly RESET='\033[0m'

# Trap for clean exit
trap 'echo -e "\n${YELLOW}Pomodoro Timer Stopped.${RESET}"; exit 0' SIGINT SIGTERM

# Validate numeric input
validate_number() {
    local value=$1
    local name=$2
    if ! [[ "$value" =~ ^[0-9]+$ ]]; then
        echo "Error: $name must be a positive integer" >&2
        exit 1
    fi
}

# Ensure configuration directory exists
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Initialize configuration file if not exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    cat > "$CONFIG_FILE" << EOF
WORK_DURATION=25
BREAK_DURATION=5
LONG_BREAK_DURATION=15
CYCLES_BEFORE_LONG_BREAK=4
EOF
fi

# Source and validate configuration
source "$CONFIG_FILE"
validate_number "$WORK_DURATION" "Work duration"
validate_number "$BREAK_DURATION" "Break duration"
validate_number "$LONG_BREAK_DURATION" "Long break duration"
validate_number "$CYCLES_BEFORE_LONG_BREAK" "Cycles before long break"

# Logging Function
log_event() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "${LOG_DIR}/pomodoro.log"
}

# Cross-platform Notification
notify() {
    local message="$1"
    case "$OSTYPE" in
        darwin*)
            command -v osascript >/dev/null && osascript -e "display notification \"$message\" with title \"Pomodoro Timer\""
            ;;
        linux*)
            command -v notify-send >/dev/null && notify-send "Pomodoro Timer" "$message"
            ;;
        *)
            echo -e "${YELLOW}$message${RESET}"
            ;;
    esac
}

# Improved Progress Bar Function
progress_bar() {
    local -i duration=$1
    local message=$2
    local -i elapsed=0

    if ((duration <= 0)); then
        echo "Error: Invalid duration" >&2
        return 1
    fi

    while ((elapsed < duration)); do
        local -i progress=$((elapsed * 100 / duration))
        local -i bar_length=$((progress * 50 / 100))
        
        # Clear line and print without preserving color codes
        printf "\r%-50s [%-50s] %d%%" "$message" "$(printf "#%.0s" $(seq 1 $bar_length))" "$progress"
        
        sleep 1
        ((elapsed++))
    done
    echo -e "\r✓ Session Complete!                                                "
}

# Main Pomodoro Timer Function
run_pomodoro() {
    local -i cycle_count=0
    
    while true; do
        # Work Session
        log_event "Starting Work Session"
        progress_bar $((WORK_DURATION * 60)) "🍅 Focus: Work Session"
        notify "Time for a break!"
        
        # Break Selection (Short/Long)
        ((cycle_count++))
        if ((cycle_count % CYCLES_BEFORE_LONG_BREAK == 0)); then
            log_event "Long Break Session"
            progress_bar $((LONG_BREAK_DURATION * 60)) "🌿 Long Break"
        else
            log_event "Short Break Session"
            progress_bar $((BREAK_DURATION * 60)) "🌱 Short Break"
        fi
        
        notify "Break's over, back to work!"
    done
}

# Help Function
show_help() {
    echo "Pomodoro Timer Help"
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -w, --work     Set work session duration (default: 25 min)"
    echo "  -b, --break    Set short break duration (default: 5 min)"
    echo "  -l, --long     Set long break duration (default: 15 min)"
    echo "  -c, --cycles   Set cycles before long break (default: 4)"
    echo "  -h, --help     Show this help message"
}

# Parse Command Line Arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -w|--work) 
            validate_number "$2" "Work duration"
            WORK_DURATION="$2"
            shift 2 
            ;;
        -b|--break) 
            validate_number "$2" "Break duration"
            BREAK_DURATION="$2"
            shift 2 
            ;;
        -l|--long) 
            validate_number "$2" "Long break duration"
            LONG_BREAK_DURATION="$2"
            shift 2 
            ;;
        -c|--cycles) 
            validate_number "$2" "Cycles before long break"
            CYCLES_BEFORE_LONG_BREAK="$2"
            shift 2 
            ;;
        -h|--help) 
            show_help
            exit 0 
            ;;
        *) 
            echo "Unknown option: $1"
            show_help
            exit 1 
            ;;
    esac
done

# Main Execution
clear
echo "🍅 Pomodoro Timer Started 🍅"
log_event "Pomodoro Timer Initiated"
run_pomodoro
