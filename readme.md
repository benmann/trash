<img align="center" width="350" src="http://trash.sh/img/trash-logo.png">
> [http://trash.sh](http://trash.sh)


Trash is a task-runner written in bash. Much like Grunt.js it can be used to automate large parts of your workflow and is easily extensible with plugins, that are quite easy to write.

### REQUIREMENTS
- Bash 4.0+

### INSTALL

The easiest way to install is just cloning the repository.  
`$ git clone git://github.com/BenMann/trash`
    
From there you probably want to have either an alias or a link to you ~/bin folder, so you can actually use it globally. 

    
### USAGE  
Trash uses so called taskfiles to declare and run tasks from. Taskfiles can also be used to load plugins, which can then be incorporated in and called like regular tasks. The easiest way to generate a taskfile is by running
```
$ trash init
🗑: Creating new taskfile (/folder/you’re/in)
```
    
This gives you an empty taskfile in your current directory, containing a simple example. Use your taskfile to declare any functions you want to call with  
`$ trash functionName`. Here’s an example:  

```
#!/usr/bin/env bash 

 function test {
	echo "Running tests…" 	
	php codecept run -c /path/to/my/project
	echo "All tests passed ✔︎"
}
```

Running your tests:
```
$ trash test
Running tests…
All tests passed ✔︎
```

You can list all available tasks by running `$ trash list`

### PLUGINS

When first run, trash will atempt to create the directory 
`$HOME/.trash-runner`, which contains a plugin folder where all plugins are stored. Developing your own plugins is as easy as putting a bash file into the `$HOME/.trash-runner/plugins` folder, or nest some more if required.   

```
  $HOME/.trash-runner
  │
  └── plugins
      │
      ├── your-plugin-folder
      │   ├── .git
      │   ├── awesome-plugin
      │   └── README.md
      │
      └── also-cool-plugin
```

Every plugin located in abovementioned folder can easily be used in any taskfile by requiring it via plug name-of-plugin or in case it is nested in a subdirectory: 
`plugins/your-plugin-folder/executable` → `plug plugin-name/executable`

Here's an example plugin:
```
  #!/usr/bin/env bash

  # Prefix your functions with trash_
  # so they don't appear in `$ trash list`

  function trash_dummyplugin {
    echo "Plugin logic goes here :-)"
  }
```

Corresponding taskfile:
```
  #!/usr/bin/env bash

  plug dummyplugin

  function run {
    trash_dummyplugin
  }
```
      
So basically 'requiring' plugins, exposes their functions for use in your taskfile, keeping it clean and concise.
