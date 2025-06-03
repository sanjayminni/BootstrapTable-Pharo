Class {
	#name : 'SBSBootstrapTableIntroExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableIntroExample class >> exampleName [

	^'Introduction'
]

{ #category : 'accessing' }
SBSBootstrapTableIntroExample class >> ordering [

	^1
]

{ #category : 'initialize-release' }
SBSBootstrapTableIntroExample >> createTable [

	^SBSTable new
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
SBSBootstrapTableIntroExample >> renderDescriptionOn: html [

	html paragraph: 
		[html text: 'A Seaside component wrapping '.
		html anchor url: 'https://bootstrap-table.com'; with: 'Bootstrap Table'].

	html paragraph: 
		[html text: 'Define your table with an instance of '.
		html code with: 'SBSTable'.
		html text: ' adding instances of '.
		html code with: 'SBSTableColumn'.
		html text: ' for each aspect of your object that you want to display.']
]
