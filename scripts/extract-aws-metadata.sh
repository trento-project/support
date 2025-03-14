#!/bin/bash

set -e

# IMDS Base URL
IMDS_BASE_URL="http://169.254.169.254/latest/meta-data"

# Log file where requests and responses will be stored
LOG_FILE="aws_metadata.log"

# Ensure log file is empty before running
> "$LOG_FILE"

request_and_log() {
    local url=$1

    echo "[REQUEST] $url" >> "$LOG_FILE"

    response=$(curl -s "$url")

    echo -e "[RESPONSE]\n$response" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"

    echo $response
}

extract_metadata() {
    local metadata_path=${1:-"/"}
    
    request_url=${IMDS_BASE_URL}$metadata_path

    response=$(request_and_log "$request_url")

    for item in $response; do
        if [[ "$item" == */ ]]; then
            extract_metadata "$metadata_path$item"
        else
            local leaf_url=${IMDS_BASE_URL}$metadata_path$item

            request_and_log "$leaf_url" > /dev/null
        fi
    done
}

extract_metadata

echo "Metadata requests and responses have been saved to $LOG_FILE"