#!/bin/bash

# A script to generate CPU load for a specified duration

# Number of CPU-intensive tasks to spawn (default: number of processors)
NUM_PROCESSES=${1:-$(nproc)}

# Duration in seconds to run the load (default: 10 seconds)
DURATION=${2:-10}

echo "Spawning $NUM_PROCESSES CPU-intensive tasks for $DURATION seconds. Press Ctrl+C to stop early."

# Function to simulate CPU load using mathematical calculations
cpu_load() {
  local end_time=$((SECONDS + DURATION))
  while [[ SECONDS -lt end_time ]]; do
    echo "scale=5000; a(1)*4" | bc -l &>/dev/null
  done
}

# Spawn the specified number of processes
for ((i = 1; i <= NUM_PROCESSES; i++)); do
  cpu_load &
done

# Wait for the processes to complete
wait
echo "CPU load complete."