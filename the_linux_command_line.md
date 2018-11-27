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

## cat vs less

`cat` prints all the file to console where as `less` keeps file in memory and prints page by page.
`cat` can print multiple files. `less` can go back, search, etc
