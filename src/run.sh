#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -w workspaceID -a appName [-t titleContent]"
   echo -e "\t-w The ID of the workspace to move the app to (0-9,a-z)"
   echo -e "\t-a The name of the app file to open, e.g. 'Google Chrome'"
   echo -e "\t-t The title content to look for, which indicates the app is loaded"
   exit 1 # Exit script after printing help
}

while getopts "w:a:t:" opt
do
   case "$opt" in
      w ) workspace="$OPTARG" ;;
      a ) app_name="$OPTARG" ;;
      t ) title_content="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction if workspace or app_path are empty
if [ -z "$workspace" ] || [ -z "$app_name" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

open -a "$app_name"

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
