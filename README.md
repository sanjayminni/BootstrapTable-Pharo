# BootstrapTable-Pharo
A [Seaside](https://github.com/seasidest/seaside) component for [Pharo](https://pharo.org/) wrapping [Bootstrap Table](https://bootstrap-table.com/).

## Getting Started
* Install [Pharo](https://pharo.org/) (currently tested with Pharo 12)

## Installation
* Evaluate:
```smalltalk
Metacello new
    repository: 'github://rko281/BootstrapTable-Pharo:main';
    baseline: 'BootstrapTable';
    load: 'all'
```
* All required packages and prerequisites (including [Seaside](https://github.com/seasidest/seaside) and [Seaside-Bootstrap5](https://github.com/astares/Seaside-Bootstrap5)) will be downloaded and installed.

## Run
Start the web server for [Seaside](http://www.seaside.st) - for instance with Zinc evaluate
```Smalltalk
ZnZincServerAdaptor startOn: 8080.
WebBrowser openOn: 'http://localhost:8080/bootstrap-table/'
```

## Examples
The examples browser demonstrates most of the wrapped behavior including a simple example application:

![image](https://github.com/user-attachments/assets/4889b4b4-02c1-401f-8e4f-4694437319fc)

Browse `SBSBootstrapTableExample` and its subclasses for more information.
