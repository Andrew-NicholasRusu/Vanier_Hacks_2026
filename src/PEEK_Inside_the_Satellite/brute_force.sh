#!/usr/bin/env bash

MIN_SIZE=$1
MAX_SIZE=$2
PADDIND_WITH_LEADING_ZEROS=$3
NUMBER_OF_PARALLEL_PROCESS=$4

if [[ "$PADDIND_WITH_LEADING_ZEROS" == "true" ]]; then
    seq_option="-w"
fi


printf "\n\nBrute Forcing [STARTING] >>>\n"
echo "..."

now="$(date +"%T")"
echo "$now [New Brute-Force Attempt]:" > brute_force_logs/log.txt

seq "$seq_option" "$MIN_SIZE" "$MAX_SIZE" | xargs -P "$NUMBER_OF_PARALLEL_PROCESS" -I {} bash -c 'echo "--- {} ---" && echo "{}" | ./satellite.exe > "brute_force_logs/file{}.txt"'

echo "..."
echo "<<< Brute Forcing [COMPLETED]"