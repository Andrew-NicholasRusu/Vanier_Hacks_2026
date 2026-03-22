#!/usr/bin/env bash

MIN_SIZE=0000
MAX_SIZE=9999
PADDIND_WITH_LEADING_ZEROS=true
NUMBER_OF_PARALLEL_PROCESS=1000

# seq "$seq_option" "$MIN_SIZE" "$MAX_SIZE" | xargs -P "$NUMBER_OF_PARALLEL_PROCESS" -I {} bash -c 'output=$(echo "{}" | ./satellite.exe && if grep -q "\[-\] Invalid code." "$output"; then printf ""; else echo "brute_force_logs/file{}.txt" >> "test.txt"; fi'

bash brute_force.sh "$MIN_SIZE" "$MAX_SIZE" "$PADDIND_WITH_LEADING_ZEROS" "$NUMBER_OF_PARALLEL_PROCESS"

bash search_logs.sh "$MIN_SIZE" "$MAX_SIZE" "$PADDIND_WITH_LEADING_ZEROS" "$NUMBER_OF_PARALLEL_PROCESS"

# Failed Attempt

# result=$(echo "9999" | ./satellite.exe)
# isSuccess=$?

# printf "\nValue: {"
# printf "\n%s" "$result"
# printf "\n"}
# printf "\nSuccess: %s" "$isSuccess"

# for i in {1..10000}; do
#     number=$(printf "%04d" "$i")
#     printf "--- %s ---\n" "$number"
#     echo "$number" | ./satellite.exe
#     printf "\nValue: {"

#     printf "\n%s" "$result"
#     printf "\n"}
#     printf "\nSuccess: %s" "$isSuccess"
# done
# command=$()
# seq -w 10
