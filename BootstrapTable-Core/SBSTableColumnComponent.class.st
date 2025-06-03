Class {
	#name : 'SBSTableColumnComponent',
	#superclass : 'SBSTableCoreComponent',
	#instVars : [
		'parentGroup',
		'table',
		'label'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'operations' }
SBSTableColumnComponent >> addToTable: aSBSTable [

	self subclassResponsibility
]

{ #category : 'options' }
SBSTableColumnComponent >> applyOptionsTo: aTableHeading [

	| rowSpan |

	rowSpan := self rowSpan.
	rowSpan > 1 ifTrue: [self option: #valign value: 'middle'].

	super applyOptionsTo: aTableHeading
]

{ #category : 'accessing' }
SBSTableColumnComponent >> columnSpan [

	^self subclassResponsibility
]

{ #category : 'accessing' }
SBSTableColumnComponent >> depth [

	^1 + self parentDepth
]

{ #category : 'testing' }
SBSTableColumnComponent >> hasLabel [

	^(label isNil or: [label isEmpty]) not
]

{ #category : 'accessing' }
SBSTableColumnComponent >> label [
	^label
]

{ #category : 'accessing' }
SBSTableColumnComponent >> label: anObject [
	label := anObject
]

{ #category : 'accessing' }
SBSTableColumnComponent >> parentDepth [

	^self parentGroup isNil
		ifTrue: [0]
		ifFalse: [self parentGroup depth]
]

{ #category : 'accessing' }
SBSTableColumnComponent >> parentGroup [
	^parentGroup
]

{ #category : 'accessing' }
SBSTableColumnComponent >> parentGroup: anObject [
	parentGroup := anObject
]

{ #category : 'rendering' }
SBSTableColumnComponent >> renderTableHeading: aTableHeading [

	self applyOptionsTo: aTableHeading.

	aTableHeading
		rowSpan: self rowSpan;
		colSpan: self columnSpan;
		with: self label
]

{ #category : 'accessing' }
SBSTableColumnComponent >> rowSpan [

	^self subclassResponsibility
]

{ #category : 'accessing' }
SBSTableColumnComponent >> table [
	^table
]

{ #category : 'accessing' }
SBSTableColumnComponent >> table: anObject [
	table := anObject
]

{ #category : 'options' }
SBSTableColumnComponent >> validOptions [

	"https://bootstrap-table.com/docs/api/column-options/"

	^#(
		#align
		#cardVisible
		#cellStyle
		#checkbox
		#checkboxEnabled
		#class
		#clickToSelect
		#colspan
		#detailFormatter
		#escape
		#events
		#falign
		#field
		#footerFormatter
		#footerStyle
		#formatter
		#halign
		#order
		#radio
		#rowspan
		#searchable
		#searchFormatter
		#searchHighlightFormatter
		#showSelectTitle
		#sortable
		#sorter
		#sortName
		#switchable
		#switchableLabel
		#title
		#titleTooltip
		#valign
		#visible
		#width
		#widthUnit
	)
]

{ #category : 'accessing' }
SBSTableColumnComponent >> width: anInteger [

	self option: #width value: anInteger
]
