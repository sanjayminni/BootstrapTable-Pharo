Extension { #name : 'JQueryClass' }

{ #category : '*BootstrapTable-Javascript' }
JQueryClass >> bootstrapTable: aString [

	^(self id: aString) as: JQueryBootstrapTable
]
