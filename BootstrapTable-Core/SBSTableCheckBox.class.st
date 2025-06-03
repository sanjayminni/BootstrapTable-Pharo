Class {
	#name : 'SBSTableCheckBox',
	#superclass : 'SBSTableSubComponent',
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'rendering' }
SBSTableCheckBox >> renderContentOn: html [

	html checkbox 
		disabled: true;
		value: (self column contentFromRow: self model)
]
