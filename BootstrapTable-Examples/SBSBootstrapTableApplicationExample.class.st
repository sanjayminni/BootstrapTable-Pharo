Class {
	#name : 'SBSBootstrapTableApplicationExample',
	#superclass : 'SBSBootstrapTableExample',
	#instVars : [
		'list'
	],
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample class >> exampleName [

	^'Demo Application 1'
]

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample class >> ordering [

	^99
]

{ #category : 'add/remove' }
SBSBootstrapTableApplicationExample >> addProduct [

	| id newProduct |

	id := (self list inject: 0 into: [ :max :each | max max: each id]) + 1.
	newProduct := 
		SBSTableExampleProduct new
			id: id;
			name: 'Item ', id asString;
			price: 0s2;
			inStock: true.

	self list addLast: newProduct.

	^newProduct
]

{ #category : 'add/remove' }
SBSBootstrapTableApplicationExample >> addProductWithScript: script [

	| product |

	product := self addProduct.

	script
		add: self table collapseAll;
		add: self table unselectAll;
		add: (self table onItemAdded: product);
		add: (self table expand: product)
]

{ #category : 'initialize-release' }
SBSBootstrapTableApplicationExample >> createTable [

	^SBSTable new
		id: #table;
		list: self list;
		hasSearch: true;
		hasFooter: true;
		clickToSelect: true;
		detailComponentClass: SBSTableExampleProductEditor;
		option: #toolbar value: '#toolbar';
		option: #exportTypes value: #('json' 'xml' 'png' 'csv' 'txt' 'sql' 'doc' 'excel' 'xlsx' 'pdf') asJson;
		options: #(#showRefresh #showToggle #showFullscreen #showColumns #showColumnsToggleAll #showExport) value: true;

		addRowSelector;
		addColumn: 
			(SBSTableColumn new
				label: 'ID';
				accessor: #id;
				isSortable: true;
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Name';
				accessor: #name;
				sortBlock: [ :a : b | a id <= b  id];
				footerText: 'Total:';
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Price';
				accessor: #price;
				isSortable: true;
				alignRight;
				footerIsTotal;
				renderBlock: [ :html :price | html text: ('$', price greaseString)];
				yourself);
		addColumn: 
			(SBSTableColumn new
				isSortable: true;
				beCheckBox;
				label: 'In Stock?';
				accessor: #inStock;
				width: 120;
				footerBlock: [table data inject: 0 into: [ :count :each | each inStock ifTrue: [count + 1] ifFalse: [count]]];
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: '';
				clickToSelect: false;
				alignCenter;
				componentGenerator: [ :col :row | SBSTableExampleDeleteRowComponent new column: col; model: row; hostApplication: self; yourself];
				yourself);
		yourself
]

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample >> inspectSelectedProduct [

	self table selection inspect
]

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample >> list [

	^list ifNil: [list := super list]
]

{ #category : 'add/remove' }
SBSBootstrapTableApplicationExample >> remove: anObject [

	^self table onItemRemoved: (self list remove: anObject)
]

{ #category : 'add/remove' }
SBSBootstrapTableApplicationExample >> removeSelectionsWithScript: script [

	| removed |

	removed := self list removeAll: table selections.

	script
		add: self table collapseAll;
		add: self table unselectAll;
		add: (self table onItemsRemoved: removed)
]

{ #category : 'rendering' }
SBSBootstrapTableApplicationExample >> renderDescriptionOn: html [

	html text: 'Simple Demo Application with embedded data. Demonstrates selection, sort, detail view, list updating etc.'
]

{ #category : 'rendering' }
SBSBootstrapTableApplicationExample >> renderTableOn: html [

	self renderToolbarOn: html.

	super renderTableOn: html.

	self table 
		whenHasSelectionEnable: (html jQuery: #removeButton) on: html;
		whenHasSingleSelectionEnable: (html jQuery: #inspectButton) on: html
]

{ #category : 'rendering' }
SBSBootstrapTableApplicationExample >> renderToolbarOn: html [

	html buttonToolbar 
		id: 'toolbar';
		with: 
			[html formButton 
					id: #addButton;
					bePrimary;
					onClick: (html jQuery ajax script:  [ :script | self addProductWithScript: script]);
					with: 'Add'.
			html formButton 
					id: #inspectButton;
					beInfo;
					disabled;
					onClick: (html jQuery ajax script:  [ :script | self inspectSelectedProduct]);
					with: 'Inspect'.
			html formButton 
					id: #removeButton;
					beDanger;
					disabled;
					onClick: (html jQuery ajax script: [ :script | self removeSelectionsWithScript: script]);
					with: 'Remove']
]

{ #category : 'updating' }
SBSBootstrapTableApplicationExample >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	"intentionally kept separate in example just to illustrate"
	SBSTableExportCDNDeploymentLibrary addLoadScriptTo: anHtmlRoot.
	
]
