- examples
```bash
# find dot files in current dir
$ find . -name ".*" -maxdepth 1
```


- list all files below current dir (including subdirs)
```bash
# find in current dir and subdirs
$ find .
# find in a specific subdir and subdirs
$ find ./workspace/
```

- list all files in current dir excluding subdirs
```bash
# find only in current dir not in subdirs
$ find . -maxdepth 1
# find in a specific subdir and subdirs
$ find ./workspace/
```


- list all dir names or file names below current dir
```bash
# list only dirs
find . -type d
# list only files
find . -type f
```

- Search for filename
```bash
# search for exact filename
$ find . -type f -name "memo.txt"
./grep/memo.txt
 
# search for files start with "Screen"
$ find . -type f -name "Screen*"
./Screen Shot 2018-02-27 at 23.50.00.png

# search filename case insensitive 
$ find . -type f -iname "Screen*"
./Screen Shot 2018-02-27 at 23.50.00.png
./screen ShotwinUbn.png

# search file extension case insensitive
$ find . -type f -name "*.txt"
./find/find.md
./grep/memo.txt
./grep/Personel/emails.txt
./links.txt
```

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

- Search based on permissions
`rwx`
```bash
$ find . -perm 777
$ find . -perm 644
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

- 
    - remove files
first check the results
```bash
# find jpg files in this dir
$ find . -maxdepth 1 -type f -name "*.jpg"
./dummy.jpg
# now delete files
$ find . -maxdepth 1 -type f -name "*.jpg" -exec rm {} +
```
