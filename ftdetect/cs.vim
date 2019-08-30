autocmd FileType cs compiler dotnet_build
autocmd FileType cs let b:dispatch = 'dotnet test'
