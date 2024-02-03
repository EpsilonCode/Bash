#!/bin/zsh

# Attempt to install Rosetta 2
sudo softwareupdate --install-rosetta --agree-to-license

# Check the exit status of the installation
if [[ $? -eq 0 ]]; then
  echo "Rosetta 2 installation successful"
else
  echo "Rosetta 2 installation failed. Will retry at 7:30 AM tomorrow."

  # Calculate the time until 7:30 AM
  current_time=$(date +%s)
  target_time=$(date -j -f "%H:%M:%S" "07:30:00" +%s)

  # Calculate the number of seconds to sleep
  sleep_seconds=$((target_time - current_time))

  if [[ $sleep_seconds -le 0 ]]; then
    # If it's already past 7:30 AM, schedule for 7:30 AM tomorrow
    sleep_seconds=$((86400 - current_time + target_time))
  fi

  # Sleep until the next scheduled time (in seconds)
  sleep $sleep_seconds
fi
