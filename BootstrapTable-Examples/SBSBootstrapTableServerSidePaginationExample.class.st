Class {
	#name : 'SBSBootstrapTableServerSidePaginationExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableServerSidePaginationExample class >> exampleName [

	^'Pagination 2'
]

{ #category : 'accessing' }
SBSBootstrapTableServerSidePaginationExample class >> ordering [

	^5
]

{ #category : 'initialize-release' }
SBSBootstrapTableServerSidePaginationExample >> createTable [

	^SBSTable new
		fetchData;
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
				renderBlock: [ :html :price | html text: ('$', price displayString)];
				yourself);
		yourself
]

{ #category : 'accessing' }
SBSBootstrapTableServerSidePaginationExample >> listSize [
	^1000
]

{ #category : 'rendering' }
SBSBootstrapTableServerSidePaginationExample >> renderDescriptionOn: html [

	html text: 'When '.
	html code: 'fetchData'.
	html text: ' is combined with '.
	html code with: 'hasPagination: true'.
	html text: ' data is incrementally fetched from the server page-by-page.'
]
