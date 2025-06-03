Class {
	#name : 'SBSTableExampleProductEditor',
	#superclass : 'SBSTableSubComponent',
	#instVars : [
		'fields'
	],
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'accessing' }
SBSTableExampleProductEditor >> fieldAt: aSymbol [

	^fields at: aSymbol
]

{ #category : 'accessing' }
SBSTableExampleProductEditor >> fieldAt: aSymbol put: aString [

	fields at: aSymbol put: aString asSymbol
]

{ #category : 'operations' }
SBSTableExampleProductEditor >> loadFieldsWith: script [

	script << (script jQuery: (self fieldAt: #name)) value: self model name.
	script << (script jQuery: (self fieldAt: #price)) value: self model price greaseString.
	script << (script jQuery: (self fieldAt: #inStockResult)) value: self model inStock displayString.
	script << (script jQuery: (self fieldAt: #inStock)) propertyAt: #checked put: self model inStock.

	script << ((script jQuery: (self fieldAt: #name)) call: 'focus')
]

{ #category : 'rendering' }
SBSTableExampleProductEditor >> renderContentOn: html [

	fields := IdentityDictionary new.

	html form 
		script: (html jQuery ajax script: [ :script | self loadFieldsWith: script]);
		onSubmit: (html javascript return: false);
		with: 
			[html formGroup
					marginBottom: 3;
					with: 
						[html label: 'Item Name:'.
						self fieldAt: #name put: 
							(html textInput 
								formControl;
								required;
								callback: [ :val | self model name: val];
								placeholder: 'Enter Product Name';
								ensureId)].
			html formGroup
					marginBottom: 3;
					with: 
						[html label: 'Price'.
						self fieldAt: #price put: 
							(html textInput
								formControl;
								required;
								callback: [ :val | self model price: (val asNumber asScaledDecimal: 2)];
								placeholder: '0.00';
								ensureId)].

				html formGroup 
					marginBottom: 3;
					formCheck; 
					with: 
						[| checkbox |
						self fieldAt: #inStockResult put: 
							(html textInput 
								attributeAt: #hidden put: true;
								formControl;
								callback: [ :val | self model inStock: (val = 'true')];
								ensureId).
						checkbox := html formCheckbox.
						self fieldAt: #inStock put: checkbox ensureId.
						checkbox onChange: ('document.getElementById(''',(self fieldAt: #inStockResult),''').value = document.getElementById(''',(self fieldAt: #inStock),''').checked ? ''true'' : ''false''').
						html formCheckLabel 
							for: (self fieldAt: #inStock); 
							with: 'In stock?'].

			html formButton
					beSecondary;
					onClick: (html jQuery ajax script: [ :script | self loadFieldsWith: script]);
					with: 'Cancel'.
			
			html formButton
					bePrimary;
					onClick: (html jQuery ajax serializeForm; script: [ :script | script << (self table updateRow: self model)]);
					with: 'Save']
]
