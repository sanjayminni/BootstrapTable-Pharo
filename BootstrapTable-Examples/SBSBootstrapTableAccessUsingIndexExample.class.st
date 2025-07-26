Class {
	#name : 'SBSBootstrapTableAccessUsingIndexExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableAccessUsingIndexExample class >> exampleName [

	^'Access using Index'
]

{ #category : 'accessing' }
SBSBootstrapTableAccessUsingIndexExample class >> ordering [

	^ 6
]

{ #category : 'initialize-release' }
SBSBootstrapTableAccessUsingIndexExample >> createTable [

	^SBSTable new
		list: (Array with: #(1 2 3) with: #(4 5 6) with: #(7 8 9)) ;
		addColumn: 
			(SBSTableColumn new
				label: 'Var-1';
				accessAtIndex: 1;
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Var-2';
				accessAtIndex: 2;
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Var-3';
				accessAtIndex: 3;
				renderBlock: [ :html :price | html text: ('$', price greaseString)];
				yourself);
		yourself
]

{ #category : 'rendering' }
SBSBootstrapTableAccessUsingIndexExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'accessAtIndex:'.
	html text: ' to use table row data in the form of '.
	html code with: 'Arrays'

]
