Class {
	#name : 'SBSBootstrapColumnGroupsExample',
	#superclass : 'SBSBootstrapTableExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapColumnGroupsExample class >> exampleName [

	^'Column Groups'
]

{ #category : 'accessing' }
SBSBootstrapColumnGroupsExample class >> ordering [

	^11
]

{ #category : 'initialize-release' }
SBSBootstrapColumnGroupsExample >> createTable [

	^SBSTable new
		list: self list;

		addRowSelector;
		addColumn: 
			(SBSTableColumnGroup new 
				label: 'Product'; 
				addColumn:
					(SBSTableColumn new
						label: 'ID';
						accessor: #id;
						isSortable: true;
						yourself);
				addColumn: 
					(SBSTableColumnGroup new 
						label: 'Details'; 
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
								renderBlock: [ :html :price | html text: ('$', price displayString)];
								isSortable: true;
								yourself); 
						yourself);
				yourself);
			yourself
]

{ #category : 'rendering' }
SBSBootstrapColumnGroupsExample >> renderDescriptionOn: html [

	html text: 'Use '.
	html code with: 'SBSTableColumnGroup'.
	html text: ' to group columns together'
]
