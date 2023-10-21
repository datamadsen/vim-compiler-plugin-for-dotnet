" Vim Compiler File
" Compiler:    dotnet build
" Maintainer:  Tim M. Madsen <tim at tmadsen dot com>
" Last Change: 2019 Aug 30
" URL:         https://github.com/tmadsen/vim-compiler-plugin-for-dotnet

if exists("current_compiler")
  finish
endif
let current_compiler = "dotnet_build"

if !exists("g:dotnet_compiler_errors_only")
  let g:dotnet_compiler_errors_only = v:false
endif
if !exists("g:dotnet_compiler_warnings_only")
  let g:dotnet_compiler_warnings_only = v:false
endif

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" command flag of --c is accepted by dotnet cli on all platforms
" otherwise &shellcmdflag[0] can be used
" clean first ensures consistent output
" without NoSummary all warnings and errors are printed twice
let makeprg_builder = ''
let makeprg_builder = makeprg_builder .. 'dotnet clean --verbosity:quiet --nologo '
let makeprg_builder = makeprg_builder .. '&& dotnet build --nologo --verbosity:quiet --consoleLoggerParameters:NoSummary --consoleLoggerParameters:GenerateFullPaths-true'

if g:dotnet_compiler_errors_only == v:true
   let makeprg_builder = makeprg_builder .. ' --consoleLoggerParameters:ErrorsOnly'
endif
if g:dotnet_compiler_warnings_only == v:true
   let makeprg_builder = makeprg_builder .. ' --consoleLoggerParameters:WarningsOnly'
endif

" CompilerSet does not expand variables so execute must be used
execute 'CompilerSet makeprg=' .. escape(makeprg_builder, ' ')
CompilerSet errorformat=
    \%-A%.%#Microsoft%.%#,
    \%-ZBuild\ FAILED.,
    \%C%.%#,
    \%-G%.%#,
	\%f(%l\\\,%c):\ %tarning\ %m\ [%.%#],
	\%f(%l\\\,%c):\ %trror\ %m\ [%.%#],
    \%-G%.%#
