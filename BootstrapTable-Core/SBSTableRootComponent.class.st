Class {
	#name : 'SBSTableRootComponent',
	#superclass : 'SBSRootComponent',
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'registration' }
SBSTableRootComponent class >> register [

	^(WAAdmin register: self asApplicationAt: self contextRoot)
		addLibrary: SBSCDNDeploymentLibrary;
		addLibrary: SBSIconsCDNDeploymentLibrary;
		addLibrary: SBSTableCDNDeploymentLibrary;
		yourself
]

{ #category : 'rendering' }
SBSTableRootComponent >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	SBSJQueryCDNDeploymentLibrary addLoadScriptTo: anHtmlRoot.
	SBSCDNDeploymentLibrary addLoadScriptTo: anHtmlRoot.
	SBSTableCDNDeploymentLibrary addLoadScriptTo: anHtmlRoot
]
