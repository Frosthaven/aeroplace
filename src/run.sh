#!/bin/bash

# HELP SCREEN *****************************************************************
# *****************************************************************************

helpFunction()
{
   echo ""
   echo "Usage: $0 -w workspaceID -a appName [-t titleContent -m modifyCommands]"
   echo -e "\t-w The ID of the workspace to move the app to (0-9,a-z)"
   echo -e "\t-a The name of the app file to open, e.g. 'Google Chrome'"
   echo -e "\t-t The title content to look for, which indicates the app is loaded"
   echo -e "\t-m Aerospace window commands, e.g. 'move left, resize smart -100'"
   exit 1 # Exit script after printing help
}

while getopts "w:a:t:m:" opt
do
   case "$opt" in
      w ) workspace="$OPTARG" ;;
      a ) app_name="$OPTARG" ;;
      t ) title_content="$OPTARG" ;;
      m ) modify_command="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction if workspace or app_path are empty
if [ -z "$workspace" ] || [ -z "$app_name" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# FUNCTIONS *******************************************************************
# *****************************************************************************

function modifyWindow() {
  app_window_id="$1"
  workspace="$2"
  modify_command="$3"

  # move the window to the appropriate workspace
  aerospace move-node-to-workspace --window-id $app_window_id $workspace > /dev/null 2>&1

  IFS=',' read -r -a modify_commands <<< "$modify_command"
  for command in "${modify_commands[@]}"; do
    aerospace $command --window-id $app_window_id > /dev/null 2>&1
  done
}

# RUN *************************************************************************
# *****************************************************************************

open -a "$app_name"

timeout=10
interval=1
elapsed=0

while [[ $elapsed -lt $timeout ]]; do

  if [[ -z $title_content ]]; then # if title_content IS NOT provided
    app_window_id="$(aerospace list-windows --all | grep -i "$app_name" | awk '{print $1}')"
    if [[ ! -z "$app_window_id" ]]; then
      modifyWindow "$app_window_id" "$workspace" "$modify_command"
      echo "$app_window_id"
      break
    fi
  else # if title_content IS provided
    title_window_id="$(aerospace list-windows --all | grep -i "$app_name" | grep -i "$title_content" | awk '{print $1}')"
    if [[ ! -z "$title_window_id" ]]; then
      modifyWindow "$title_window_id" "$workspace" "$modify_command"
      echo "$title_window_id"
      break
    fi
  fi

  sleep $interval
  elapsed=$((elapsed + interval))
done
