Class {
	#name : 'SBSJQueryCDNDeploymentLibrary',
	#superclass : 'SBSCDNDeploymentLibrary',
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'accessing - defaults' }
SBSJQueryCDNDeploymentLibrary class >> cdnJSLocation [

	^'https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js'
]

{ #category : 'accessing - defaults' }
SBSJQueryCDNDeploymentLibrary class >> cdnJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-1H217gwSVyLSIfaLxHbE7dRb3v4mYCKbpQvzx0cegeju1MVsGrX5xXxAvs/HgeFs'
]
