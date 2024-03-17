#!/bin/zsh

# Define a function to fetch and extract the latest Google Chrome version for Desktop
fetch_latest_chrome_version() {
    local url="https://chromereleases.googleblog.com/search?max-results=10"
    local webpage_content=$(curl --compressed -s "$url")

    # Process the content to find the version number
    local version=$(echo "$webpage_content" | awk '
    BEGIN { inSection=0; version="" }
    /Stable Channel Update for Desktop/ { inSection=1 }
    inSection && /updated to/ {
        sub(/.*updated to /, "", $0)
        sub(/ .*/, "", $0)
        if (index($0, "/") > 0) {
            split($0, parts, "/")
            version = parts[2]  # Focus on the part after the slash
        } else {
            version = $0
        }
        print version
        exit
    }
    END { if (version == "") print "Could not find a specific Stable Channel Update for Desktop with a version number." }
    ')

    echo "$version"
}

# Use the function to fetch and display the latest Google Chrome version for Desktop
latest_version=$(fetch_latest_chrome_version)
echo "The latest version of Google Chrome for Desktop is: $latest_version"
