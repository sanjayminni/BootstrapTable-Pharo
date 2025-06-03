Class {
	#name : 'SBSTableSubComponent',
	#superclass : 'SBSComponent',
	#instVars : [
		'model',
		'table',
		'column'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'accessing' }
SBSTableSubComponent >> column [
	^column
]

{ #category : 'accessing' }
SBSTableSubComponent >> column: anObject [
	column := anObject.
	self table: column table
]

{ #category : 'accessing' }
SBSTableSubComponent >> model [
	^model
]

{ #category : 'accessing' }
SBSTableSubComponent >> model: anObject [
	model := anObject
]

{ #category : 'accessing' }
SBSTableSubComponent >> table [
	^table
]

{ #category : 'accessing' }
SBSTableSubComponent >> table: anObject [
	table := anObject
]
