# book

[book link](https://www.safaribooksonline.com/library/view/the-linux-command/9781593273897/ch02s04.html)

```bash
# view calendar in terminal
$ cal
# display amount of free space on your disk drives
$ df
# display the amount of free memory
$ free
```

## cd

```bash
# Changes the working directory to your home directory.
$ cd
# Changes the working directory to the previous working directory.
$ cd -
# relative pathname starts from the working directory
# you can omit the ./ because it is implied
$ cd ./bin
$ cd bin
# absolute pathname starts from root directory
$ cd /usr/bin
```

## ls

```bash
# long format and sort by modification time -t
$ ls -lt
-rw-r--r--       1            omer  staff  13042   Mar  6  2018  dotinfo
└─ type └─ perm  └─ num links              └─ size └─ last modif └─ name
# reverse list -r
$ ls -ltr
# sort by size
$ ls -lS
# list more than one dir
$ ls /etc /usr
```

## file

```bash
$ file Qt/
Qt/: directory
$ file VIA-VPNAgent
VIA-VPNAgent: Mach-O 64-bit executable x86_64
$ file updater.sh
updater.sh: ASCII text
```

## less

view text files

```bash
$ less builtins.qmltypes
```

### cat vs less

`cat` prints all the file to console where as `less` keeps file in memory and prints page by page.
`cat` can print multiple files. `less` can go back, search, etc

## Chapter 4. Manipulating Files and Directories

### Wildcards

- `*`: Any characters
- `?`: Any single character
- `[characters]`: Any character that is a member of the set characters
- `[!characters]`: Any character that is not a member of the set characters
- `[[:class:]]`: Any character that is a member of the specified class

classes
: - `[:alnum:]`Any alphanumeric character
  - `[:alpha:]`Any alphabetic character
  - `[:digit:]`Any numeral
  - `[:lower:]`Any lowercase letter
  - `[:upper:]`Any uppercase letter

| Pattern                | Matches                                                                   |
| ---------------------- | ------------------------------------------------------------------------- |
| *                      | All files                                                                 |
| g*                     | Any file beginning with g                                                 |
| b*.txt                 | Any file beginning with b followed by any characters and ending with .txt |
| Data???                | Any file beginning with Data followed by exactly three characters         |
| [abc]*                 | Any file beginning with either a, b, or c                                 |
| BACKUP.[0-9][0-9][0-9] | Any file beginning with BACKUP. followed by exactly three numerals        |
| \[[:upper:]]*          | Any file beginning with an uppercase letter                               |
| [![:digit:]]*          | Any file not beginning with a numeral                                     |
| *[[:lower:]123]        | Any file ending with a lowercase letter or the numerals 1, 2, or 3        |

```bash
$ ls .bash[!_]*
.bashrc
$ ls .bash[_]*
.bash_history .bash_profile .bash_prompt
```

### mkdir

```bash
# create multiple directories
$ mkdir dir1 dir2 dir3
$ mkdir directory...
```

### cp

`cp file1 file2`
: Copy file1 to file2. If file2 exists, it is overwritten with the contents of file1.

```bash
# copy multiple items
$ cp item... directory
$ cp -a          # copy with attributes
$ cp -i          # prompt user before overwriting
$ cp -r          # recursively copy directories
$ cp -u          # copy only files that either don’t exist or are newer
$ cp -v          # display informative messages
cp dir1/* dir2   # all the files in dir1 are copied into dir2
cp -r dir1 dir2  # cp dir1 and contents to dir2. if dir2 not exists, it is created
```

## mv

`Move file1 to file2`
: Move file1 to file2. If file2 exists, it is overwritten with the contents of file1
If file2 does not exist, it is created (rename). In either case, file1 ceases to exist.

```bash
# move one or more items from one directory to another
$ mv item... directory
$ mv -i          # prompt user before overwriting
$ mv -u          # mv only files that either don’t exist or are newer
$ mv -v          # display informative messages
```
