#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/.config/wallpapers"
LOG_FILE="/tmp/tm"

echo "Starting random-wallpaper script at $(date)" > "$LOG_FILE"
echo "Looking for wallpapers in $WALLPAPER_DIR" >> "$LOG_FILE"

if [ -d "$WALLPAPER_DIR" ]; then
  WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
  
  if [ -n "$WALLPAPER" ]; then
    echo "Selected wallpaper: $WALLPAPER" >> "$LOG_FILE"
    
    if [[ "$(uname)" == "Darwin" ]]; then
      # MacOS
      osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER\"" >> "$LOG_FILE" 2>&1
    else
      # Linux (assuming swaybg)
      exec swaybg -m fill -i "$WALLPAPER" >> "$LOG_FILE" 2>&1
    fi

  else
    echo "No wallpapers found in $WALLPAPER_DIR" >> "$LOG_FILE"
    ls -la "$WALLPAPER_DIR" >> "$LOG_FILE" 2>&1
  fi
else
  echo "Directory $WALLPAPER_DIR does not exist" >> "$LOG_FILE"
fi
