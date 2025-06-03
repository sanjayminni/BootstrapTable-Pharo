Class {
	#name : 'SBSTableColumnGroup',
	#superclass : 'SBSTableColumnComponent',
	#instVars : [
		'components'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'operations' }
SBSTableColumnGroup >> addColumn: aSBSTableColumnOrGroup [

	aSBSTableColumnOrGroup parentGroup: self.
	self components add: aSBSTableColumnOrGroup
]

{ #category : 'operations' }
SBSTableColumnGroup >> addToTable: aSBSTable [

	self table: aSBSTable.
	self components do: [ :each | each addToTable: aSBSTable]
]

{ #category : 'options' }
SBSTableColumnGroup >> applyOptionsTo: aTableHeading [

	(self hasOption: #halign) ifFalse: [self option: #halign value: 'center'].

	super applyOptionsTo: aTableHeading
]

{ #category : 'accessing' }
SBSTableColumnGroup >> columnSpan [

	^self components inject: 0 into: [ :columnSpan :each | columnSpan + each columnSpan]
]

{ #category : 'accessing' }
SBSTableColumnGroup >> components [
	^components
]

{ #category : 'accessing' }
SBSTableColumnGroup >> components: anObject [
	components := anObject
]

{ #category : 'initialize - release' }
SBSTableColumnGroup >> initialize [

	super initialize.
	self components: OrderedCollection new
]

{ #category : 'rendering' }
SBSTableColumnGroup >> renderOn: html [

	self renderTableHeading: html tableHeading.

	html tableRow: [self components do: [ :each | each renderOn: html]]
]

{ #category : 'accessing' }
SBSTableColumnGroup >> rowSpan [

	^1
]
