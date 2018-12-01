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

> notice number of links decreased when a hard  link is deleted.

```bash
$ ls -lAFh
total 16K
# ...
-rw-r--r-- 4 omer omer 2,3K Kas 29 23:37 fun
-rw-r--r-- 4 omer omer 2,3K Kas 29 23:37 fun-hard
$ rm fun-hard
$ ls -lAFh
total 12K
# ...
-rw-r--r-- 3 omer omer 2,3K Kas 29 23:37 fun
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
$ cp -a          # --archive: copy with attributes
$ cp -i          # --interactive: prompt user before overwriting
$ cp -r          # --recursive: recursively copy directories
$ cp -u          # --update: copy only files that either don’t exist or are newer
$ cp -v          # --verbose: display informative messages

$ cp dir1/* dir2   # all the files in dir1 are copied into dir2
$ cp -r dir1 dir2  # cp dir1 and contents to dir2. if dir2 not exists, it is created
```

### mv

`mv file1 file2`
: Move file1 to file2. If file2 exists, it is overwritten with the contents of file1
If file2 does not exist, it is created (rename). In either case, file1 ceases to exist.

```bash
# move one or more items from one directory to another
$ mv item... directory
$ mv -i          # --interactive: prompt user before overwriting
$ mv -u          # --update: mv only files that either don’t exist or are newer
$ mv -v          # --verbose: display informative messages

$ mv file1 file2 dir1 # Move file1 and file2 into dir1. dir1 must already exist
$ mv dir1 dir2  # Move dir1 and contents) into dir2.  if dir2 not exists, it is created
```

### rm

> Unix-like operating systems such as Linux do not have an undelete command
> Whenever you use wildcards with `rm` (besides carefully checking your typing!), **test the wildcard first** with ls

`rm item...`
: remove (delete) files and directories

```bash
$ rm item...
$ rm *.html

$ rm -i          # --interactive: prompt user before deleting
$ rm -r          # --recursive: to delete directories
$ rm -f          # --force: Ignore nonexistent files and do not prompt. overrides -i
$ rm -v          # --verbose: display informative messages

$ rm -r file1 dir1 # Delete file1 and dir1 and its contents
```

### ln

`ln file link`
: create either hard or symbolic links

```bash
# create a hard link
$ ln file link
# create a symbolic link, item is either a file or a directory
$ ln -s item link
```

#### Hard Links

- A hard link cannot reference a file outside its own filesystem. This means a link cannot reference a file that is not on the same disk partition as the link itself.
- A hard link cannot reference a directory.

By default, every file has a single hard link that gives the file its name\
A hard link is indistinguishable from the file itself.

```bash
$ ls -F                 # -F: indicator char
dir1/  dir2/  fun
$ ln fun fun-hard
$ ln fun dir1/fun-hard
$ ln fun dir2/fun-hard

# no indicator if hard link is same with file
$ ls -l
total 16
drwxrwxr-x 2 omer omer 4096 Kas 29 23:42 dir1
drwxrwxr-x 2 omer omer 4096 Kas 29 23:42 dir2
-rw-r--r-- 4 omer omer 2330 Kas 29 23:37 fun
-rw-r--r-- 4 omer omer 2330 Kas 29 23:37 fun-hard

# files have same inode: 1312694
$ ls -li
total 16
1312692 drwxrwxr-x 2 omer omer 4096 Kas 29 23:42 dir1
1312693 drwxrwxr-x 2 omer omer 4096 Kas 29 23:42 dir2
1312694 -rw-r--r-- 4 omer omer 2330 Kas 29 23:37 fun
1312694 -rw-r--r-- 4 omer omer 2330 Kas 29 23:37 fun-hard
```

#### Symbolic Links

Were created to overcome the limitations of hard links.

Symbolic links work by creating a special type of file that contains a text pointer to the referenced file or directory (like ahortcut).

if you write something to the symbolic link, the referenced file is also written to. However, when you delete a symbolic link, only the link is deleted, not the file itself.

If the file is deleted before the symbolic link, the link will continue to exist but will point to nothing. In this case, the link is said to be broken.

Remember, when we create a symbolic link, we are creating a **text description of where the target file is relative to the symbolic link**.

When creating symbolic links, you can use either absolute pathnames

```bash
$ ln -s fun fun-sym
$ ln -s ../fun dir1/fun-sym
$ ls -lF dir1/
total 4
-rw-r--r-- 4 omer omer 2330 Kas 29 23:37 fun-hard
lrwxrwxrwx 1 omer omer    6 Ara  1 12:07 fun-sym -> ../fun

# force for a new link with absolute path
$ ln -sf /home/me/playground/fun dir1/fun-sym
$ ls -lFh dir1/
total 4,0K
-rw-r--r-- 4 omer omer 2,3K Kas 29 23:37 fun-hard
lrwxrwxrwx 1 omer omer   23 Ara  1 12:14 fun-sym -> /home/me/playground/fun
```

> when ls -l
> starting char is `l` in `lrwxrwxrwx`
> length is 6 bytes, num chars in `../fun`
> and point notation in the end `-> ../fun` after file name

In addition to regular files, symbolic links can also reference directories:

```bash
$ ln -s dir1 dir1-sym
$ ll
total 16K
drwxrwxr-x 2 omer omer 4,0K Ara  1 12:14 dir1/
lrwxrwxrwx 1 omer omer    4 Ara  1 12:24 dir1-sym -> dir1/
# ...
```

> when file is deleted, the lik is broken. the color changes if ls is colored.

```bash
$ ls -lAFh
# ...
-rw-r--r-- 3 omer omer 2,3K Kas 29 23:37 fun
lrwxrwxrwx 1 omer omer    3 Ara  1 12:07 fun-sym -> fun
$ rm fun
$ ls -lAFh
# ...
lrwxrwxrwx 1 omer omer    3 Ara  1 12:07 fun-sym -> fun
```

## Chapter 5. Working with Commands

https://www.safaribooksonline.com/library/view/the-linux-command/9781593273897/ch05.html
