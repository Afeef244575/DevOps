#!/bin/bash

# 1. Check if a log file path is provided as an argument
if [ $# -eq 0 ]; then
  echo "Error: Please provide the log file path as an argument."
  exit 1
fi

log_file_path="$1"

# 2. Validate that the log file exists and is readable
if [ ! -f "$log_file_path" ]; then
  echo "Error: The log file '$log_file_path' does not exist."
  exit 1
elif [ ! -r "$log_file_path" ]; then
  echo "Error: The log file '$log_file_path' is not readable."
  exit 1
fi

# 3. Extract lines containing the word “ERROR”
error_lines=$(grep -i "ERROR" "$log_file_path")

# Check if there are any error lines
if [ -z "$error_lines" ]; then
  echo "No 'ERROR' messages found in the log file."
  exit 0
fi

# 4. Parse and count the frequency of unique error messages
# Extracting messages after "ERROR" (including quotes)
echo "Top 3 most frequent ERROR messages:"
echo "$error_lines" | grep -o "ERROR .*" | sort | uniq -c | sort -nr | head -n 3

