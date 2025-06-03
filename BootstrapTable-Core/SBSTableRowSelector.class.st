Class {
	#name : 'SBSTableRowSelector',
	#superclass : 'SBSTableSingleColumn',
	#instVars : [
		'enablementBlock'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'options' }
SBSTableRowSelector >> applyOptionsTo: aTableHeading [

	self hasLabel ifTrue: [self option: #showSelectTitle value: true].

	super applyOptionsTo: aTableHeading
]

{ #category : 'configuring' }
SBSTableRowSelector >> beMultiSelect [

	self 
		option: #checkbox value: true;
		option: #radio value: false
]

{ #category : 'configuring' }
SBSTableRowSelector >> beSingleSelect [

	self 
		option: #radio value: true;
		option: #checkbox value: false
]

{ #category : 'accessing' }
SBSTableRowSelector >> enablementBlock [

	"enablementBlock optionally stores a 1-arg block which is evaluated with a row object to determine if the check box should be enabled"

	^enablementBlock
]

{ #category : 'accessing' }
SBSTableRowSelector >> enablementBlock: anObject [

	"enablementBlock optionally stores a 1-arg block which is evaluated with a row object to determine if the check box should be enabled"

	enablementBlock := anObject
]

{ #category : 'callbacks' }
SBSTableRowSelector >> handleFormatterCallbackWith: params [

	self requestContext respond: 
		[ :response  || rowId row |
		rowId := Integer readFrom: params readStream.
		row := self table rowWithId: rowId.
		(self enablementBlock value: row)
			ifTrue: [1 displayOn: response]
			ifFalse: [0 displayOn: response]]
]

{ #category : 'testing' }
SBSTableRowSelector >> hasSubComponent [

	^false
]

{ #category : 'initialize-release' }
SBSTableRowSelector >> initialize [

	super initialize.

	self beMultiSelect
]

{ #category : 'testing' }
SBSTableRowSelector >> needsFormatterCallback [

	^self enablementBlock notNil
]

{ #category : 'rendering' }
SBSTableRowSelector >> renderFormatterScriptOn: html [

	| functionName function |
	
	functionName := self option: #formatter.
	function := JSFunction named: functionName arguments: #('value' 'row' 'index' 'field').

	function 
		add: 
			(html jQuery ajax 
				async: false; 
				callback: [ :params | self handleFormatterCallbackWith: params] value: (html javascript alias: 'row.', self table idAccessor);
				onSuccess: ('dis=(result==0)' asFunction: #('result'));
				yourself);
		returnExpression: '{disabled: dis}'.

	html script: function asJavascript
]
