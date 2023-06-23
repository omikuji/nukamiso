# nukamiso

## git-cleanup.sh

The script searches for branches where the last commit was made more than 30 days ago, and deletes them. If a branch is deleted, its name is outputted.

## delete_files.sh

This script deletes old files containing a specific keyword within a designated directory. The usage is as follows:

```
sh delete_files.sh --directory $HOME/Desktop --target 'Screenshot' --days 3
```

## empty_trash.sh

Gives statistics before and after deleting with `trash-empty`. Also note how long it took to remove.
