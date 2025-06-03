Class {
	#name : 'SBSBootstrapDetailComponentExample',
	#superclass : 'SBSTableSubComponent',
	#category : 'BootstrapTable-Examples',
	#package : 'BootstrapTable-Examples'
}

{ #category : 'rendering' }
SBSBootstrapDetailComponentExample >> renderContentOn: html [

	html code: 
		[| instVarNames |
		html strong: self model displayString.

		instVarNames := self model class allInstVarNames.
		1 to: instVarNames size do: 
			[ :index |
			html 
				break;
				code: [html strong: (instVarNames at: index); text: ': ', (self model instVarAt: index) displayString]]].

	html break.
	html anchor
		url: 'javascript:void(0)';
		onClick: (html jQuery ajax callback: [self model inspect]);
		with: 'Inspect It'
]
