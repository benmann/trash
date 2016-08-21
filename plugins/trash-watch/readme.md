Watch for changes to all or certain types of files in a directory and act on it.   
In order to run functions on change of a file, declare a pattern (Regular Expressoin) that should be watched
for and a command/function to run when a change for that pattern occurs.  

:warning: make sure to name your array **tasks** !

```
# Watch for changes, run tasks
function watch {
  declare -A tasks=(
    [".*\*.*"]="echo 'something changed!'"
    [".*\.js$"]="echo 'some JS changed!'"
    [".*\.css$"]="echo 'CSS stuff changed!'"
  )

  trash_watch "."
}
```

You can require this plugin in a taskfile with
`plug wat.sh`

Requires bash 4.0+ for the array
