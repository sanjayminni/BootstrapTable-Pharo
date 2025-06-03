Class {
	#name : 'SBSTableCoreComponent',
	#superclass : 'SBSComponent',
	#instVars : [
		'id',
		'options'
	],
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'options' }
SBSTableCoreComponent >> applyOptionsTo: aTag [

	options keysAndValuesDo: [ :option :value | aTag attributeAt: option asHtmlTagDataAttribute put: value displayString].
]

{ #category : 'accessing' }
SBSTableCoreComponent >> columnSpan [

	^1
]

{ #category : 'options' }
SBSTableCoreComponent >> hasOption: aSymbol [

	^options includesKey: aSymbol
]

{ #category : 'accessing' }
SBSTableCoreComponent >> id [
	^id
]

{ #category : 'accessing' }
SBSTableCoreComponent >> id: anObject [
	id := anObject
]

{ #category : 'accessing' }
SBSTableCoreComponent >> idOn: html [
	^id ifNil: [id := html nextId]
]

{ #category : 'initialize-release' }
SBSTableCoreComponent >> initialize [

	super initialize.

	self resetOptions
]

{ #category : 'options' }
SBSTableCoreComponent >> isOption: aSymbol [

	"Convenience tester for boolean options"

	^self isOption: aSymbol default: false
]

{ #category : 'options' }
SBSTableCoreComponent >> isOption: aSymbol default: aBoolean [

	"Convenience tester for boolean options"

	^self option: aSymbol default: aBoolean
]

{ #category : 'options' }
SBSTableCoreComponent >> option: aSymbol [

	^self option: aSymbol default: nil
]

{ #category : 'options' }
SBSTableCoreComponent >> option: aSymbol default: defaultValue [

	^options at: aSymbol ifAbsent: [defaultValue]
]

{ #category : 'options' }
SBSTableCoreComponent >> option: aSymbol value: anObject [

	(self validOptions includes: aSymbol) ifFalse: [Notification signal: ('unknown <1s> option <2p>' expandMacrosWith: {self class name. aSymbol})].

	anObject isNil 
		ifTrue: [options removeKey: aSymbol ifAbsent: []]
		ifFalse: [options at: aSymbol put: anObject]
]

{ #category : 'options' }
SBSTableCoreComponent >> options: aCollection value: anObject [

	aCollection do: [ :each | self option: each value: anObject]
]

{ #category : 'options' }
SBSTableCoreComponent >> resetOptions [

	options := IdentityDictionary new.
	self setDefaultOptions
]

{ #category : 'options' }
SBSTableCoreComponent >> setDefaultOptions [
]

{ #category : 'options' }
SBSTableCoreComponent >> validOptions [

	^#()
]
