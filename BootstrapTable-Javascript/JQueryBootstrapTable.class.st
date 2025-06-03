Class {
	#name : 'JQueryBootstrapTable',
	#superclass : 'JQueryInstance',
	#category : 'BootstrapTable-Javascript',
	#package : 'BootstrapTable-Javascript'
}

{ #category : 'actions' }
JQueryBootstrapTable >> append: aDictionary [

	^self callMethod: 'append' with: (JSStream on: aDictionary asJson)
]

{ #category : 'private' }
JQueryBootstrapTable >> callMethod: aString [

	^self call: 'bootstrapTable' with: aString
]

{ #category : 'private' }
JQueryBootstrapTable >> callMethod: aString with: arg [

	^self call: 'bootstrapTable' with: aString with: arg
]

{ #category : 'actions' }
JQueryBootstrapTable >> collapseAll [

	^self callMethod: 'collapseAllRows'
]

{ #category : 'actions' }
JQueryBootstrapTable >> collapseRow: anInteger [

	^self callMethod: 'collapaseRow' with: anInteger - 1
]

{ #category : 'actions' }
JQueryBootstrapTable >> collapseRowByUniqueId: anInteger [

	^self callMethod: 'collapseRowByUniqueId' with: anInteger
]

{ #category : 'accessing' }
JQueryBootstrapTable >> data [

	^self callMethod: 'getData'
]

{ #category : 'actions' }
JQueryBootstrapTable >> expandRow: anInteger [

	^self callMethod: 'expandRow' with: anInteger - 1
]

{ #category : 'actions' }
JQueryBootstrapTable >> expandRowByUniqueId: anInteger [

	^self callMethod: 'expandRowByUniqueId' with: anInteger
]

{ #category : 'testing' }
JQueryBootstrapTable >> hasNotSingleSelection [

	"Implemented due to apparent issue when 'not' applied to hasSingleSelection test"

	^self selections access: 'length!=1'
]

{ #category : 'testing' }
JQueryBootstrapTable >> hasSelection [

	^self selections access: 'length>0'
]

{ #category : 'testing' }
JQueryBootstrapTable >> hasSingleSelection [

	^self selections access: 'length==1'
]

{ #category : 'actions' }
JQueryBootstrapTable >> insertRow: aDictionary at: anInteger [

	| params |

	params := 
		Dictionary new
			at: #index put: anInteger - 1;
			at: #row put: aDictionary;
			yourself.

	^self callMethod: 'insertRow' with: (JSStream on: params asJson)
]

{ #category : 'actions' }
JQueryBootstrapTable >> nextPage [

	^self callMethod: 'nextPage'
]

{ #category : 'actions' }
JQueryBootstrapTable >> previousPage [

	^self callMethod: 'prevPage'
]

{ #category : 'actions' }
JQueryBootstrapTable >> refresh [

	^self callMethod: 'refresh'
]

{ #category : 'actions' }
JQueryBootstrapTable >> refreshSelectingPage: anInteger [

	^self callMethod: 'refresh' with: (JSStream on: '{pageNumber:', anInteger displayString, '}')
]

{ #category : 'actions' }
JQueryBootstrapTable >> remove: aDictionary [

	^self callMethod: 'remove' with: (JSStream on: aDictionary asJson)
]

{ #category : 'actions' }
JQueryBootstrapTable >> removeAll [

	^self callMethod: 'removeAll'
]

{ #category : 'actions' }
JQueryBootstrapTable >> resetSearch [

	^self callMethod: 'resetSearch'
]

{ #category : 'actions' }
JQueryBootstrapTable >> selectIndex: anInteger [

	^self callMethod: 'check' with: anInteger - 1
]

{ #category : 'actions' }
JQueryBootstrapTable >> selectPage: anInteger [

	^self callMethod: 'selectPage' with: anInteger
]

{ #category : 'accessing' }
JQueryBootstrapTable >> selections [

	^self callMethod: 'getSelections'
]

{ #category : 'actions' }
JQueryBootstrapTable >> unselectAll [

	^self callMethod: 'uncheckAll'
]

{ #category : 'actions' }
JQueryBootstrapTable >> updateRow: aDictionary [

	^self callMethod: 'updateRow' with: (JSStream on: aDictionary asJson)
]
