Extension { #name : 'JQueryInstance' }

{ #category : '*BootstrapTable-Javascript' }
JQueryInstance >> as: aJQueryInstanceSubclass [

	^aJQueryInstanceSubclass fromJQueryInstance: self
]

{ #category : '*BootstrapTable-Javascript' }
JQueryInstance class >> fromJQueryInstance: aJQueryInstance [

	| instance |

	instance := self new.
	1 to: JQueryInstance instSize do: [ :index | instance instVarAt: index put: (aJQueryInstance instVarAt: index)].
	^instance
]

{ #category : '*BootstrapTable-Javascript' }
JQueryInstance >> newCopy [

	"Answer a new, undecorated, copy of the receiver ready for a new statement"

	^self copy
		resetDecoration;
		yourself
]

{ #category : '*BootstrapTable-Javascript' }
JQueryInstance >> resetDecoration [

	decoration := self
]
