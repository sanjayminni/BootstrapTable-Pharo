Class {
	#name : 'SBSBootstrapTableSearchableExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableSearchableExample class >> exampleName [

	^'Searchable'
]

{ #category : 'accessing' }
SBSBootstrapTableSearchableExample class >> ordering [

	^7
]

{ #category : 'initialize-release' }
SBSBootstrapTableSearchableExample >> createTable [

	^SBSTable new
		list: self list;
		hasSearch: true;
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
SBSBootstrapTableSearchableExample >> listSize [
	^100
]

{ #category : 'rendering' }
SBSBootstrapTableSearchableExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'hasSearch: true'.
	html text: ' to add an automatically-managed search box.'
]
