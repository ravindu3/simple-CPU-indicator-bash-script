#!/bin/bash

while true; do
  # Read CPU usage from /proc/stat
  old_idle=$(grep 'cpu ' /proc/stat | awk '{print $5}')
  old_total=$(grep 'cpu ' /proc/stat | awk '{print $5+$4+$2+$3}')
  sleep 1
  new_idle=$(grep 'cpu ' /proc/stat | awk '{print $5}')
  new_total=$(grep 'cpu ' /proc/stat | awk '{print $5+$4+$2+$3}')
  # Calculate CPU usage
  cpu_usage=$(( 100 - ( ( new_idle - old_idle ) * 100 / ( new_total - old_total ) ) ))

  # Check CPU usage and print corresponding state
  if (( cpu_usage > 75 )); then
    echo "Stressed"
  elif (( cpu_usage < 25 )); then
    echo "Relaxed"
  elif (( cpu_usage >= 45 && cpu_usage <= 65 )); then
    echo "Okay"
  elif (( cpu_usage > 65 && cpu_usage <= 75 )); then
    echo "Moderate Stress"
  elif (( cpu_usage > 25 && cpu_usage < 45 )); then
    echo "Moderate Relax"
  fi
done
