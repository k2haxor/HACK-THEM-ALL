# Check for Unsigned Binaries

## Method

* Open Power Shell
* Execute the following commands after nevigating to installation directory of the application.
* ```Get-AuthenticodeSignature *.dll,./**/*.dll``` 

OR

* ```Get-AuthenticodeSignature *.exe,./**/*.exe```

## Impact
Unsigned binaries can modified/replaced without the end user being aware.

## Remediation
Sign all the binaries in application to ensure protection against tempaering attacks
