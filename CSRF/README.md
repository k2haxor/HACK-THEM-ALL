# CSRF(Cross Site Request Forgery)
>Cross-Site Request Forgery (CSRF) is a type of attack that occurs when a malicious web site, email, blog, instant message, or program causes a user’s web browser to perform an unwanted action on a trusted site when the user is authenticated.

![CSRF Method](https://raw.githubusercontent.com/k2haxor/HACK-THEM-ALL/master/CSRF/CSRF-CheatSheet.png)

## Exploit
When you are logged in to a certain site, you typically have a session. The identifier of that session is stored in a cookie in your browser, and is sent with every request to that site. Even if some other site triggers a request, the cookie is sent along with the request and the request is handled as if the logged in user performed it.
