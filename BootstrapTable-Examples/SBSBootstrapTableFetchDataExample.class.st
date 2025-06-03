Class {
	#name : 'SBSBootstrapTableFetchDataExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableFetchDataExample class >> exampleName [

	^'Fetch Data'
]

{ #category : 'accessing' }
SBSBootstrapTableFetchDataExample class >> ordering [

	^4
]

{ #category : 'initialize-release' }
SBSBootstrapTableFetchDataExample >> createTable [

	^SBSTable new
		fetchData;
		list: self list;

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
SBSBootstrapTableFetchDataExample >> listSize [
	^20
]

{ #category : 'rendering' }
SBSBootstrapTableFetchDataExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'fetchData'.
	html text: ' to have the table data fetched from an automatically-generated URL.'.
]
