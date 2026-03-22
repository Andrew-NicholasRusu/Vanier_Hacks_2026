#!/usr/bin/env bash

MIN_SIZE=$1
MAX_SIZE=$2
PADDIND_WITH_LEADING_ZEROS=$3
NUMBER_OF_PARALLEL_PROCESS=$4

if [[ "$PADDIND_WITH_LEADING_ZEROS" == "true" ]]; then
    seq_option="-w"
fi


printf "\n\nSearching Successful Brute-Force [STARTING] >>>\n"
echo "..."

seq "$seq_option" "$MIN_SIZE" "$MAX_SIZE" | xargs -P "$NUMBER_OF_PARALLEL_PROCESS" -I {} bash -c 'echo "--- {} ---" && if grep -q "\[-\] Invalid code." "brute_force_logs/file{}.txt"; then printf ""; else echo "brute_force_logs/file{}.txt" >> "brute_force_logs/log.txt"; fi'

echo "{" >> "brute_force_logs/log.txt"
cat "$(sed -n '2{p;q;}' 'brute_force_logs/log.txt')"
echo "}" >> "brute_force_logs/log.txt"

now="$(date +"%T")"
echo "Completed at $now" >> "brute_force_logs/log.txt"

echo "..."
echo "<<< Searching Successful Brute-Force [Completed]"