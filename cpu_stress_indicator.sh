#!/bin/bash

while true; do
  cpu_usage=$(top -bn1 | grep "Cpu(s):" | awk '{usage=100-$NF; printf "%.2f\n",usage}')

  if (( $(echo "$cpu_usage > 75" | bc -l) )); then
    echo "Stressed"
  elif (( $(echo "$cpu_usage < 25" | bc -l) )); then
    echo "Relaxed"
  elif (( $(echo "$cpu_usage >= 45 && $cpu_usage <= 65" | bc -l) )); then
    echo "Okay"
  elif (( $(echo "$cpu_usage > 65 && $cpu_usage <= 75" | bc -l) )); then
    echo "Moderate Stress"
  elif (( $(echo "$cpu_usage > 25 && $cpu_usage < 45" | bc -l) )); then
    echo "Moderate Relax"
  fi

  sleep 1
done
