" Vim Compiler File
" Compiler:    dotnet build
" Maintainer:  Tim M. Madsen <tim at tmadsen dot com>
" Last Change: 2019 Aug 30
" URL:         https://github.com/tmadsen/vim-compiler-plugin-for-dotnet

if exists("current_compiler")
  finish
endif
let current_compiler = "dotnet_build"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=dotnet\ build
CompilerSet errorformat=
    \%-A%.%#Microsoft%.%#,
    \%-ZBuild\ FAILED.,
    \%C%.%#,
    \%-G%.%#,
	\%f(%l\\\,%c):\ %m,
    \%-G%.%#
