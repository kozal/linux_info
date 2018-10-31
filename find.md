# Find

Searches the directory tree rooted at each given starting-point by evaluating the given expression from left to right.

The `find` command is only able to **filter** the directory hierarchy **based on a file’s name and meta data**. **If** you need to search based on the **content** of the file, **use** a tool like `grep`.

```bash
find [paths] [expression] [actions]
# discard error messages
find [paths] [expression] [actions] 2>/dev/null
```

- search is **recursive**
- default path is the current directory = `.`
- default expression is `-print`
- default is exact name in `-name` option, use wildcards

```bash
# list all files below current dir (including subdirs)
$ find .
# find in a specific subdir and subdirs
$ find ./workspace/
# find in multiple dirs
$ find ./test ./dir2 -type f -name "abc*"
```

## name

default: search for exact filename

`-iname`
: case insensitive

```bash
# no result because of partial filename
$ find . -name "armcc"

# single or double quotes are OK
$ find . -name "armcc.exe"
./bin/armcc.exe

$ find . -name 'armcc.exe'
./bin/armcc.exe

# using no argument lists all the files recursively in current dir
$ find| grep armcc
./bin/armcc.exe
```

the file names considered for a match with -name will never include a slash, use `-path`.
```bash
# wrong
$ find . -name 'bin/arm*.exe'
find: warning
# true
$ find ./bin -name 'armar.exe'
./bin/armar.exe
```

### wildcards

wildcards are supported for `-name` option

```bash
# search for files start with "Screen"
$ find . -type f -name "Screen*"
./Screen Shot 2018-02-27 at 23.50.00.png
```

## type

```bash
# list only dirs
$ find . -type d
# list only files
$ find . -type f
```

| option | type                           |
| ------ | ------------------------------ |
| b      | block (buffered) special       |
| c      | character (unbuffered) special |
| d      | directory                      |
| p      | named pipe (FIFO)              |
| f      | regular file                   |
| l      | symbolic link                  |
| s      | socket                         |

## operators

```bash
# expr1 -o expr2 = expr1 -or expr2 : or
$ find . -name 'armar.exe' -o -name 'armcc.exe'
./bin/armar.exe
./bin/armcc.exe

# expr1 -a expr2 = expr1 -and expr2 : and
$ find . -name 'armar.exe' -a -perm 755
./bin/armar.exe

# expr1 expr2 : same as and
$ find . -name 'armar.exe' -perm 755
./bin/armar.exe

# -not expr = ! expr: not
$ find ./bin -not -type f
./bin
```

## permissions

```bash
$ find . -perm 777
$ find . -perm 644
```

find all files and directories on the system with the permission `r-xr-xr-x`

```bash
$ find /usr -perm a=rx
```

if we only care about execute permission bit, add a `/` in front to indicate that we intend to match a subset of permissions.

```bash
$ find / -type f -perm /a=x
```
## `-print` vs `-print0`

-print0
: print the full file name on the standard output,
        followed by a null character (instead of the newline character that `-print` uses).

```bash
# default option is -print. no need to write
$ find . -name 'arm*.exe'
./bin/armar.exe
./bin/armasm.exe

# -print0: no newline
$ find . -name 'arm*.exe' -print0
./bin/armar.exe./bin/armasm.exe
```

## maxdepth

levels of directories below the starting-points. 
`-maxdepth 0` means only apply the tests and actions to the starting-points themselves

place `-maxdepth` option after the `-path`

```bash
# find dot files in current dir
$ find . -name ".*" -maxdepth 1

$ find . -maxdepth 1 -name 'armar.exe'

$ find . -maxdepth 2 -name 'armar.exe'
./bin/armar.exe
```

## examples

- Search file modified

```bash
# modified in last 10 minutes
$ find . -type f -mmin -10
./find/find.md

# modified more than 10 minutes ago
$ find . -type f -mmin -10
./.aliases
./.bash_prompt
...

# modified more than 2 mins, less than 10 mins
$ find . -type f -mmin +2 -mmin -10
./find/find.md

# modified more than 10 days, less than 12 days
$ find . -type f -mtime +10 -mtime -12
./screen ShotwinUbn.png
```

- Search file accessed and changed
```bash
# accessed more than 2 mins, less than 10 mins
$ find . -type f -amin +2 -amin -10
./find/find.md

# changed more than 10 days, less than 12 days
$ find . -type f -mtime +10 -mtime -12
./screen ShotwinUbn.png
```

- Search with file size
`k`: Kilobytes, `M`: Megabytes, `G`: Gigabytes
```bash
# find 50000 bytes < size < 100 kilobytes
$ find . -size +50000c -size -100k
./grep.pdf
```

- Search empty files
```bash
cd ..
$ find . -empty
./.849C9593-D756-4E56-8D6E-42412F2A707B
./c/.sublime
./python/img_prc_src/gui_tkinter/__init__.py
```

- Executing command on results
  - Change permission
```bash
# normally
$ chmod 444 .bashrc.save
# using output of find
# use {} as placeholder of filename
# end the command with '+' or '\;'
# find all files under pwd with perm = 0, change perm to 444
$ find . -perm 0 -exec chmod 444 {} +
```

- Executing command on results
  - remove files
  
first check the results
```bash
# find jpg files in this dir
$ find . -maxdepth 1 -type f -name "*.jpg"
./dummy.jpg
# now delete files
$ find . -maxdepth 1 -type f -name "*.jpg" -exec rm {} +
```
