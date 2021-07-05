# ASLR and DEP Protection

>ASLR => Address Space Layout Randomization
>, DEP => Data Execution Prevention

## Method
* Download PESecurity from [here](https://github.com/NetSPI/PESecurity)
* Open Power Shell as administrator
* Lower the permission of this terminal by running the following command: `Set-ExecutionPolicy Bypass -Scope Process`
* Import the module in power shell using this command: `Import-Module .\Get-PESecurity.psm1`
* Run the following command: `Get-PESecurity -directory 'C:\path-to-application-directory\' -recursive`
* Observer the ASLR and DEP status False in the result.

## Impact:
* ASLR ensures that every time an application is loaded into memory it is randomly loaded into a different memory address, preventing an exploit from capitalizing on a predictable memory location. 
* DEP performs additional checks on memory to help prevent malicious code from running on a system.


