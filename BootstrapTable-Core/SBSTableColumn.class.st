Class {
	#name : 'SBSTableColumn',
	#superclass : 'SBSTableSingleColumn',
	#instVars : [
		'renderBlock',
		'componentGenerator'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'configuring' }
SBSTableColumn >> beCheckBox [

	self 
		componentClass: SBSTableCheckBox;
		alignCenter.

	self isSortable ifTrue: [self sortBlock: [ :a :b | self contentFromRow: b]]
]

{ #category : 'accessing' }
SBSTableColumn >> componentClass: aSBSTableSubComponentSubclass [

	"Convenience method.
	Argument should be a subclass of SBSTableSubComponent (or compatible class)"

	self componentGenerator: 
		[ :column :row |
		aSBSTableSubComponentSubclass new
			column: self;
			model: row;
			yourself]
]

{ #category : 'accessing' }
SBSTableColumn >> componentGenerator [

	"Optional - a 2-arg block which generates a component to use to render the contents of this column.
	Arguments are the receiver and the row object for which the component is being generated"

	^componentGenerator

]

{ #category : 'accessing' }
SBSTableColumn >> componentGenerator: aBlock [

	"Optional - a 2-arg block which generates a component to use to render the contents of this column.
	Arguments are the receiver and the row object for which the component is being generated"

	componentGenerator := aBlock
]

{ #category : 'accessing' }
SBSTableColumn >> footerForData [

	self hasFooter ifFalse: [^nil].
	self hasRenderBlock ifFalse: [^super footerForData].

	^WAHtmlCanvas builder
		fullDocument: false;
		render: [ :html |self renderBlock cull: html cull: footerBlock value]
]

{ #category : 'configuring' }
SBSTableColumn >> footerIsTotal [

	self footerBlock: [self total]
]

{ #category : 'callbacks' }
SBSTableColumn >> handleFooterCallback [

	self requestContext respond: 
		[ :response  |
		response 
			contentType: self application contentType;
			nextPutAll: 
				(WAHtmlCanvas builder
					fullDocument: false;
					render: 
						[ :html |
						self table initializeSubCanvas: html.
						self hasRenderBlock
							ifTrue: [self renderBlock cull: html cull: footerBlock value]
							ifFalse: [html text: footerBlock value displayString]])]
]

{ #category : 'callbacks' }
SBSTableColumn >> handleFormatterCallbackForRowId: anInteger [

	(self table rowWithId: anInteger) ifNotNil: 
		[ :row | 
		self requestContext respond: 
			[ :response  |
			response 
				contentType: self application contentType;
				nextPutAll: 
					(WAHtmlCanvas builder
						fullDocument: false;
						render: 
							[ :html |
							self table initializeSubCanvas: html.
							self hasComponent
								ifTrue: [(self componentGenerator value: self value: row) renderContentOn: html]
								ifFalse: [self renderBlock cull: html cull: (self contentFromRow: row) cull: row]])]]
]

{ #category : 'testing' }
SBSTableColumn >> hasComponent [

	^componentGenerator notNil
]

{ #category : 'testing' }
SBSTableColumn >> hasRenderBlock [

	^renderBlock notNil
]

{ #category : 'testing' }
SBSTableColumn >> hasSubComponent [

	^self hasRenderBlock or: [self hasComponent]
]

{ #category : 'testing' }
SBSTableColumn >> isSearchable [

	^self isOption: #searchable default: true
]

{ #category : 'testing' }
SBSTableColumn >> needsFormatterCallback [

	^self hasSubComponent
]

{ #category : 'accessing' }
SBSTableColumn >> renderBlock [

	"renderBlock optionally stores a two or three arg block which is evaluated with 
		1) a html canvas
		2) the value to be displayed 
		3) the row object (optional)
	and should deliver the HTML to be displayed in this columns.
	This represents a simpler alternative to componentClass"

	^renderBlock
]

{ #category : 'accessing' }
SBSTableColumn >> renderBlock: anObject [

	"renderBlock optionally stores a two or three arg block which is evaluated with 
		1) a html canvas
		2) the value to be displayed 
		3) the row object (optional)
	and should deliver the HTML to be displayed in this columns.
	This represents a simpler alternative to componentClass"

	renderBlock := anObject
]

{ #category : 'rendering' }
SBSTableColumn >> renderFormatterScriptOn: html [

	| functionName function statement |
	
	functionName := self option: #formatter.
	function := JSFunction named: functionName arguments: #('value' 'row' 'index' 'field').

	statement := 
		html jQuery ajax 
			async: false; 
			yourself.

	statement 
		callback: [ :rowId | self handleFormatterCallbackForRowId: rowId asInteger] value: (html javascript alias: 'row.', self table idAccessor);
		onSuccess: ('html=result' asFunction: #('result')).

	function 
		add: statement; 
		returnExpression: 'html'.

	html script: function asJavascript
]

{ #category : 'accessing' }
SBSTableColumn >> total [

	"Assume the receiver contains numeric values"

	^self table data inject: 0 into: [ :total :each | total + (self contentFromRow: each)]
]
