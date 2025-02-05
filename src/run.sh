# !/bin/bash

# $1: workspace
# $2: app_path
# $2: title_content

workspace="$1"
app_path="$2"
app_name=$(basename $app_path)
app_name="${app_name%.*}"
title_content="$3"

open -a "$app_path"

timeout=10
interval=1
elapsed=0

while [[ $elapsed -lt $timeout ]]; do

  if [[ -z $title_content ]]; then # if title_content IS NOT provided
    app_window_id="$(aerospace list-windows --all | grep -i $app_name | awk '{print $1}')"
    if [[ ! -z "$app_window_id" ]]; then
      aerospace move-node-to-workspace --window-id "$app_window_id" --focus-follows-window "$workspace" > /dev/null 2>&1
      echo "$app_window_id"
      break
    fi
  else # if title_content IS provided
    title_window_id="$(aerospace list-windows --all | grep -i $app_name | grep -i $title_content | awk '{print $1}')"
    if [[ ! -z "$title_window_id" ]]; then
      aerospace move-node-to-workspace --window-id "$title_window_id" --focus-follows-window "$workspace" > /dev/null 2>&1
      echo "$title_window_id"
      break
    fi
  fi

  sleep $interval
  elapsed=$((elapsed + interval))
done
