#!/bin/bash
{
  date
  while (( "$#" )); do
    case "$1" in
      --target)
        TARGET=$2
        shift 2
        ;;
      --days)
        DAYS=$2
        shift 2
        ;;
      --directory)
        DIRECTORY=$2
        shift 2
        ;;
      --)
        shift
        break
        ;;
      *)
        echo "Error: Invalid argument"
        exit 1
    esac
  done

  OUTPUT=$(find $DIRECTORY -type f -name "*$TARGET*" -mtime +$DAYS -print0 | du --bytes --total --files0-from=-)
  echo $OUTPUT
  find $DIRECTORY -type f -name "*$TARGET*" -mtime +$DAYS -exec echo $(date +'%Y-%m-%d %H:%M:%S') {} \; -exec rm {} \;
} >> /tmp/cron_delete_files.log 2>&1

osascript -e 'display notification "Directory: '$DIRECTORY'\nTarget: '$TARGET'\nDays: '$DAYS'\n'$OUTPUT'" with title "Automated File Deletion"'
