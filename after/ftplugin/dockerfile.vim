call ale#linter#Define('dockerfile', {
			\ 'name': 'docker-language-server',
			\ 'lsp': 'stdio',
			\ 'executable': 'docker-langserver',
			\ 'command': '%e --stdio',
			\ 'language': 'dockerfile',
			\ 'project_root': { _ -> expand('%p:h') }
			\ })

function! ALEInstall() abort
	if executable('npm')
		! npm install -g dockerfile-language-server-nodejs
	endif
endfunction
command! ALEInstall call ALEInstall()
