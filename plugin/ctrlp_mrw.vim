" =============================================================================
" File:          plugin/ctrlp.vim
" Description:   Fuzzy file, buffer, mru, tag, etc finder.
" Author:        Kien Nguyen <github.com/kien>
" =============================================================================
" GetLatestVimScripts: 3736 1 :AutoInstall: ctrlp.zip

if ( exists('g:loaded_ctrlp_mrw') && g:loaded_ctrlp_mrw ) || v:version < 700 || &cp
	fini
en
let g:loaded_ctrlp_mrw = 1

" let [g:ctrlp_lines, g:ctrlp_allfiles, g:ctrlp_alltags, g:ctrlp_alldirs,
" 	\ g:ctrlp_allmixes, g:ctrlp_buftags, g:ctrlp_ext_vars, g:ctrlp_builtins]
" 	\ = [[], [], [], [], {}, {}, [], 2]
" 
" if !exists('g:ctrlp_map') | let g:ctrlp_map = '<c-p>' | en
" if !exists('g:ctrlp_cmd') | let g:ctrlp_cmd = 'CtrlP' | en

" com! -n=? -com=dir CtrlP         cal ctrlp_mrw#init(0, { 'dir': <q-args> })
com! -n=? -com=dir CtrlPMRWFiles cal ctrlp_mrw#init(2, { 'dir': <q-args> })

" com! -bar CtrlPBuffer   cal ctrlp_mrw#init(1)
" com! -n=? CtrlPLastMode cal ctrlp_mrw#init(-1, { 'args': <q-args> })

" com! -bar CtrlPClearCache     cal ctrlp_mrw#clr()
" com! -bar CtrlPClearAllCaches cal ctrlp_mrw#clra()
" 
" com! -bar ClearCtrlPCache     cal ctrlp_mrw#clr()
" com! -bar ClearAllCtrlPCaches cal ctrlp_mrw#clra()
" 
" com! -bar CtrlPCurWD   cal ctrlp_mrw#init(0, { 'mode': '' })
" com! -bar CtrlPCurFile cal ctrlp_mrw#init(0, { 'mode': 'c' })
" com! -bar CtrlPRoot    cal ctrlp_mrw#init(0, { 'mode': 'r' })

" if g:ctrlp_map != '' && !hasmapto(':<c-u>'.g:ctrlp_cmd.'<cr>', 'n')
" 	exe 'nn <silent>' g:ctrlp_map ':<c-u>'.g:ctrlp_cmd.'<cr>'
" en

cal ctrlp_mrw#mrufiles#init()

" com! -bar CtrlPTag      cal ctrlp_mrw#init(ctrlp_mrw#tag#id())
" com! -bar CtrlPQuickfix cal ctrlp_mrw#init(ctrlp_mrw#quickfix#id())
" 
" com! -n=? -com=dir CtrlPDir
" 	\ cal ctrlp_mrw#init(ctrlp_mrw#dir#id(), { 'dir': <q-args> })
" 
" com! -n=? -com=buffer CtrlPBufTag
" 	\ cal ctrlp_mrw#init(ctrlp_mrw#buffertag#cmd(0, <q-args>))
" 
" com! -bar CtrlPBufTagAll cal ctrlp_mrw#init(ctrlp_mrw#buffertag#cmd(1))
" com! -bar CtrlPRTS       cal ctrlp_mrw#init(ctrlp_mrw#rtscript#id())
" com! -bar CtrlPUndo      cal ctrlp_mrw#init(ctrlp_mrw#undo#id())
" 
" com! -n=? -com=buffer CtrlPLine
" 	\ cal ctrlp_mrw#init(ctrlp_mrw#line#cmd(1, <q-args>))
" 
" com! -n=? -com=buffer CtrlPChange
" 	\ cal ctrlp_mrw#init(ctrlp_mrw#changes#cmd(0, <q-args>))
" 
" com! -bar CtrlPChangeAll   cal ctrlp_mrw#init(ctrlp_mrw#changes#cmd(1))
" com! -bar CtrlPMixed       cal ctrlp_mrw#init(ctrlp_mrw#mixed#id())
" com! -bar CtrlPBookmarkDir cal ctrlp_mrw#init(ctrlp_mrw#bookmarkdir#id())
" 
" com! -n=? -com=dir CtrlPBookmarkDirAdd
" 	\ cal ctrlp_mrw#call('ctrlp_mrw#bookmarkdir#add', <q-args>)

" vim:ts=2:sw=2:sts=2
