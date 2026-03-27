" ADVPL Syntax
if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword advplKeyword Local Static Default If Else ElseIf EndIf For Next While EndDo Return
syn keyword advplKeyword Function Class Method EndClass WSRESTFUL WSMETHOD WSRECEIVE
syn keyword advplType character numeric logical array object
syn keyword advplBoolean .T. .F. .AND. .OR. .NOT.

" Operators
syn match advplOperator ":="
syn match advplOperator "=="
syn match advplOperator "!="
syn match advplOperator "<="
syn match advplOperator ">="

" Strings
syn region advplString start=+"+ end=+"+
syn region advplString start=+'+ end=+'+

" Comments  
syn match advplComment "//.*$"
syn region advplComment start="/\*" end="\*/"

" Preprocessor
syn match advplPreProc "#\(INCLUDE\|DEFINE\)"

" Highlighting
hi def link advplKeyword Keyword
hi def link advplType Type
hi def link advplBoolean Boolean
hi def link advplOperator Operator
hi def link advplString String
hi def link advplComment Comment
hi def link advplPreProc PreProc

let b:current_syntax = "advpl"
