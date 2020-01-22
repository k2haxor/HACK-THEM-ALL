# PHP type juggling

In PHP you can compare two variables using these two methods.
 * Loose comparison ('==' or '!=')
 * Strict comparison ('===' or !==)

## Type juggling
PHP has a feature called “type juggling”, or “type coercion”. This means that during the comparison of variables of different types, PHP will first convert them to a common, comparable type.


### Mitigation

**Loose comparison**
```
$var1 = 7
$var2 = “7”
if ($example_int == $example_str) {
   echo("PHP can compare ints and strings.")
}
```
**Strict Comparison**
```
$var1 = 7
$var2 = “7”
if ($example_int === $example_str) {
   echo("This will return error.")
}
```
## True Statements
```
'123'  == 123  # true
'123a' == 123  # true
'' == 0        # true
0  == false    # true
false == NULL  # true
NULL == ''     # true
```
```
var_dump('0010e2'   == '1e3');           # true
var_dump('0xABCdef' == ' 0xABCdef');     # true 
var_dump('0xABCdef' == '     0xABCdef'); # true 
var_dump('0x01'     == 1)                # true 
var_dump('0x1234Ab' == '1193131');
```

## Magic Hashes
If the hash starts with 0 or 0e and only followed by numbers, then PHP will treat the hash as float.

### Exploit
![Magic Hashes](https://raw.githubusercontent.com/k2decompiler/php-type-juggling/master/Screenshot%20from%202020-01-22%2005-19-20.png)
```
var_dump(md5('240610708') == md5('QNKCDZO'));   # bool(true)
var_dump(md5('aabg7XSs')  == md5('aabC9RqS'));  # bool(true)
var_dump(sha1('aaroZmOk') == sha1('aaK1STfY')); # bool(true)
var_dump(sha1('aaO8zKZF') == sha1('aa3OFF9m')); # bool(true)
```

### References
* [Payloadsallthethings](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Type%20Juggling)
* [Magic Hashes - WhieHatSec](https://www.whitehatsec.com/blog/magic-hashes/)
