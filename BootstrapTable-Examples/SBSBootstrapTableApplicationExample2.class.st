Class {
	#name : 'SBSBootstrapTableApplicationExample2',
	#superclass : 'SBSBootstrapTableApplicationExample',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample2 class >> exampleName [

	^'Demo Application 2'
]

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample2 class >> ordering [

	^super ordering + 1
]

{ #category : 'initialize-release' }
SBSBootstrapTableApplicationExample2 >> createTable [

	^SBSTable new
		id: #table;
		fetchData;
		list: self list;
		hasPagination: true;
		hasSearch: true;
		hasFooter: true;
		clickToSelect: true;
		detailComponentClass: SBSTableExampleProductEditor;
		option: #toolbar value: '#toolbar';
		options: #(#showRefresh #showToggle #showFullscreen #showColumns #showColumnsToggleAll) value: true;

		addRowSelector;
		addColumn: 
			(SBSTableColumn new
				label: 'ID';
				accessor: #id;
				isSortable: true;
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Name';
				accessor: #name;
				sortBlock: [ :a : b | a id <= b  id];
				footerText: 'Total:';
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: 'Item Price';
				accessor: #price;
				isSortable: true;
				alignRight;
				footerIsTotal;
				renderBlock: [ :html :price | html text: ('$', price displayString)];
				yourself);
		addColumn: 
			(SBSTableColumn new
				isSortable: true;
				beCheckBox;
				label: 'In Stock?';
				accessor: #inStock;
				width: 120;
				footerBlock: [table data inject: 0 into: [ :count :each | each inStock ifTrue: [count + 1] ifFalse: [count]]];
				yourself);
		addColumn: 
			(SBSTableColumn new
				label: '';
				clickToSelect: false;
				alignCenter;
				componentGenerator: [ :col :row | SBSTableExampleDeleteRowComponent new column: col; model: row; hostApplication: self; yourself];
				yourself);
		yourself
]

{ #category : 'accessing' }
SBSBootstrapTableApplicationExample2 >> listSize [
	^1000
]

{ #category : 'rendering' }
SBSBootstrapTableApplicationExample2 >> renderDescriptionOn: html [

	html text: 'Enhanced Demo Application with a larger dataset. Features pagination with incremental data fetching.'
]
