Class {
	#name : 'SBSTableExampleProduct',
	#superclass : 'Object',
	#instVars : [
		'id',
		'name',
		'price',
		'inStock'
	],
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'instance creation' }
SBSTableExampleProduct class >> new [

	^super new
		inStock: true;
		yourself
]

{ #category : 'testing' }
SBSTableExampleProduct >> hasName [

	^name notNil and: [name notEmpty]
]

{ #category : 'testing' }
SBSTableExampleProduct >> hasPrice [

	^price notNil
]

{ #category : 'accessing' }
SBSTableExampleProduct >> id [
	^id
]

{ #category : 'accessing' }
SBSTableExampleProduct >> id: anObject [
	id := anObject
]

{ #category : 'accessing' }
SBSTableExampleProduct >> inStock [
	^inStock
]

{ #category : 'accessing' }
SBSTableExampleProduct >> inStock: anObject [
	inStock := anObject
]

{ #category : 'testing' }
SBSTableExampleProduct >> isValid [

	^self hasName and: [self hasPrice]
]

{ #category : 'accessing' }
SBSTableExampleProduct >> name [
	^name
]

{ #category : 'accessing' }
SBSTableExampleProduct >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
SBSTableExampleProduct >> price [
	^price
]

{ #category : 'accessing' }
SBSTableExampleProduct >> price: anObject [
	price := anObject
]
