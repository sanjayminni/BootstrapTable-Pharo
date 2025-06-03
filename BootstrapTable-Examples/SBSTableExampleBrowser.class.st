Class {
	#name : 'SBSTableExampleBrowser',
	#superclass : 'SBSTableRootComponent',
	#instVars : [
		'currentExample'
	],
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSTableExampleBrowser class >> contextRoot [

	^'bootstrap-table'
]

{ #category : 'initialize-release' }
SBSTableExampleBrowser class >> initialize [

	self register
]

{ #category : 'utilities' }
SBSTableExampleBrowser class >> openBrowser [
	WebBrowser openOn: 'http://localhost:8080/', self contextRoot
]

{ #category : 'accessing' }
SBSTableExampleBrowser >> allExamples [
	^(SBSBootstrapTableExample allSubclasses
		select: [:ea| ea isAbstract not ])
			sort: [:a :b | a ordering = b ordering ifTrue: [a name <= b name] ifFalse: [a ordering < b ordering]]
]

{ #category : 'accessing' }
SBSTableExampleBrowser >> children [

	^Array with: currentExample
]

{ #category : 'hooks' }
SBSTableExampleBrowser >> initialRequest: request [
	| exampleName |
	super initialRequest: request.
	exampleName := request url path last.
	currentExample :=
		(self allExamples
			detect: [ :each |
				each exampleName = exampleName ]
			ifNone: [ self allExamples first ]) new
]

{ #category : 'initialize-release' }
SBSTableExampleBrowser >> initialize [
	super initialize.
	currentExample := self allExamples first new
]

{ #category : 'accessing' }
SBSTableExampleBrowser >> navigateToExample: example [

	currentExample := example
]

{ #category : 'rendering' }
SBSTableExampleBrowser >> renderContentOn: html [

	self renderNavigationBarOn: html.

	html row
		with: [
		html column: [ self renderNavigationOn: html ] mediumSize: 2.
		html column: [ self renderExampleOn: html ] mediumSize: 10
	]
]

{ #category : 'rendering' }
SBSTableExampleBrowser >> renderExampleOn: html [

	currentExample ifNotNil: [
		currentExample renderOn: html.
		html break;break.
		html heading level2; with: 'Smalltalk source code'.
		html horizontalRule.
		html preformatted style: 'width: 100%'; with: [html code dataAttributeAt: 'highlighted' put: 'yes'; with: (currentExample class methodNamed: #createTable) sourceCode].
	]
]

{ #category : 'rendering' }
SBSTableExampleBrowser >> renderNavigationBarOn: html [

	 html navigationBar 
			lightBackground;
			with: 
				[html navigationBarBrand with: [(html tag: 'i') style: 'padding: 5px 30px;'; class: 'bi bi-table'].
				html heading: 'Bootstrap Table for Seaside'.
				html navigationBarBrand with: [(html tag: 'i') style: 'padding: 5px 30px;'; class: 'bi bi-table']]
]

{ #category : 'rendering' }
SBSTableExampleBrowser >> renderNavigationOn: html [

	|examples item|
	examples := self allExamples.
	html form: [
	html listGroup: [
		examples do: [:ex |
			item := html listGroupLinkedItem.
			currentExample class = ex ifTrue: [ item beActive ].
			item callback: [ self navigateToExample: ex new ];
				  with: ex exampleName ]] ]
]

{ #category : 'hooks' }
SBSTableExampleBrowser >> style [

	^currentExample style
]

{ #category : 'updating' }
SBSTableExampleBrowser >> updateRoot: htmlRoot [

	super updateRoot: htmlRoot.
	htmlRoot title: 'Bootstrap Table for Seaside' translated
]

{ #category : 'updating' }
SBSTableExampleBrowser >> updateUrl: url [
	super updateUrl: url.
	url addToPath: '/browser'; addToPath: currentExample class exampleName
]
