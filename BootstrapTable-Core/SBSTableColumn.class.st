Class {
	#name : 'SBSTableColumn',
	#superclass : 'SBSTableSingleColumn',
	#instVars : [
		'formatterFunction',
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

	^SBSHtmlCanvas builder
		fullDocument: false;
		render: [ :html |self renderBlock cull: html cull: footerBlock value]
]

{ #category : 'configuring' }
SBSTableColumn >> footerIsTotal [

	self footerBlock: [self total]
]

{ #category : 'accessing' }
SBSTableColumn >> formatExpression: aString [

	"Simplified interface to formatterFunction.
	aString is a Javascript expression that will be used as the result of the formatterFunction.
	Parameters to the function are value, row, index and field as per the documentation (see link in formatterFunction)"

	self formatterFunction: 
		(JSFunction new
			arguments: #('value' 'row' 'index' 'field');
			returnExpression: aString;
			yourself)
]

{ #category : 'accessing' }
SBSTableColumn >> formatterFunction [

	"formatterFunction optionally stores a JSFunction which is used to render the value to be displayed in this column.
	This maps to the formatter option of the column - https://bootstrap-table.com/docs/api/column-options/#formatter

	This represents a client-side alternative to renderBlock for improved performance when displaying large datasets"

	^formatterFunction
]

{ #category : 'accessing' }
SBSTableColumn >> formatterFunction: aJSFunction [

	"formatterFunction optionally stores a JSFunction which is used to render the value to be displayed in this column.
	This maps to the formatter option of the column - https://bootstrap-table.com/docs/api/column-options/#formatter

	This represents a client-side alternative to renderBlock for improved performance when displaying large datasets"

	formatterFunction := aJSFunction
]

{ #category : 'callbacks' }
SBSTableColumn >> handleFooterCallback [

	self requestContext respond: 
		[ :response  |
		response 
			contentType: self application contentType;
			nextPutAll: 
				(SBSHtmlCanvas builder
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
					(SBSHtmlCanvas builder
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
SBSTableColumn >> hasFormatterFunction [

	^formatterFunction notNil
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
SBSTableColumn >> needsFormatterScript [

	^self hasFormatterFunction or: [self hasSubComponent]
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
SBSTableColumn >> renderFormatterCallbackScriptOn: html [

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

	html script: function
]

{ #category : 'rendering' }
SBSTableColumn >> renderFormatterFunctionOn: html [

	| functionName |

	functionName := self option: #formatter.
	html script: (self formatterFunction named: functionName)
]

{ #category : 'rendering' }
SBSTableColumn >> renderFormatterScriptOn: html [

	self hasFormatterFunction
		ifTrue: [self renderFormatterFunctionOn: html]
		ifFalse: [self renderFormatterCallbackScriptOn: html]
]

{ #category : 'accessing' }
SBSTableColumn >> total [

	"Assume the receiver contains numeric values"

	^self table data inject: 0 into: [ :total :each | total + (self contentFromRow: each)]
]
