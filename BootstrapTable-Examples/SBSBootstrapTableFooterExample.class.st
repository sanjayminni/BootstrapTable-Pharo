Class {
	#name : 'SBSBootstrapTableFooterExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableFooterExample class >> exampleName [

	^'Footers'
]

{ #category : 'accessing' }
SBSBootstrapTableFooterExample class >> ordering [

	^12
]

{ #category : 'initialize-release' }
SBSBootstrapTableFooterExample >> createTable [

	^SBSTable new
		list: self list;
		hasFooter: true;

		addColumn: 
			(SBSTableColumn new
				label: 'ID';
				accessor: #id;
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Name';
				accessor: #name;
				footerText: 'Total:';
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Price';
				accessor: #price;
				footerIsTotal;
				renderBlock: [ :html :price | html text: ('$', price greaseString)];
				yourself);
		yourself
]

{ #category : 'rendering' }
SBSBootstrapTableFooterExample >> renderDescriptionOn: html [

	html text: 'Set '.
	html code with: 'hasFooter: true'.
	html text: ' to add a footer to the table. On individual columns use '.
	html code with: 'footerBlock: footerText:'.
	html text: ' or '.
	html code with: 'footerIsTotal'.
	html text: ' to define a footer for that column.'
]
