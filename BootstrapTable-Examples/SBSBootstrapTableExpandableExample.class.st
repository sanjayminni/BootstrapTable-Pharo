Class {
	#name : 'SBSBootstrapTableExpandableExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableExpandableExample class >> exampleName [

	^'Expandable'
]

{ #category : 'accessing' }
SBSBootstrapTableExpandableExample class >> ordering [

	^10
]

{ #category : 'initialize-release' }
SBSBootstrapTableExpandableExample >> createTable [

	^SBSTable new
		list: self list;
		detailComponentClass: SBSBootstrapDetailComponentExample;

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

{ #category : 'rendering' }
SBSBootstrapTableExpandableExample >> renderDescriptionOn: html [

	html text: 'Set a '.
	html code with: 'detailComponentClass'.
	html text: ' to make rows expandable with a detailed UI.'
]
