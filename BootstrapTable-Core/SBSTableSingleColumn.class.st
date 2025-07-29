Class {
	#name : 'SBSTableSingleColumn',
	#superclass : 'SBSTableColumnComponent',
	#instVars : [
		'getContentsBlock',
		'fieldName',
		'sortBlock',
		'footerBlock'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'accessing' }
SBSTableSingleColumn >> accessAt: aSymbol [

	"Configure the receiver to display the value answered by a row object when sent at: aSymbol (e.g. if model objects are Dictionaries)"

	self 
		fieldName: aSymbol;
		getContentsBlock: [ :obj | obj at: aSymbol]
	
]

{ #category : 'accessing' }
SBSTableSingleColumn >> accessAtIndex: anInteger [

    self 
        fieldName: ('field', anInteger asString);
        getContentsBlock: [ :obj | obj at: anInteger]
]

{ #category : 'accessing' }
SBSTableSingleColumn >> accessor: aSymbol [

	"Configure the receiver to display the value answered by a row object to the message aSymbol"

	self 
		fieldName: aSymbol;
		getContentsBlock: [ :obj | obj perform: aSymbol].
	
]

{ #category : 'operations' }
SBSTableSingleColumn >> addToTable: aSBSTable [

	self table: aSBSTable.
	aSBSTable _addColumn: self
]

{ #category : 'options' }
SBSTableSingleColumn >> alignCenter [

	self option: #align value: 'center'
]

{ #category : 'options' }
SBSTableSingleColumn >> alignLeft [

	self option: #align value: 'left'
]

{ #category : 'options' }
SBSTableSingleColumn >> alignRight [

	self option: #align value: 'right'
]

{ #category : 'options' }
SBSTableSingleColumn >> applyOptionsTo: aTableHeading [

	self 
		option: #field value: self fieldName;
		option: #sortable value: self isSortable.
	self needsFormatterScript ifTrue: [self option: #formatter value: 'columnFormatter', self id].
	self needsSortCallback ifTrue: [self option: #sorter value: 'columnSorter', self id].
	self needsFooterCallback ifTrue: [self option: #footerFormatter value: 'columnFooter', self id].

	super applyOptionsTo: aTableHeading
]

{ #category : 'options' }
SBSTableSingleColumn >> clickToSelect: aBoolean [

	self option: #clickToSelect value: aBoolean
]

{ #category : 'accessing' }
SBSTableSingleColumn >> columnSpan [

	^1
]

{ #category : 'accessing' }
SBSTableSingleColumn >> contentFromRow: anObject [

	^getContentsBlock ifNotNil: [getContentsBlock value: anObject]
]

{ #category : 'constants' }
SBSTableSingleColumn >> defaultSortBlock [

	^[ :a :b | (self contentFromRow: a) <= (self contentFromRow: b)]
]

{ #category : 'accessing' }
SBSTableSingleColumn >> fieldName [

	"fieldName stores the name/key of the value displayed by this column in the table's json data"

	^fieldName ifNil: ['column', (self table indexOfColumn: self) asString]
]

{ #category : 'accessing' }
SBSTableSingleColumn >> fieldName: anObject [

	"fieldName stores the name/key of the value displayed by this column in the table's json data"

	fieldName := anObject
]

{ #category : 'accessing' }
SBSTableSingleColumn >> footerBlock [

	"footerBlock optionally stores a zero-arg block which is evaluated to answer the footer of this column"

	^footerBlock
]

{ #category : 'accessing' }
SBSTableSingleColumn >> footerBlock: aBlock [

	"footerBlock optionally stores a zero-arg block which is evaluated to answer the footer of this column"

	footerBlock := aBlock
]

{ #category : 'accessing' }
SBSTableSingleColumn >> footerForData [

	^self hasFooter
		ifTrue: [self footerBlock value]
		ifFalse: [nil]
]

{ #category : 'accessing' }
SBSTableSingleColumn >> footerText: aString [

	self footerBlock: [aString]
]

{ #category : 'accessing' }
SBSTableSingleColumn >> getContentsBlock [

	"getContentsBlock stores a 1-arg block which is evaluated with the row object and should answer the item to display (String, Number etc.) in this column for that row.
	Terminology is based on Dolphin's ListViewColumn.
	This can be set directly or for simple cases via #accessor: or: #accessAt: "

	^getContentsBlock
]

{ #category : 'accessing' }
SBSTableSingleColumn >> getContentsBlock: aOneArgBlock [

	"getContentsBlock stores a 1-arg block which is evaluated with the row object and should answer the item to display (String, Number etc.) in this column for that row.
	Terminology is based on Dolphin's ListViewColumn.
	This can be set directly or for simple cases via #accessor: or: #accessAt: "

	getContentsBlock := aOneArgBlock
]

{ #category : 'callbacks' }
SBSTableSingleColumn >> handleFooterCallback [

	self requestContext respond: 
		[ :response  |
		response 
			contentType: self application contentType;
			nextPutAll: 
				(SBSHtmlCanvas builder
					fullDocument: false;
					render: 
						[ :html |
						html text: footerBlock value displayString])]
]

{ #category : 'callbacks' }
SBSTableSingleColumn >> handleSortCallbackWith:  params [

	| stream rowId1 rowId2 row1 row2 result |

	"params format is row id 1, row id 2"
	stream := params readStream.
	rowId1 := (stream upTo: $,) asInteger.
	rowId2 := Integer readFrom: stream.

	row1 := self table rowWithId: rowId1.
	row2 := self table rowWithId: rowId2.

	result := (self sortBlock value: row1 value: row2) ifTrue: [-1] ifFalse: [1].

	self requestContext respond: [ :response  | result displayStringOn: response]
]

{ #category : 'testing' }
SBSTableSingleColumn >> hasContent [

	^getContentsBlock notNil
]

{ #category : 'testing' }
SBSTableSingleColumn >> hasCustomSort [

	^sortBlock notNil and: [sortBlock ~= self defaultSortBlock]
]

{ #category : 'testing' }
SBSTableSingleColumn >> hasFooter [

	^footerBlock notNil
]

{ #category : 'testing' }
SBSTableSingleColumn >> hasSorter [

	^self hasOption: #sorter
]

{ #category : 'testing' }
SBSTableSingleColumn >> hasSubComponent [

	^self subclassResponsibility
]

{ #category : 'testing' }
SBSTableSingleColumn >> isCheckBox [

	^self isOption: #checkbox
]

{ #category : 'testing' }
SBSTableSingleColumn >> isCheckButton [

	^self isCheckBox or: [self isRadioButton]
]

{ #category : 'testing' }
SBSTableSingleColumn >> isRadioButton [

	^self isOption: #radio
]

{ #category : 'testing' }
SBSTableSingleColumn >> isSearchable [

	^false
]

{ #category : 'testing' }
SBSTableSingleColumn >> isSortable [

	^self sortBlock notNil
]

{ #category : 'accessing' }
SBSTableSingleColumn >> isSortable: aBoolean [

	"Convenience method to install a default sortBlock"

	aBoolean 
		ifTrue: [self sortBlock: self defaultSortBlock]
		ifFalse: [self sortBlock: nil]
]

{ #category : 'testing' }
SBSTableSingleColumn >> needsFooterCallback [

	^footerBlock notNil and: [self table hasServerSidePagination not]
]

{ #category : 'testing' }
SBSTableSingleColumn >> needsFormatterScript [

	^self subclassResponsibility
]

{ #category : 'testing' }
SBSTableSingleColumn >> needsSortCallback [

	^self isSortable and: [self hasCustomSort and: [self table hasServerSort not]]
]

{ #category : 'rendering' }
SBSTableSingleColumn >> renderFooterScriptOn: html [

	| functionName function statement |
	
	functionName := self option: #footerFormatter.
	function := JSFunction named: functionName arguments: #('args' 'footer').

	statement := 
		html jQuery ajax 
			async: false; 
			yourself.

	statement callback: [self handleFooterCallback].

	statement onSuccess: ('html=result' asFunction: #('result')).

	function 
		add: statement; 
		returnExpression: 'html'.

	html script: function
]

{ #category : 'rendering' }
SBSTableSingleColumn >> renderFormatterScriptOn: html [

	self subclassResponsibility
]

{ #category : 'rendering' }
SBSTableSingleColumn >> renderOn: html [

	| tableHeading |

	tableHeading := html tableHeading.
	tableHeading id: (self idOn: html).

	self 
		renderTableHeading: tableHeading;
		renderScriptsOn: html
]

{ #category : 'rendering' }
SBSTableSingleColumn >> renderScriptsOn: html [

	self needsFormatterScript ifTrue: [self renderFormatterScriptOn: html].
	self needsSortCallback ifTrue: [self renderSortScriptOn: html].
	self needsFooterCallback ifTrue: [self renderFooterScriptOn: html]
]

{ #category : 'rendering' }
SBSTableSingleColumn >> renderSortScriptOn: html [

	| functionName function idAccessor |
	
	functionName := self option: #sorter.
	function := JSFunction named: functionName arguments: #('fieldA' 'fieldB' 'rowA' 'rowB').

	idAccessor := self table idAccessor.
	function 
		add: 
			(html jQuery ajax 
				async: false; 
				callback: [ :params | self handleSortCallbackWith: params] value: {html javascript alias: 'rowA.', idAccessor. html javascript alias: 'rowB.', idAccessor};
				onSuccess: ('sortResult=result' asFunction: #('result'));
				yourself);
		returnExpression: 'sortResult'.

	html script: function
]

{ #category : 'accessing' }
SBSTableSingleColumn >> rowSpan [

	^(self table columnDepth - self depth) +1
]

{ #category : 'accessing' }
SBSTableSingleColumn >> sortBlock [

	"The sort block to use when sorting on this column.
	Note the block is evaluated with the row object, not the field value"

	^sortBlock
]

{ #category : 'accessing' }
SBSTableSingleColumn >> sortBlock: anObject [

	"The sort block to use when sorting on this column.
	Note the block is evaluated with the row object, not the field value"

	sortBlock := anObject
]
