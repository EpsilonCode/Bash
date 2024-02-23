#!/bin/zsh

# Define variables
# Please follow guidelines outline by Google
# https://support.google.com/chrome/a/answer/9915669?hl=en
chrome_download_url="https://dl.google.com/chrome/mac/stable/accept_tos%3Dhttps%253A%252F%252Fwww.google.com%252Fintl%252Fen_ph%252Fchrome%252Fterms%252F%26_and_accept_tos%3Dhttps%253A%252F%252Fpolicies.google.com%252Fterms/googlechrome.pkg"
temp_dmg_file="/Users/Shared/googlechrome.pkg"

# Initialize a flag to track if Chrome was open
chrome_was_open=0

# Check if Google Chrome is running
if pgrep "Google Chrome" > /dev/null; then
    chrome_was_open=1
fi

# Download the latest version of Google Chrome
echo "Downloading the latest version of Google Chrome..."
curl -L "$chrome_download_url" -o "$temp_dmg_file"

# Verify the package signature
signature_check=$(pkgutil --check-signature "$temp_dmg_file")

# Check if Google LLC is in the signature output
if echo "$signature_check" | grep -q "Google LLC"; then
    echo "Signature verified successfully. Proceeding with installation."
    
    # Attempt to close Google Chrome gracefully first
    osascript -e 'tell application "Google Chrome" to quit'

    # Wait for Chrome to fully close
    sleep 5

    # If Chrome is still running, force close it
    killall "Google Chrome" 2>/dev/null

    # Wait a bit to ensure Chrome has completely closed
    sleep 2

    # Install Google Chrome
    echo "Installing Google Chrome..."
    installer -pkg "$temp_dmg_file" -target /
    if [ $? -eq 0 ]; then
        echo "Google Chrome installed successfully."
        # Relaunch Google Chrome only if it was open before updating
        if [ $chrome_was_open -eq 1 ]; then
            echo "Relaunching Google Chrome to restore the session..."
            open -a "Google Chrome" --args --restore-last-session
        fi
    else
        echo "Google Chrome installation failed."
        # Optionally, handle installation failure (e.g., by notifying an admin or logging)
    fi
else
    echo "Signature verification failed. Halting installation."
    rm -f "$temp_dmg_file" # Clean up before exiting
    exit 1 # Exit script with an error status
fi

# Clean up
echo "Cleaning up..."
rm -f "$temp_dmg_file"

echo "Update process completed."
