Class {
	#name : 'JSNamedFunction',
	#superclass : 'JSFunction',
	#instVars : [
		'name'
	],
	#category : 'BootstrapTable-Javascript',
	#package : 'BootstrapTable-Javascript'
}

{ #category : 'printing' }
JSNamedFunction >> javascriptContentOn: aStream [
	aStream 
		nextPutAll: 'function ';
		nextPutAll: self name;
		nextPut: $(.
	self arguments do: [ :each | aStream nextPutAll: each ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPutAll: '){'.
	statements isEmpty ifFalse:
			[ statements allButLast do:
					[ :each | 
					aStream
						javascript: each;
						nextPut: $; ].
			self return ifTrue: [ aStream nextPutAll: 'return ' ].
			aStream javascript: statements last ].
	aStream nextPut: $}
]

{ #category : 'accessing' }
JSNamedFunction >> name [

	^ name
]

{ #category : 'accessing' }
JSNamedFunction >> name: anObject [

	name := anObject
]
