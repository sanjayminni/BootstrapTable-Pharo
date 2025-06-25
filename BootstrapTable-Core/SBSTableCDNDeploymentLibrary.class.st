Class {
	#name : 'SBSTableCDNDeploymentLibrary',
	#superclass : 'SBSCDNDeploymentLibrary',
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'accessing - defaults' }
SBSTableCDNDeploymentLibrary class >> bsTableVersion [

	^ '1.24.1'
]

{ #category : 'accessing - defaults' }
SBSTableCDNDeploymentLibrary class >> cdnCSSLocation [

	^'https://cdn.jsdelivr.net/npm/bootstrap-table@{1}/dist/bootstrap-table.min.css' format: { self bsTableVersion } 
]

{ #category : 'accessing - defaults' }
SBSTableCDNDeploymentLibrary class >> cdnCSSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-tfNXB2/2SVNPdzoqPNMSl0hXmUVBnwOL4odQANKVfu66tA4jFcF+5Ch4nu1LtZAc'
]

{ #category : 'accessing - defaults' }
SBSTableCDNDeploymentLibrary class >> cdnJSLocation [

	^'https://cdn.jsdelivr.net/npm/bootstrap-table@{1}/dist/bootstrap-table.min.js' format: { self bsTableVersion }
]

{ #category : 'accessing - defaults' }
SBSTableCDNDeploymentLibrary class >> cdnJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-FosO0uRIBBE+YnU4QBFaUk9aMjP2twHyeirpW+jjfqBlKU1Kp576zfju1cWNkx3g'
]
