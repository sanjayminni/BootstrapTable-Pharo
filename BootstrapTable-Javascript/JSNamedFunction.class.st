Class {
	#name : 'JSNamedFunction',
	#superclass : 'JSFunction',
	#instVars : [
		'name'
	],
	#category : 'BootstrapTable-Javascript',
	#package : 'BootstrapTable-Javascript'
}

{ #category : 'instance creation' }
JSNamedFunction class >> named: aString function: aJSFunction [

	"Private - Answer an instance of the receiver named aString with the same internals as aJSFunction"

	| instance |

	instance := self new.
	instance name: aString.
	1 to: JSFunction instSize do: 
		[ :index || val |
		val := aJSFunction instVarAt: index.
		val == aJSFunction
			ifTrue: [instance instVarAt: index put: instance]
			ifFalse: [instance instVarAt: index put: val]].
	^instance
]

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
