Class {
	#name : 'SBSIconsCDNDeploymentLibrary',
	#superclass : 'SBSCDNDeploymentLibrary',
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'accessing - defaults' }
SBSIconsCDNDeploymentLibrary class >> addLoadScriptTo: html [

	"No load script for icons"
]

{ #category : 'accessing - defaults' }
SBSIconsCDNDeploymentLibrary class >> cdnCSSLocation [

	^'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css'
]

{ #category : 'accessing - defaults' }
SBSIconsCDNDeploymentLibrary class >> cdnCSSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD'
]
