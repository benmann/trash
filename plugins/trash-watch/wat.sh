#!/usr/bin/env bash

function _hash_find {
  # $1 = dir // $2 = pattern
  result=$(find $1 -regex $2 -exec md5 {} \;) # dep on md5
  echo "$result"
}

# main task
function trash_watch {
  declare -A previous_hash
  watched_dir="$1"

  # get initial hashes
  for task in "${!tasks[@]}"
  do
    if [[ "$task" == 0 ]]; then
      continue
    fi
    hashval=$(_hash_find "$watched_dir" "$task")
    previous_hash["$task"]=$hashval
  done

  # watch loop
  echo -e $(tput setaf 2)"🗑: Watching $watched_dir"
  while true; do
    for task in "${!tasks[@]}"
    do
      if [[ "$task" == "0" ]]; then
        continue
      fi

      hashval=$(_hash_find "$watched_dir" "$task")
      if [[ ${previous_hash["$task"]} != $hashval ]]; then
        previous_hash["$task"]=$hashval
        lastchanged=$(find $watched_dir -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f2- -d" ";) # OS X
        echo $(tput setaf 2)"🗑: Last modified: $(tput setaf 7)[ $lastchanged ] $(tput setaf 2)pattern: $(tput setaf 7)[ $task ]"
        eval "${tasks[$task]}"
      fi
    done
    sleep 1
  done
}
