" reStructured Text with R statements
" Language: reST with R code chunks
" Maintainer: Alex Zvoleff, azvoleff@mail.sdsu.edu
" Last Change: Tue Feb 26, 2013  01:13PM
"
" CONFIGURATION:
"   To highlight chunk headers as R code, put in your vimrc:
"   let rrst_syn_hl_chunk = 1

" for portability
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" load all of the rst info
runtime syntax/rst.vim
unlet b:current_syntax

" load all of the r syntax highlighting rules into @R
syntax include @R syntax/r.vim

setlocal iskeyword=@,48-57,_,.

" highlight R chunks
if exists("g:rrst_syn_hl_chunk")
    " highlight R code inside chunk header
    syntax match rrstChunkDelim "^\.\. {r" contained
    syntax match rrstChunkDelim "}$" contained
else
    syntax match rrstChunkDelim "^\.\. {r .*}$" contained
endif
syntax match rrstChunkDelim "^\.\. \.\.$" contained
syntax region rrstChunk start="^\.\. {r.*}$" end="^\.\. \.\.$" contains=@R,rrstChunkDelim keepend transparent fold

" also highlight in-line R code
syntax match rrstInlineDelim "`" contained
syntax match rrstInlineDelim ":r:" contained
syntax region rrstInline start=":r: *`" skip=/\\\\\|\\`/ end="`" contains=@R,rrstInlineDelim keepend

hi def link rrstChunkDelim Special
hi def link rrstInlineDelim Special

let b:current_syntax = "rrst"