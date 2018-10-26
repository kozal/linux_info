#

## backup a file

```bash
$ cp filename{,.bak}
$ cp filename filename.bak
```

```bash
$ ls
foo
$ cp foo{,.bak}     # expands to `cp foo foo.bak`
$ ls
foo foo.bak
```
