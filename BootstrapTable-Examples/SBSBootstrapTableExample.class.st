Class {
	#name : 'SBSBootstrapTableExample',
	#superclass : 'SBSComponent',
	#instVars : [
		'table'
	],
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableExample class >> exampleName [

	^self subclassResponsibility
]

{ #category : 'testing' }
SBSBootstrapTableExample class >> isAbstract [

	^self name = #SBSBootstrapTableExample
]

{ #category : 'accessing' }
SBSBootstrapTableExample class >> ordering [

	^SmallInteger maximum
]

{ #category : 'initialize-release' }
SBSBootstrapTableExample >> createTable [

	self subclassResponsibility
]

{ #category : 'initialize-release' }
SBSBootstrapTableExample >> initialize [

	super initialize.

	self table: self createTable
]

{ #category : 'accessing' }
SBSBootstrapTableExample >> list [

	^OrderedCollection withAll: 
		((1 to: self listSize) collect: 
			[ :index | 
			SBSTableExampleProduct new
				id: index;
				name: 'Item ', index displayString;
				price: (ScaledDecimal newFromNumber: index scale: 2);
				inStock: (index \\ 5) > 0;
				yourself])
]

{ #category : 'accessing' }
SBSBootstrapTableExample >> listSize [
	^10
]

{ #category : 'rendering' }
SBSBootstrapTableExample >> renderContentOn: html [

	html containerFluid: [
		html break.
		html
			heading level2 with: self class exampleName.
		self renderExampleOn: html ]
]

{ #category : 'rendering' }
SBSBootstrapTableExample >> renderDescriptionOn: html [

	self subclassResponsibility
]

{ #category : 'rendering' }
SBSBootstrapTableExample >> renderExampleOn: html [
	html div
		class: 'header-wrapper';
		with: 
				[html paragraph
					class: 'bd-lead';
					with: [html paragraph with: [self renderDescriptionOn: html]]].
	html div
		class: 'bootstrap-table bootstrap5';
		with: [self renderTableOn: html]
]

{ #category : 'rendering' }
SBSBootstrapTableExample >> renderTableOn: html [

	table renderContentOn: html
]

{ #category : 'hooks' }
SBSBootstrapTableExample >> style [

	^''
]

{ #category : 'accessing' }
SBSBootstrapTableExample >> table [
	^table
]

{ #category : 'accessing' }
SBSBootstrapTableExample >> table: anObject [
	table := anObject
]
