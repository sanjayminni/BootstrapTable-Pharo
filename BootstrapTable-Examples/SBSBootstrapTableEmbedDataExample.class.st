Class {
	#name : 'SBSBootstrapTableEmbedDataExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableEmbedDataExample class >> exampleName [

	^'Embed Data'
]

{ #category : 'accessing' }
SBSBootstrapTableEmbedDataExample class >> ordering [

	^2
]

{ #category : 'initialize-release' }
SBSBootstrapTableEmbedDataExample >> createTable [

	^SBSTable new
		list: self list;

		addColumn: 
			(SBSTableColumn new
				label: 'ID';
				accessor: #id
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
SBSBootstrapTableEmbedDataExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'list:'.
	html text: ' to set the table data to a '.
	html code with: 'Collection'.
	html text: '. The default is to embed the list''s JSON representation in the page.'
]
