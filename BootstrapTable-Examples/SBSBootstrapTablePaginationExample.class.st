Class {
	#name : 'SBSBootstrapTablePaginationExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTablePaginationExample class >> exampleName [

	^'Pagination 1'
]

{ #category : 'accessing' }
SBSBootstrapTablePaginationExample class >> ordering [

	^3
]

{ #category : 'initialize-release' }
SBSBootstrapTablePaginationExample >> createTable [

	^SBSTable new
		list: self list;
		hasPagination: true;
		option: #height value: 600;

		addColumn: 
			(SBSTableColumn new
				label: 'ID';
				accessor: #id;
				yourself);
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

{ #category : 'accessing' }
SBSBootstrapTablePaginationExample >> listSize [
	^32
]

{ #category : 'rendering' }
SBSBootstrapTablePaginationExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'hasPagination: true'.
	html text: ' to show a pagination toolbar beneath the table.'
]
