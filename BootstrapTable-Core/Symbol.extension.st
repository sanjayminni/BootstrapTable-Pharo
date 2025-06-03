Extension { #name : 'Symbol' }

{ #category : '*BootstrapTable-Core' }
Symbol >> asHtmlTagDataAttribute [

	"e.g. #sortStable -> 'data-sort-stable'"

	| in out |

	in := self readStream.
	out := (String new: self size + 8) writeStream.

	out nextPutAll: 'data-'.
	[in atEnd] whileFalse: 
		[| next |
		next := in next.
		next isUppercase
			ifTrue: [out nextPut: $-; nextPut: next asLowercase]
			ifFalse: [out nextPut: next]].

	^out contents
]
