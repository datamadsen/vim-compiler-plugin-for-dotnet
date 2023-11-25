# Vim compiler plugin for `dotnet`
This plugin offers up two compilers to vim: `dotnet build` and `dotnet test`
and their respective `errorformat`. 

## Build
Whenever a `.cs` file is opened, the compiler is set to `dotnet_build`, so
whenever `:make` is run it will spawn a `dotnet build` command. The plugin is
nice to use with [vim-dispatch's][vim-dispatch] `:Make` command which will
compile (`dotnet build`) and show any errors in the quickfix window.

## Compiler Settings

There are two options to change what messages are populated into the quickfix windows.

```vim
let g:dotnet_compiler_errors_only = 1
let g:dotnet_compiler_warnings_only = 1
```
These correspond to `--consoleLoggerParameters:ErrorOnly` and `--consoleLoggerParameters:WarningsOnly`.

## Test
`vim-compiler-plugin-for-dotnet` automatically sets `b:dispatch = 'dotnet
test'` for `.cs` files. This makes [vim-dispatch's][vim-dispatch] `:Dispatch`
command run `dotnet test` (compile, then run the entire test suite) and also
show any build or test errors in the quickfix window.

Quickfix entries for test failures do not report anything but the file, line
number and name of the test that failed. This is done to keep the `errorformat`
simple and compatible with all the dotnet core test project types (xunit,
nunit, or mstest).

## More Test Tips
To see explanations of what went wrong in a specific test, the
[vim-test][vim-test] plugin is nice. Put this in your vimrc: 

```vim
let g:test#csharp#runner='dotnettest'
let test#strategy = "vimterminal"
```

Now place the cursor in the failing test and run `:TestNearest` and the details
will be in a new split.

## Installation
If you use [vim-plug][vim-plug] add this to your plugins:

```vim
Plug 'tmadsen/vim-compiler-plugin-for-dotnet'
```

[vim-dispatch]: https://github.com/tpope/vim-dispatch/
[vim-test]: https://github.com/janko/vim-test
[vim-plug]: https://github.com/junegunn/vim-plug
