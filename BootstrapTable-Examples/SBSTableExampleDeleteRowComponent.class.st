Class {
	#name : 'SBSTableExampleDeleteRowComponent',
	#superclass : 'SBSTableSubComponent',
	#instVars : [
		'hostApplication'
	],
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSTableExampleDeleteRowComponent >> hostApplication [
	^hostApplication
]

{ #category : 'accessing' }
SBSTableExampleDeleteRowComponent >> hostApplication: anObject [
	hostApplication := anObject
]

{ #category : 'rendering' }
SBSTableExampleDeleteRowComponent >> renderContentOn: html [

	html anchor
		url: 'javascript:void(0)';
		onClick: (html jQuery ajax script: [ :script | script << (self hostApplication remove: self model)]);
		with: [html html: '<i class="bi bi-trash3"></i>']
]
