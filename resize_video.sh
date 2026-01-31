#!/bin/bash
# Input and output file paths
INPUT_VIDEO="$1"
OUTPUT_VIDEO="$(dirname "$INPUT_VIDEO")/$(basename "$INPUT_VIDEO" .${INPUT_VIDEO##*.})_resized.mp4" # Output as mp4
TARGET_SIZE_MB=8  # Target file size in MB
# Check if input file is provided
if [ -z "$INPUT_VIDEO" ]; then
  echo "Usage: $0 <input\_video>"
  exit 1
fi
# Get video duration in seconds
DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$INPUT_VIDEO")
if [ -z "$DURATION" ]; then
  echo "Error: Could not get video duration."
  exit 1
fi
# Calculate target bitrate in kbps
TARGET_BITRATE=$(echo "scale=2; ($TARGET_SIZE_MB * 8192) / $DURATION" | bc)
# Encode the video with the calculated bitrate
ffmpeg -i "$INPUT_VIDEO" -b:v "${TARGET_BITRATE}k" -bufsize "${TARGET_BITRATE}k" -maxrate "${TARGET_BITRATE}k" -c:v libx264 -preset fast -crf 18 "$OUTPUT_VIDEO"
# Check if the output file was created
if [ -f "$OUTPUT_VIDEO" ]; then
  echo "Video successfully resized to ~${TARGET_SIZE_MB}MB and converted to mp4: $OUTPUT_VIDEO"
else
  echo "Error: Failed to resize or convert the video."
fi
