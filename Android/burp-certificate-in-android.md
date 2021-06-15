# Export your Burp Certificate
* Proxy > Options > CA Certificate > Export in DER format

* Convert it to PEM
`openssl x509 -inform der -in cacert.der -out burp.pem`

* Download it on the device 

* Use Certificate Installer to install the certificate


The Android app to install certificate can be found [here](https://play.google.com/store/apps/details?id=it.nicola_amatucci.android.certificate_installer)

OR

Move this cert to this dir `/etc/security/cacerts/` and change the permission `chmod 644 cert_name.0`
