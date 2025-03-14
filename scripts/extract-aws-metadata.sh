#!/bin/bash

set -e

# IMDS Base URL
IMDS_BASE_URL="http://169.254.169.254/latest/meta-data"

# Log file where requests and responses will be stored
LOG_FILE="aws_metadata.log"

# Ensure log file is empty before running
> "$LOG_FILE"

log_request() {
    local -r request_url=$1
    local -r response=$2

    echo "[REQUEST] $request_url" >> "$LOG_FILE"
    echo -e "[RESPONSE]\n$response" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"
    echo "$response"
}

get_metadata() {
    local -r url=${IMDS_BASE_URL}$1

    log_request "$url" "$(curl -s "$url")"
}

extract_metadata() {
    local -r metadata_path=${1:-"/"}

    for item in $(get_metadata "$metadata_path"); do
        local next_path="$metadata_path$item"
        
        if [[ "$item" == */ ]]; then
            extract_metadata "$next_path"
        else
            get_metadata "$next_path" > /dev/null
        fi
    done
}

extract_metadata

echo "Metadata requests and responses have been saved to $LOG_FILE"