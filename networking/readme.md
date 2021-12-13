# Network Pentesting

* NFS (Network file sharing)


## NFS (Network file sharing)
> Network File System (NFS) is a protocol that allows the ability to transfer files between different computers and is available on many systems, including MS Windows and Linux. Consequently, NFS makes it easy to share files between various operating systems.

Scan the host with -Pn switch like this: `nmap -Pn 10.10.10.10`

You will get a service named **nfs** with port **2049**

Check the available shares using this command: `showmount -e 10.10.10.10`

You will get the list of available shares:

```
root@haqsek2$ showmount -e 10.10.10.10
Export list for 10.10.10.10:
/share        (everyone)
/admin     (noone)
/confidential  (everyone)
```

Try to mount the shares using this command: `mount 10.10.10.10:/share my_share`

If suucessful you will be able to see the contents of this share.
