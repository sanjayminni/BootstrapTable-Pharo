Class {
	#name : 'SBSTable',
	#superclass : 'SBSTableCoreComponent',
	#instVars : [
		'components',
		'columns',
		'list',
		'searchString',
		'sortColumn',
		'sortDirection',
		'data',
		'dataStream',
		'detailComponentGenerator',
		'pageNum',
		'pageSize',
		'selections',
		'hostCanvas',
		'rowsById',
		'rowsByIndex'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'adding' }
SBSTable >> _addColumn: aSBSTableColumn [

	^self columns add: aSBSTableColumn
]

{ #category : 'accessing' }
SBSTable >> _rowDataFor: anObject [

	| rowData |

	rowData := Dictionary new: self columns size.

	self columns do: [ :column | column hasContent ifTrue: [rowData at: column fieldName put: (column contentFromRow: anObject)]].
	rowData at: self idAccessor put: (self idOfRow: anObject).

	^rowData
]

{ #category : 'adding' }
SBSTable >> addCheckBoxColumn [
	^self addColumn: SBSTableRowSelector new
]

{ #category : 'adding' }
SBSTable >> addColumn [

	^self addColumn: SBSTableColumn new
]

{ #category : 'adding' }
SBSTable >> addColumn: aSBSTableColumnOrGroup [

	"For convenience the parameter may be a Column or ColumnGroup"

	self components add: aSBSTableColumnOrGroup.
	^aSBSTableColumnOrGroup addToTable: self
]

{ #category : 'adding' }
SBSTable >> addRowSelector [

	^self addColumn: SBSTableRowSelector new
]

{ #category : 'jQuery' }
SBSTable >> append: anObject [

	"Append anObject to the client's display of the receiver.
	Answer a statement to apply to a JSScript to update the client display"

	| listSize lastPageNum rowData |

	self hasPagination ifTrue: 
		["If we're not on the last page, or the last page is full, invoke a refresh instead"
		listSize  := self data size - 1. "before addition of anObject"
		lastPageNum := self pageNumForIndex: listSize.
		(pageNum = lastPageNum and: [(listSize \\ self pageSize) > 0]) ifFalse: 
			[^self refreshEnsuringVisible: anObject]].

	rowData := self rowDataFor: anObject.
	^self onClient append: rowData
]

{ #category : 'options' }
SBSTable >> applyOptionsTo: aTable on: html [

	self option: #uniqueId value: self idAccessor.

	self shouldFetchData ifTrue: 
		[self 
			option: #url value: (self urlOn: html);
			option: #cache value: false. "<- caching doesn't appear to play well with dynamic updates"
		self hasPagination ifTrue: 
			[self option: #sidePagination value: 'server'.
			self hasSearch ifTrue: [self option: #searchable value: true]]].

	self hasDetailComponent ifTrue: 
		[self 
			option: #detailView value: true;
			option: #detailFormatter value: ('detailFormatter', self id)].

	self applyOptionsTo: aTable
]

{ #category : 'options' }
SBSTable >> clickToSelect: aBoolean [

	self option: #clickToSelect value: aBoolean
]

{ #category : 'jQuery' }
SBSTable >> collapseAll [

	^self onClient collapseAll
]

{ #category : 'accessing' }
SBSTable >> columnDepth [

	^self columns inject: 1 into: [ :max :each | max max: each depth]
]

{ #category : 'accessing' }
SBSTable >> columns [
	^columns
]

{ #category : 'accessing' }
SBSTable >> columns: anObject [
	columns := anObject
]

{ #category : 'accessing' }
SBSTable >> components [
	^components
]

{ #category : 'accessing' }
SBSTable >> components: anObject [
	components := anObject
]

{ #category : 'accessing' }
SBSTable >> data [

	^data
]

{ #category : 'accessing' }
SBSTable >> data: aCollection [

	data := aCollection.
	self 
		resetDataStream;
		resetSelections
]

{ #category : 'accessing' }
SBSTable >> dataStream [

	^dataStream ifNil: [dataStream := ReadStream on: self data]
]

{ #category : 'accessing' }
SBSTable >> detailComponentClass: aSBSTableSubComponentSubclass [

	"Convenience method.
	Argument should be a subclass of SBSTableSubComponent (or compatible class)"

	self detailComponentGenerator: 
		[ :table :row |
		aSBSTableSubComponentSubclass new
			table: table; 
			model: row;
			yourself]
]

{ #category : 'accessing' }
SBSTable >> detailComponentGenerator [

	"Optional - a 2-arg block which generates a component to use to display the detail view of an item in the table. 
	Arguments are the receiver and the row object for which the component is being generated"

	^detailComponentGenerator
]

{ #category : 'accessing' }
SBSTable >> detailComponentGenerator: aBlock [

	"Optional - a 2-arg block which generates a component to use to display the detail view of an item in the table. 
	Arguments are the receiver and the row object for which the component is being generated"

	detailComponentGenerator := aBlock
]

{ #category : 'options' }
SBSTable >> embedData [

	self shouldEmbedData: true
]

{ #category : 'accessing' }
SBSTable >> embedData: aCollection [

	self 
		shouldEmbedData: true;
		data: aCollection
]

{ #category : 'jQuery' }
SBSTable >> ensureVisible: anObject [

	| index objectPageNum |

	index := self data indexOf: anObject.
	objectPageNum := (index // self pageSize) + 1.
	pageNum = objectPageNum ifFalse: [self selectPage: objectPageNum]
]

{ #category : 'jQuery' }
SBSTable >> expand: anObject [

	^self onClient expandRowByUniqueId: (self idOfRow: anObject)
]

{ #category : 'options' }
SBSTable >> fetchData [

	self shouldEmbedData: false
]

{ #category : 'accessing' }
SBSTable >> fetchData: aCollection [

	self 
		shouldEmbedData: false;
		list: aCollection;
		data: aCollection
]

{ #category : 'callbacks' }
SBSTable >> handlePageChangeCallback: aString [

	| params |

	params := WAJsonParser parse: ('[<1s>]' expandMacrosWith: aString).

	pageNum := params first.
	pageSize := params second.

	self resetSelections
]

{ #category : 'callbacks' }
SBSTable >> handleRefreshCallback [

	self resetSelections
]

{ #category : 'callbacks' }
SBSTable >> handleRenderDetailForRowIdCallback: anInteger [

	(self rowWithId: anInteger) ifNotNil: 
		[ :row |
		self requestContext respond: 
			[ :response  |
			response 
				contentType: self application contentType;
				nextPutAll: 
					(self rendererClass builder
						fullDocument: false;
						render: 
							[ :html | 
							self initializeSubCanvas: html.
							(self detailComponentGenerator value: self value: row) renderContentOn: html])]]
]

{ #category : 'callbacks' }
SBSTable >> handleSelectionsChangedCallback: aString [

	| rowIds |

	rowIds := WAJsonParser parse: ('[<1s>]' expandMacrosWith: aString).

	selections := (rowIds collect: [ :each | self rowWithId: each])
]

{ #category : 'callbacks' }
SBSTable >> handleSortCallback: aString [

	| stream fieldName direction |

	stream := aString readStream.
	fieldName := stream upTo: $,.
	direction := stream upToEnd.

	sortColumn := self columns detect: [ :each | each fieldName = fieldName].
	sortDirection := direction = 'asc' .

	self sortData.
	self sortResetsPage ifTrue: [pageNum := nil]
]

{ #category : 'testing' }
SBSTable >> hasClientSidePagination [
	
	^self hasPagination and: [self hasServerSidePagination not]
]

{ #category : 'testing' }
SBSTable >> hasDetailComponent [

	^detailComponentGenerator notNil
]

{ #category : 'testing' }
SBSTable >> hasFooter [

	^(self isOption: #showFooter) and: [self columns anySatisfy: [ :each | each hasFooter]]
]

{ #category : 'options' }
SBSTable >> hasFooter: aBoolean [

	self option: #showFooter value: aBoolean
]

{ #category : 'testing' }
SBSTable >> hasPagination [
	
	^self isOption: #pagination
]

{ #category : 'options' }
SBSTable >> hasPagination: aBoolean [

	self option: #pagination value: aBoolean
]

{ #category : 'testing' }
SBSTable >> hasSearch [

	^self isOption: #search
]

{ #category : 'options' }
SBSTable >> hasSearch: aBolean [

	self option: #search value: aBolean
]

{ #category : 'testing' }
SBSTable >> hasServerSidePagination [
	
	^(self option: #sidePagination) = 'server'
]

{ #category : 'testing' }
SBSTable >> hasServerSort [

	^(self isOption: #serverSort default: true) and: [self hasServerSidePagination]
]

{ #category : 'accessing' }
SBSTable >> hostCanvas [

	"The canvas onto which the receiver was last rendered"

	^hostCanvas
]

{ #category : 'accessing' }
SBSTable >> idAccessor [

	"We use the index of an object in the receiver's rowsById collection as its unique ID. 
	This is inserted in the the JSON under a special key"

	^#__uid__
]

{ #category : 'accessing' }
SBSTable >> idOfRow: anObject [

	| uid |

	uid := rowsById identityIndexOf: anObject.
	^uid = 0 
		ifTrue: [rowsById addLast: anObject. rowsById size]
		ifFalse: [uid]
]

{ #category : 'accessing' }
SBSTable >> indexOfColumn: aColumn [

	^self columns identityIndexOf: aColumn
]

{ #category : 'accessing' }
SBSTable >> indexOfRow: anObject [

	^self hasClientSidePagination 
		ifTrue: [self pageOffset + (rowsByIndex indexOf: anObject)]
		ifFalse: [rowsByIndex indexOf: anObject]
]

{ #category : 'initialize-release' }
SBSTable >> initialize [

	super initialize.

	self 
		components: OrderedCollection new;
		columns: OrderedCollection new;
		embedData;
		list: #()
]

{ #category : 'helpers' }
SBSTable >> initializeSubCanvas: aCanvas [

	"Private - aCanvas is being used to render a subcomponent of the receiver (e.g. a detail view is being opened, or a column with a custom renderer).
	Initialize it such that callbacks will work and element ids will be unique"

	aCanvas initializeWithContext: 
				(hostCanvas context copy
					document: aCanvas document;
					yourself)
]

{ #category : 'jQuery' }
SBSTable >> insert: anObject at: anInteger [

	"Insert anObject into the client's display of the receiver at anInteger position.
	Answer a statement to apply to a JSScript to update the client display"

	| insertPageNum rowData index |

	self hasPagination ifTrue: 
		["If anInteger isn't on the the current page fallback to a refresh+page change"
		insertPageNum := self pageNumForIndex: anInteger.
		insertPageNum ~= pageNum ifTrue: [^self refreshEnsuringVisible: anObject].

		"If the insertion would cause the visible rows to exceed the pageSize then also refresh"
		(pageNum < self lastPageNum and: [rowsByIndex size = self pageSize]) ifTrue: [^self refresh]].

	self isCustomSorted ifTrue: 
		["insertRow appears to go awry when using a non-standard sort"
		^self refreshEnsuringVisible: anObject].

	index := anInteger \\ self pageSize.
	rowsByIndex add: anObject beforeIndex: index.
	rowData := self _rowDataFor: anObject.	
	^self onClient insertRow: rowData at: index
]

{ #category : 'testing' }
SBSTable >> isCustomSorted [

	^self isSorted and: [sortColumn hasCustomSort]
]

{ #category : 'testing' }
SBSTable >> isSortable [

	^(self isOption: #sortable default: true) and: [self columns anySatisfy: [ :each | each isSortable]]
]

{ #category : 'testing' }
SBSTable >> isSorted [

	^sortColumn notNil
]

{ #category : 'accessing' }
SBSTable >> json [

	| requestFields start size stream results footerData |

	rowsByIndex := OrderedCollection new: 20.
	self hasServerSidePagination ifFalse: [^(self data collect: [ :each | self rowDataFor: each]) asJson].

	requestFields := self requestContext request queryFields.
	self hasSearch ifTrue: [self setSearchString: (requestFields at: 'search' ifAbsent: [''])].
	start := (requestFields at: 'offset') asInteger.
	size := (requestFields at: 'limit') asInteger.
	pageSize isNil ifTrue: [pageSize := size].
	pageNum := (start // pageSize) + 1.

	stream := self dataStream.
	stream position: start.

	results := Dictionary new.
	results
		at: 'total' put: self data size;
		at: 'rows' put: ((stream next: size) collect: [ :each | self rowDataFor: each]).

	self hasFooter ifTrue: 
		[footerData := Dictionary new.
		self columns do: [ :each | footerData at: each fieldName put: each footerForData].
		results at: 'footer' put: footerData].

	^results asJson
]

{ #category : 'accessing' }
SBSTable >> lastPageNum [

	^self pageNumForIndex: self data size
]

{ #category : 'accessing' }
SBSTable >> list [

	"list stores aCollection of all items in the table.
	c.f. data which stores the currently-visible (e.g. filtered) collection of items"

	^list
]

{ #category : 'accessing' }
SBSTable >> list: anObject [

	"list stores aCollection of all items in the table.
	c.f. data which stores the currently-visible (i.e. filtered, sorted) collection of items"

	list := anObject.

	pageNum := 1.
	rowsById := OrderedCollection new.

	self data: self list
]

{ #category : 'testing' }
SBSTable >> needsClickNotification [

	^self columns anySatisfy: [ :each | each isCheckButton]
]

{ #category : 'testing' }
SBSTable >> needsPageChangeNotification [

	^self hasPagination
]

{ #category : 'testing' }
SBSTable >> needsRefreshNotification [

	"Refresh resets selections only when in fetch data mode"
	^(self isOption: #showRefresh) and: [self shouldFetchData and: [self needsClickNotification]]
]

{ #category : 'testing' }
SBSTable >> needsSortNotification [

	^self isSortable and: [self hasServerSidePagination]
]

{ #category : 'jQuery' }
SBSTable >> nextPage [

	^self onClient nextPage
]

{ #category : 'accessing' }
SBSTable >> onClient [

	^self onClient: hostCanvas
]

{ #category : 'accessing' }
SBSTable >> onClient: html [

	"Answer a JQBootstrapTable representing the receiver on the client being rendered by html"

	^html jQuery bootstrapTable: self id
]

{ #category : 'event handling' }
SBSTable >> onItemAdded: anObject [

	"anObject has been added to the receiver's list. 
	Update the receiver in the most efficient way depending on the position of anObject and sort order of the receiver.
	Answer a statement to apply to a JSScript to update the client display"

	self onListChanged.

	^anObject == data last 
		ifTrue: [self append: anObject]
		ifFalse: [self insert: anObject at: (data identityIndexOf: anObject)]
]

{ #category : 'event handling' }
SBSTable >> onItemRemoved: anObject [

	"anObject had been removed from the receiver's list.
	Answer the script to update the client display"

	^self onItemsRemoved: {anObject}
]

{ #category : 'event handling' }
SBSTable >> onItemsRemoved: aCollection [

	"aCollection of objects have been removed from the receiver's list.
	Answer the script to update the client display"

	self onListChanged.

	"Removing an entire page leaves a confusing empty list; refresh instead"
	^(self hasPagination and: [(pageNum < self lastPageNum) or: [aCollection size >= rowsByIndex size]]) 
		ifTrue: [self refresh]
		ifFalse: [self removeAll: aCollection]
]

{ #category : 'event handling' }
SBSTable >> onListChanged [

	self data: self list.
	self isSorted ifTrue: [self sortData].
	searchString := nil
]

{ #category : 'helpers' }
SBSTable >> pageNumForIndex: anInteger [

	^((anInteger - 1) // self pageSize) + 1
]

{ #category : 'accessing' }
SBSTable >> pageOffset [

	^pageNum isNil 
		ifTrue: [0]
		ifFalse: [(pageNum - 1) * self pageSize]
]

{ #category : 'accessing' }
SBSTable >> pageSize [

	^pageSize ifNil: [self option: #pageSize default: 10]
]

{ #category : 'jQuery' }
SBSTable >> previousPage [

	^self onClient previousPage
]

{ #category : 'jQuery' }
SBSTable >> refresh [

	self resetRowsById.

	^self onClient refresh
]

{ #category : 'jQuery' }
SBSTable >> refreshEnsuringVisible: anObject [

	| firstIndex lastIndex |

	pageNum := self pageNumForIndex: (self data indexOf: anObject).
	firstIndex := ((pageNum - 1) * self pageSize) + 1.
	lastIndex := ((firstIndex + self pageSize) - 1) min: self data size.
	self resetRowsById.
	rowsById addAll: (data copyFrom: firstIndex to: lastIndex).

	^self onClient refreshSelectingPage: pageNum
]

{ #category : 'jQuery' }
SBSTable >> removeAll: aCollection [

	| ids params |

	ids := aCollection collect: 
		[ :each || uid |
		uid := self idOfRow: each.
		rowsById at: uid put: nil.
		rowsByIndex remove: each.
		uid].

	params := Dictionary new.
	params
		at: 'field' put: self idAccessor;
		at: 'values' put: ids.

	^self onClient remove: params
]

{ #category : 'rendering' }
SBSTable >> renderClickEventHandlerOn: html [

	| functionName function jqSelf handlerFunction |

	"Callback function"
	functionName := 'clickEventCallback', self id.
	function := JSFunction named: functionName arguments: #('ids').

	function 
		add: 
			(html jQuery ajax 
				async: false; 
				callback: [ :ids | self handleSelectionsChangedCallback: ids] value: (html javascript alias: 'ids');
				yourself).

	html script: function asJavascript.

	jqSelf := self onClient: html.
	handlerFunction := (jqSelf data assignLocalTo: 'rows') asFunction: #('elem').
	handlerFunction 
		add: (jqSelf newCopy selections assignLocalTo: 'selectedRows');
		addExpression: (functionName, '(selectedRows.map((row) => row.', self idAccessor, '))'). 
	
	self whenSelectionChangeEvaluate: handlerFunction on: html
]

{ #category : 'rendering' }
SBSTable >> renderContentOn: html [

	| table |

	table := html table.
	table id: (self idOn: html).

	self applyOptionsTo: table on: html.

	table with: 
		[html tableHead: 
			[html tableRow:
				[self components do: [ :each | each renderOn: html]]]].

	self renderScriptsOn: html.

	hostCanvas := html
]

{ #category : 'rendering' }
SBSTable >> renderDataScriptOn: html [

	| stream |

	stream := WriteStream on: (String new: 128).

	stream 
		nextPutAll: 'const $table = $(''#'; nextPutAll: self id; 
		nextPutAll: '''); $(function() {const data = '; nextPutAll: self json; 
		nextPutAll: '; $table.bootstrapTable({ data }) })'.

	html script: stream contents
]

{ #category : 'rendering' }
SBSTable >> renderDetailScriptOn: html [

	| functionName function |
	
	functionName := self option: #detailFormatter.
	function := JSFunction named: functionName arguments: #('index' 'row' 'element').

	function 
		add: 
			(html jQuery ajax 
				async: false; 
				callback: [ :rowId | self handleRenderDetailForRowIdCallback: rowId asInteger] value: (html javascript alias: 'row.', self idAccessor);
				onSuccess: ('html=result' asFunction: #('result'));
				yourself);
		returnExpression: 'html'.

	html script: function asJavascript
]

{ #category : 'rendering' }
SBSTable >> renderPageChangeEventHandlerOn: html [

	| function |

	function := 
		(html jQuery ajax 
			callback: [ :vars | self handlePageChangeCallback: vars] value: (#('pageNum' 'pageSize') collect: [ :each | html javascript alias: each]);
			yourself) asFunction: #('elem' 'pageNum' 'pageSize').

	self hasDetailComponent ifTrue: [function add: (self onClient: html) collapseAll].

	self whenPageChangeEvaluate: function on: html
]

{ #category : 'rendering' }
SBSTable >> renderRefreshEventHandlerOn: html [

	| function |
	
	function := 
		(html jQuery ajax 
			callback: [self handleRefreshCallback];
			yourself) asFunction.

	self whenRefreshEvaluate: function on: html
]

{ #category : 'rendering' }
SBSTable >> renderScriptsOn: html [

	self shouldEmbedData ifTrue: [self renderDataScriptOn: html].
	self needsPageChangeNotification ifTrue: [self renderPageChangeEventHandlerOn: html].
	self needsSortNotification ifTrue: [self renderSortEventHandlerOn: html].
	self needsClickNotification ifTrue: [self renderClickEventHandlerOn: html].
	self needsRefreshNotification ifTrue: [self renderRefreshEventHandlerOn: html].
	self hasDetailComponent ifTrue: [self renderDetailScriptOn: html]
]

{ #category : 'rendering' }
SBSTable >> renderSortEventHandlerOn: html [

	| function |

	function := 
		(html jQuery ajax 
			async: false; 
			callback: [ :vars | self handleSortCallback: vars] value: (#('name' 'order') collect: [ :each | html javascript alias: each]);
			yourself) asFunction: #('elem' 'name' 'order').

	self hasDetailComponent ifTrue: [function add: (self onClient: html) collapseAll].

	self whenSortEvaluate: function on: html

]

{ #category : 'helpers' }
SBSTable >> resetDataStream [

	dataStream := nil
]

{ #category : 'helpers' }
SBSTable >> resetRowsById [

	"We reuse rowsById following a refresh"

	| firstId |

	"Workaround for (apparent) issue: to allow actions specifying rows by id (e.g. expand: ) immediately after a refresh+page change we need to ensure the first row id is one on the current page.
	Front-load rowsById to ensure this is the case"
	rowsByIndex isEmpty 
		ifTrue: [firstId := 1]
		ifFalse: [firstId := self idOfRow: rowsByIndex first].

	rowsById := OrderedCollection new.
	firstId > 1 ifTrue: [rowsById addAll: (Array new: (firstId - 1))]
]

{ #category : 'jQuery' }
SBSTable >> resetSearch [

	^self onClient resetSearch
]

{ #category : 'helpers' }
SBSTable >> resetSelections [

	selections := #()
]

{ #category : 'accessing' }
SBSTable >> rowDataFor: anObject [

	| rowData |

	rowData := self _rowDataFor: anObject.

	rowsByIndex addLast: anObject.

	^rowData
]

{ #category : 'accessing' }
SBSTable >> rowWithId: anInteger [

	^rowsById at: anInteger ifAbsent: [nil]
]

{ #category : 'jQuery' }
SBSTable >> select: anObject [

	^self onClient selectIndex: (self indexOfRow: anObject)
]

{ #category : 'jQuery' }
SBSTable >> selectPage: anInteger [

	^self onClient selectPage: anInteger
]

{ #category : 'accessing' }
SBSTable >> selection [

	^selections size = 1 
		ifTrue: [selections first] 
		ifFalse: [self error: 'needs single selection']
]

{ #category : 'events' }
SBSTable >> selectionChangeEvents [

	^#('check' 'uncheck' 'check-all' 'uncheck-all' 'check-some' 'uncheck-some')
]

{ #category : 'events' }
SBSTable >> selectionResetEvents [

	^self shouldFetchData 
		ifTrue: [#('page-change' 'sort' 'refresh' 'reset-view')]
		ifFalse: [#('page-change')]
]

{ #category : 'accessing' }
SBSTable >> selections [

	^selections
]

{ #category : 'options' }
SBSTable >> setDefaultOptions [

	self shouldEmbedData: false
]

{ #category : 'helpers' }
SBSTable >> setSearchString: aString [

	| pattern searchableColumns |

	aString = searchString ifTrue: [^self].

	searchString := aString.
	searchString isEmpty ifTrue: [^self data: self list].

	pattern := '*', searchString, '*'.
	searchableColumns := self columns select: [ :col | col isSearchable].
	self data: (self list select: [ :each | searchableColumns anySatisfy: [ :col | pattern match: (col contentFromRow: each) displayString]])
]

{ #category : 'testing' }
SBSTable >> shouldEmbedData [

	^(options includesKey: #toggle) not
]

{ #category : 'options' }
SBSTable >> shouldEmbedData: aBoolean [

	aBoolean
		ifTrue: [self option: #toggle value: nil]
		ifFalse: [self option: #toggle value: 'table']
]

{ #category : 'testing' }
SBSTable >> shouldFetchData [

	^self shouldEmbedData not
]

{ #category : 'accessing' }
SBSTable >> sortBlock [

	^sortDirection
		ifTrue: [sortColumn sortBlock]
		ifFalse: [[ :a :b | sortColumn sortBlock value: b value: a]]
]

{ #category : 'helpers' }
SBSTable >> sortData [

	data sort: self sortBlock.
	self resetDataStream
]

{ #category : 'testing' }
SBSTable >> sortResetsPage [

	"Doesn't seem to be allowed with server-side pagination..?"
	^self hasServerSidePagination or: [self isOption: #sortResetPage]
]

{ #category : 'jQuery' }
SBSTable >> unselectAll [

	^self onClient unselectAll
]

{ #category : 'jQuery' }
SBSTable >> updateRow: anObject [

	^self onClient updateRow: 
			(Dictionary new
				at: 'index' put: (self indexOfRow: anObject) - 1;
				at: 'row' put: (self _rowDataFor: anObject);
				yourself)
]

{ #category : 'accessing' }
SBSTable >> urlOn: html [

	^(html context urlForDocument: (WABlockMimeDocument onBlock: [self json]) mimeType: WAMimeType applicationJson fileName: 'data.json') asString
]

{ #category : 'options' }
SBSTable >> validOptions [

	"https://bootstrap-table.com/docs/api/table-options/"

	^#(	#ajax
		#ajaxOptions
		#buttons
		#buttonsAlign
		#buttonsAttributeTitle
		#buttonsClass
		#buttonsOrder
		#buttonsPrefix
		#buttonsToolbar
		#cache
		#cardView
		#checkboxHeader
		#classes
		#clickToSelect
		#columns
		#contentType
		#customSearch
		#customSort
		#data
		#dataField
		#dataType
		#detailFilter
		#detailFormatter
		#detailView
		#detailViewAlign
		#detailViewByClick
		#detailViewIcon
		#escape
		#escapeTitle
		#filterOptions
		#fixedScroll
		#footerField
		#footerStyle
		#headerStyle
		#height
		#icons
		#iconSize
		#iconsPrefix
		#idField
		#ignoreClickToSelectOn
		#loadingFontSize
		#loadingTemplate
		#locale
		#maintainMetaData
		#method
		#minimumCountColumns
		#multipleSelectRow
		#pageList
		#pageNumber
		#pageSize
		#pagination
		#paginationDetailHAlign
		#paginationHAlign
		#paginationLoadMore
		#paginationLoop
		#paginationNextText
		#paginationPagesBySide
		#paginationParts
		#paginationPreText
		#paginationSuccessivelySize
		#paginationUseIntermediate
		#paginationVAlign
		#queryParams
		#queryParamsType
		#regexSearch
		#rememberOrder
		#responseHandler
		#rowAttributes
		#rowStyle
		#search
		#searchable
		#searchAccentNeutralise
		#searchAlign
		#searchHighlight
		#searchOnEnterKey
		#searchSelector
		#searchText
		#searchTimeOut
		#selectItemName
		#serverSort
		#showButtonIcons
		#showButtonText
		#showColumns
		#showColumnsSearch
		#showColumnsToggleAll
		#showExtendedPagination
		#showFooter
		#showFullscreen
		#showHeader
		#showPaginationSwitch
		#showRefresh
		#showSearchButton
		#showSearchClearButton
		#showToggle
		#sidePagination
		#silentSort
		#singleSelect
		#smartDisplay
		#sortable
		#sortClass
		#sortEmptyLast
		#sortName
		#sortOrder
		#sortReset
		#sortResetPage
		#sortStable
		#strictSearch
		#theadClasses
		#toggle
		#toolbar
		#toolbarAlign
		#totalField
		#totalNotFiltered
		#totalNotFilteredField
		#totalRows
		#trimOnSearch
		#undefinedText
		#uniqueId
		#url
		#virtualScroll
		#virtualScrollItemHeight
		#visibleSearch
	)
]

{ #category : 'events' }
SBSTable >> when: aString evaluate: aFunction on: html [

	self whenAny: {aString} evaluate: aFunction on: html
]

{ #category : 'events' }
SBSTable >> whenAny: aCollection evaluate: aFunction on: html [

	| writeStream |
	
	writeStream := WriteStream on: (String new: 64).
	writeStream nextPutAll: '$(''#'; nextPutAll: self id; nextPutAll: ''').on('''.

	aCollection do: [ :each | writeStream nextPutAll: each; nextPutAll: '.bs.table'] separatedBy: [writeStream space].

	writeStream nextPutAll: ''','.
	aFunction javascriptOn: writeStream.
	writeStream nextPut: $).

	html script: writeStream contents
]

{ #category : 'events' }
SBSTable >> whenHasSelectionEnable: aJQueryInstance on: html [

	"Set the enabled/disable state of aJQueryInstance based on whether the receiver has selections"

	self 
		whenSelectionChangeEvaluate: (aJQueryInstance newCopy propertyAt: 'disabled' put: self onClient hasSelection not) asFunction on: html;
		whenAny: self selectionResetEvents evaluate: (aJQueryInstance newCopy propertyAt: 'disabled' put: true) asFunction on: html
]

{ #category : 'events' }
SBSTable >> whenHasSingleSelectionEnable: aJQueryInstance on: html [

	"Set the enabled/disable state of aJQueryInstance based on whether the receiver has a single selection"

	self 
		whenSelectionChangeEvaluate: (aJQueryInstance newCopy propertyAt: 'disabled' put: self onClient hasNotSingleSelection) asFunction on: html;
		whenAny: self selectionResetEvents evaluate: (aJQueryInstance newCopy propertyAt: 'disabled' put: true) asFunction on: html
]

{ #category : 'events' }
SBSTable >> whenPageChangeEvaluate: aFunction on: html [

	"Arrange for aFunction to be run on the client whenever the page change event firest"

	self when: 'page-change' evaluate: aFunction on: html
]

{ #category : 'events' }
SBSTable >> whenRefreshEvaluate: aFunction on: html [

	"Arrange for aFunction to be run on the client whenever the refresh event firest"

	self when: 'refresh' evaluate: aFunction on: html
]

{ #category : 'events' }
SBSTable >> whenSelectionChangeEvaluate: aFunction on: html [

	"Arrange for aFunction to be run on the client whenever the selection change event firest"

	self whenAny: self selectionChangeEvents evaluate: aFunction on: html
]

{ #category : 'events' }
SBSTable >> whenSortEvaluate: aFunction on: html [

	"Arrange for aFunction to be run on the client whenever the sort event firest"

	self when: 'sort' evaluate: aFunction on: html
]
