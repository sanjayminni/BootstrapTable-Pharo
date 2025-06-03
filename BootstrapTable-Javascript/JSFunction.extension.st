Extension { #name : 'JSFunction' }

{ #category : '*BootstrapTable-Javascript' }
JSFunction >> addExpression: aString [

	self add: (JSStream on: aString)
]

{ #category : '*BootstrapTable-Javascript' }
JSFunction class >> named: aString [

	^self named: aString arguments: #()
]

{ #category : '*BootstrapTable-Javascript' }
JSFunction class >> named: aString arguments: anArray [

	^JSNamedFunction new
		name: aString;
		arguments: anArray;
		yourself
]

{ #category : '*BootstrapTable-Javascript' }
JSFunction >> returnExpression: aString [

	self returnStatement: (JSStream on: aString)
]

{ #category : '*BootstrapTable-Javascript' }
JSFunction >> returnStatement: anObject [

	"Must be sent after all other statements have been added"

	self 
		return: true;
		add: anObject
]
