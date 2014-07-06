" tabdetect - detect expandtab/noexpandtab and tab width automatically
" Author: t02uk

if exists("g:loaded_tabautodetect")
	finish
endif

if &exrc
	if filereadable('.vimrc') ||
	  \ filereadable('.gvimrc') ||
	  \ filereadable('.exrc')
		finish
	endif
endif

if !exists("g:tabautodetect_minline")
	let g:tabautodetect_minline = 500
endif


function! s:do_tabautodetect()

	let dict = {}
	let prevSpaces = ""

	" first of all investigate head of lines
	for line in getline(1, g:tabautodetect_minline)
		let tabs = matchstr(line, '^\t\+')
		let spaces = matchstr(line, '^ \+')

		if strlen(tabs) != 0
			if has_key(dict, '\t') == 0
				let dict['\t'] = 0
			endif
			let dict['\t'] += 1
		elseif strlen(spaces) != 0
			let delta = strlen(spaces) - strlen(prevSpaces)
			if delta > 0
				let key = " " . delta
				if has_key(dict, key) == 0
					let dict[key] = 0
				end
				let dict[key] += 1
			endif
		endif

		let prevSpaces = spaces
	endfor

	" and apply frequent found one
	let items = items(dict)
	if len(items) != 0
		let freqVal = 0
		let freqKey = ""
		for item in items
			let key = item[0]
			let val = item[1]

			if val >= freqVal
				let freqVal = val
				let freqKey = key
			endif
		endfor

		if freqKey == '\t'
			setlocal noexpandtab
		else
			let w = matchstr(freqKey, '\d\+')
			setlocal expandtab
			let &l:softtabstop = w
			let &l:shiftwidth = w
		endif
	endif

endfunc

augroup plugin-tabautodetect
	autocmd!
	autocmd BufReadPost * call s:do_tabautodetect()
	autocmd BufWritePost * call s:do_tabautodetect()
augroup END

let g:loaded_tabautodetect = 1

" vim: tabstop=2:
