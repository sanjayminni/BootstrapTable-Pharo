"
Library required for BSTable extensions: export
"
Class {
	#name : 'SBSTableExportCDNDeploymentLibrary',
	#superclass : 'SBSCDNDeploymentLibrary',
	#category : 'BootstrapTable-Core',
	#package : 'BootstrapTable-Core'
}

{ #category : 'updating' }
SBSTableExportCDNDeploymentLibrary class >> addLoadScriptTo: html [

	super addLoadScriptTo: html.

	html script
			url: self cdnTableExportJSLocation ;
			attributeAt: 'integrity' put: self cdnTableExportJSLocationIntegrity ;
			attributeAt: 'crossorigin' put: 'anonymous'.

	html script
			url: self cdnTableExportFileSaverJSLocation ;
			attributeAt: 'integrity' put: self cdnTableExportFileSaverJSLocationIntegrity ;
			attributeAt: 'crossorigin' put: 'anonymous'.
			
	html script
			url: self cdnTableExportXlsxJSLocation ;
			attributeAt: 'integrity' put: self cdnTableExportXlsxJSLocationIntegrity ;
			attributeAt: 'crossorigin' put: 'anonymous'.
			
	html script
			url: self cdnTableExportJsPdfJSLocation ;
			attributeAt: 'integrity' put: self cdnTableExportJsPdfJSLocationIntegrity ;
			attributeAt: 'crossorigin' put: 'anonymous'.
			
	html script
			url: self cdnTableExportPngJSLocation ;
			attributeAt: 'integrity' put: self cdnTableExportPngJSLocationIntegrity ;
			attributeAt: 'crossorigin' put: 'anonymous'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> bsTableExportVersion [

	^ '1.33.0'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnJSLocation [

	^'https://cdn.jsdelivr.net/npm/bootstrap-table@<1s>/dist/extensions/export/bootstrap-table-export.min.js' expandMacrosWith: SBSTableCDNDeploymentLibrary bsTableVersion
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-7r09ZDpaLqN4L3r6yF8GyAhZewpJIecqz6cN9M100QV+XX6obZ86FsTmXH6J0gc+'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportFileSaverJSLocation [

	^'https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@<1s>/libs/FileSaver/FileSaver.min.js' expandMacrosWith: self bsTableExportVersion
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportFileSaverJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-PamoNBxpunDiGkGPpNOdOldeH2wH+1cMDhuROZWqjMjU5WXTA5jzhOCiyHmr3LAK'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportJSLocation [

	^'https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@<1s>/tableExport.min.js' expandMacrosWith: self bsTableExportVersion
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-3LDdQ3LnyJi2ZVTV1s4dCLCkXmjZ8w9H+nqLrRCByZGg5fphTgzGpQ0bG8wImjIL'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportJsPdfJSLocation [

	^'https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@<1s>/libs/jsPDF/jspdf.umd.min.js' expandMacrosWith: self bsTableExportVersion
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportJsPdfJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-15uoZT5zN6lseew0GeeAygJQoFCwK/ZzDGIsQag3BmLoWPik5wQ/+BW9YduMQhEX'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportPngJSLocation [

	^'https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@<1s>/libs/html2canvas/html2canvas.min.js' expandMacrosWith: self bsTableExportVersion
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportPngJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-ZHqoDSJdE8wpN2damqZOsmgOoQsACQe+po725aR/V69WwwpZoHoJtAChKh1Yg40Y'
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportXlsxJSLocation [

	^'https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@<1s>/libs/js-xlsx/xlsx.core.min.js' expandMacrosWith: self bsTableExportVersion
]

{ #category : 'accessing - defaults' }
SBSTableExportCDNDeploymentLibrary class >> cdnTableExportXlsxJSLocationIntegrity [
	"Calculated via https://www.srihash.org"

	^ 'sha384-os4CuJl3LYH4Rv9fIPMaMwFD2nj6cCJMkhAnPpcB48I49sYxQ9g63E6aKyxMWFK8'
]
