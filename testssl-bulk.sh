#!/bin/bash

# Check if the input file is provided as an argument
if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_file> <output_directory>"
  exit 1
fi

input_file=$1
output_directory=$2

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: Input file not found."
  exit 1
fi

# Function to run testssl.sh on a URL and save output to a file
run_testssl() {
  url=$1
  output_file="testssl_$(echo "$url" | sed 's/[^[:alnum:]._-]/_/g')"
  echo "Testing $url..."
  testssl "$url" > "$output_file"
  echo "Results saved to $output_file"
}

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Iterate through the list of URLs in the input file and run testssl.sh on each
while read -r url; do
  run_testssl "$url"
done < "$input_file"