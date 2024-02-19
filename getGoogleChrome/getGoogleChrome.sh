#!/bin/zsh

# Define variables
# Please follow guidlines outline by Google
# https://support.google.com/chrome/a/answer/9915669?hl=en
chrome_download_url="https://dl.google.com/chrome/mac/stable/accept_tos%3Dhttps%253A%252F%252Fwww.google.com%252Fintl%252Fen_ph%252Fchrome%252Fterms%252F%26_and_accept_tos%3Dhttps%253A%252F%252Fpolicies.google.com%252Fterms/googlechrome.pkg"
temp_dmg_file="/Users/Shared/googlechrome.pkg"

# Download the latest version of Google Chrome
# echo "Downloading the latest version of Google Chrome..."
curl -L "$chrome_download_url" -o "$temp_dmg_file"

# Kill Google Chrome before install
killall "Google Chrome"

# Copy Chrome to Applications directory
# echo "Copying Google Chrome to Applications folder..."
installer -pkg $temp_dmg_file -target /

# Open with last session
open -a "Google Chrome" --args --restore-last-session

# Clean up
rm $temp_dmg_file 
