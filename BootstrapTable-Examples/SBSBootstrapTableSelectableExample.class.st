Class {
	#name : 'SBSBootstrapTableSelectableExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableSelectableExample class >> exampleName [

	^'Selectable'
]

{ #category : 'accessing' }
SBSBootstrapTableSelectableExample class >> ordering [

	^9
]

{ #category : 'initialize-release' }
SBSBootstrapTableSelectableExample >> createTable [

	^SBSTable new
		list: self list;
		clickToSelect: true;

		addRowSelector;
		addColumn: 
			(SBSTableColumn new
				label: 'Item Name';
				accessor: #name;
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Price';
				accessor: #price;
				renderBlock: [ :html :price | html text: ('$', price greaseString)];
				yourself);
		yourself
]

{ #category : 'rendering' }
SBSBootstrapTableSelectableExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'addRowSelector'.
	html text: ' to make rows selectable and '.
	html code with: ' clickToSelect: true '.
	html text: ' to select by clicking rows.'
]

{ #category : 'rendering' }
SBSBootstrapTableSelectableExample >> renderExampleOn: html [

	super renderExampleOn: html.

	html span id: #count; with: '0 item(s) selected'.

	self table whenSelectionChangeEvaluate: ((html jQuery: #count) load html: [ :h | h render: (self table selections size asString, ' item(s) selected')]) asFunction on: html
]
