if exists("b:current_syntax")
    finish
endif

" comment lines
syntax match gitignoreComment 	"\v^#.*$"
syntax match gitignoreConstant 	"\v[^\#/]+(\.[_\*a-zA-Z]+)?$"
syntax match gitignoreKeyword 	"\v[\*!]"
syntax match gitignoreType 		"\v\#[a-f0-9]{7}"


highlight link gitignoreKeyword 	Keyword
highlight link gitignoreComment 	Comment
highlight link gitignoreConstant 	Constant
highlight link gitignoreType 		Type

let b:current_syntax = "gitignore"

