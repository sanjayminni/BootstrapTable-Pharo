Class {
	#name : 'SBSBootstrapTableSortableExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableSortableExample class >> exampleName [

	^'Sortable'
]

{ #category : 'accessing' }
SBSBootstrapTableSortableExample class >> ordering [

	^8
]

{ #category : 'initialize-release' }
SBSBootstrapTableSortableExample >> createTable [

	^SBSTable new
		list: self list;

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
				sortBlock: [ :a : b | a id <= b id];
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Price';
				accessor: #price;
				renderBlock: [ :html :price | html text: ('$', price greaseString)];
				isSortable: true;
				yourself);
		yourself
]

{ #category : 'rendering' }
SBSBootstrapTableSortableExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'isSortable: true'.
	html text: ' or set a '.
	html code with: 'sortBlock '.
	html text: 'to make a column sortable.'
]
