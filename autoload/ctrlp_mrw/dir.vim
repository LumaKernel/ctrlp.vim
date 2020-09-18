" =============================================================================
" File:          autoload/ctrlp/dir.vim
" Description:   Directory extension
" Author:        Kien Nguyen <github.com/kien>
" =============================================================================

" Init {{{1
if exists('g:loaded_ctrlp_dir') && g:loaded_ctrlp_dir
	fini
en
let [g:loaded_ctrlp_dir, g:ctrlp_newdir] = [1, 0]

let s:ars = ['s:maxdepth', 's:maxfiles', 's:compare_lim', 's:glob', 's:caching']

cal add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp_mrw#dir#init('.join(s:ars, ', ').')',
	\ 'accept': 'ctrlp_mrw#dir#accept',
	\ 'lname': 'dirs',
	\ 'sname': 'dir',
	\ 'type': 'path',
	\ 'specinput': 1,
	\ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

let s:dircounts = {}
" Utilities {{{1
fu! s:globdirs(dirs, depth)
	let entries = split(globpath(a:dirs, s:glob), "\n")
	let [dirs, depth] = [ctrlp_mrw#dirnfile(entries)[0], a:depth + 1]
	cal extend(g:ctrlp_alldirs, dirs)
	let nr = len(g:ctrlp_alldirs)
	if !empty(dirs) && !s:max(nr, s:maxfiles) && depth <= s:maxdepth
		sil! cal ctrlp_mrw#progress(nr)
		cal map(dirs, 'ctrlp_mrw#utils#fnesc(v:val, "g", ",")')
		cal s:globdirs(join(dirs, ','), depth)
	en
endf

fu! s:max(len, max)
	retu a:max && a:len > a:max
endf

fu! s:nocache()
	retu !s:caching || ( s:caching > 1 && get(s:dircounts, s:cwd) < s:caching )
endf
" Public {{{1
fu! ctrlp_mrw#dir#init(...)
	let s:cwd = getcwd()
	for each in range(len(s:ars))
		let {s:ars[each]} = a:{each + 1}
	endfo
	let cadir = ctrlp_mrw#utils#cachedir().ctrlp_mrw#utils#lash().'dir'
	let cafile = cadir.ctrlp_mrw#utils#lash().ctrlp_mrw#utils#cachefile('dir')
	if g:ctrlp_newdir || s:nocache() || !filereadable(cafile)
		let [s:initcwd, g:ctrlp_alldirs] = [s:cwd, []]
		if !ctrlp_mrw#igncwd(s:cwd)
			cal s:globdirs(ctrlp_mrw#utils#fnesc(s:cwd, 'g', ','), 0)
		en
		cal ctrlp_mrw#rmbasedir(g:ctrlp_alldirs)
		if len(g:ctrlp_alldirs) <= s:compare_lim
			cal sort(g:ctrlp_alldirs, 'ctrlp_mrw#complen')
		en
		cal ctrlp_mrw#utils#writecache(g:ctrlp_alldirs, cadir, cafile)
		let g:ctrlp_newdir = 0
	el
		if !( exists('s:initcwd') && s:initcwd == s:cwd )
			let s:initcwd = s:cwd
			let g:ctrlp_alldirs = ctrlp_mrw#utils#readfile(cafile)
		en
	en
	cal extend(s:dircounts, { s:cwd : len(g:ctrlp_alldirs) })
	retu g:ctrlp_alldirs
endf

fu! ctrlp_mrw#dir#accept(mode, str)
	let path = a:mode == 'h' ? getcwd() : s:cwd.ctrlp_mrw#call('s:lash', s:cwd).a:str
	if a:mode =~ 't\|v\|h'
		cal ctrlp_mrw#exit()
	en
	cal ctrlp_mrw#setdir(path, a:mode =~ 't\|h' ? 'chd!' : 'lc!')
	if a:mode == 'e'
		sil! cal ctrlp_mrw#statusline()
		cal ctrlp_mrw#setlines(s:id)
		cal ctrlp_mrw#recordhist()
		cal ctrlp_mrw#prtclear()
	en
endf

fu! ctrlp_mrw#dir#id()
	retu s:id
endf
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2
