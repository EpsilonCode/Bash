#!/bin/bash

# URL of the file to download
url="http://IP-HERE/Packages/a_package.pkg"

# Output file
output_file="a_package.pkg"

# Temporary directory for storing parts
temp_dir="/A/local/dir"

# Check if temp_dir exists. If yes, remove it.
if [ -d "$temp_dir" ]; then
    echo "Removing existing directory: $temp_dir"
    rm -rf "$temp_dir"
fi

# Recreate temp_dir
echo "Creating directory: $temp_dir"
mkdir -p "$temp_dir"

# Define your ranges
ranges=( "0-22619999" "22620000-45239999" "45240000-67859999" "67860000-90479999" "90480000-" )

# Download each part in parallel
for i in "${!ranges[@]}"; do
    part_file="$temp_dir/part_$((i+1)).pkg"
    echo "Starting download of part $((i+1))"
    curl -L -o "$part_file" -r "${ranges[$i]}" "$url" &
done

# Wait for all background processes to finish
wait

# Combine parts
echo "Combining parts..."
cat "$temp_dir"/part_*.pkg > "$output_file"

# Cleanup
echo "Cleaning up temporary files..."
rm -rf "$temp_dir"

echo "Download and assembly complete. Output file: $output_file"
