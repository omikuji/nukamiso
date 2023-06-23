#!/bin/bash

HOME_BREW=/opt/homebrew/bin
export PATH="${PATH}:${HOME_BREW}"
TRASH_PATH=${HOME}/.local/share/Trash/files

DU_START_TIME=$(date +%s)
TRASH_SIZE_BEFORE=$(du -sh ${TRASH_PATH} | cut -f1)
DU_END_TIME=$(date +%s)
DU_EXECUTION_TIME=$((DU_END_TIME - DU_START_TIME))

TRASH_FILE_COUNT_BEFORE=$(ls -1 ${TRASH_PATH} | wc -l)

START_TIME=$(date +%s)
${HOME_BREW}/trash-empty 3 -f
END_TIME=$(date +%s)
TOTAL_EXECUTION_TIME=$((END_TIME - START_TIME))

TRASH_SIZE_AFTER=$(du -sh ${TRASH_PATH} | cut -f1)
TRASH_FILE_COUNT_AFTER=$(ls -1 ${TRASH_PATH} | wc -l)

TRASH_SIZE_DIFF=$(echo "${TRASH_SIZE_BEFORE} - ${TRASH_SIZE_AFTER}" | bc)
TRASH_FILE_COUNT_DIFF=$(echo "${TRASH_FILE_COUNT_BEFORE} - ${TRASH_FILE_COUNT_AFTER}" | bc)

LOG_MESSAGE="$(date) | Trash size before emptying: ${TRASH_SIZE_BEFORE}, after emptying: ${TRASH_SIZE_AFTER}, difference: ${TRASH_SIZE_DIFF} | Number of files in trash before emptying: ${TRASH_FILE_COUNT_BEFORE}, after emptying: ${TRASH_FILE_COUNT_AFTER}, difference: ${TRASH_FILE_COUNT_DIFF} | Execution time of du: ${DU_EXECUTION_TIME} seconds | Total execution time: ${TOTAL_EXECUTION_TIME} seconds"

echo "${LOG_MESSAGE}" >> /tmp/cron_empty_trash.log 2>&1

NOTIFICATION_MESSAGE="Trash size before emptying: ${TRASH_SIZE_BEFORE}
Trash size after emptying: ${TRASH_SIZE_AFTER}
Size difference: ${TRASH_SIZE_DIFF}
Number of files in trash before emptying: ${TRASH_FILE_COUNT_BEFORE}
Number of files after emptying: ${TRASH_FILE_COUNT_AFTER}
File difference: ${TRASH_FILE_COUNT_DIFF}
Execution time of du: ${DU_EXECUTION_TIME} seconds
Total execution time: ${TOTAL_EXECUTION_TIME} seconds"

osascript -e "display notification \"${NOTIFICATION_MESSAGE}\" with title \"Trash Emptied\""
