# Shell notes

## environment

### path

```bash
$ echo $PATH
# from alias
$ path

# add to end of PATH
$ export PATH=$PATH:directory
$ PATH=$PATH:$HOME/bin
# add to start of PATH
$ PATH="$HOME/bin:$HOME/.local/bin:$PATH
```

### shell files

A **login shell** session is one in which we are prompted for our user name and password; when we start a virtual console session.

| File            | Contents                                                  |
| --------------- | ----------------------------------------------------------|
| /etc/profile    | A global configuration script that applies to all users.<br> *employs /etc/bash.bashrc and files in /etc/profile.d*|
| ~/.bash_profile | A user's personal startup file.<br> Can be used to extend or override settings in the global configuration script.|
| ~/.bash_login   | If ~/.bash_profile is not found, bash attempts to read this script. |
| ~/.profile      | If neither ~/.bash_profile nor ~/.bash_login is found, bash attempts to read this file.<br> This is the default in Debian-based distributions, such as Ubuntu. |

A **non-login shell** session typically occurs when we launch a terminal session in the GUI.

non-login shells also inherit the environment from their parent process

| File             | Contents                                                 |
| ---------------- | ---------------------------------------------------------|
| /etc/bash.bashrc | A global configuration script that applies to all users. |
| ~/.bashrc        | A user's personal startup file.<br> Can be used to extend or override settings in the global configuration script. |

~/.bashrc
: almost always read. Non-login shells read it by default and most startup files for login shells are written to read the ~/.bashrc file as well.

## script

### if

If the file `~/.bashrc` exists, then get contents.

```bash
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
```

### functions

```bash
today() {
    echo -n "Today's date is: "
    date +"%A, %B %-d, %Y"
}
$ today
Today's date is: Salı, Kasım 20, 2018
```

```bash
#!/bin/bash
# sysinfo_page - A script to produce an html file
echo "<html>"
echo "<head>"
echo "  <title>"
echo "  The title of your page"
#...
```

Using quotation `"`, it is possible to embed carriage returns in our text and have the echo command's argument span multiple lines.
```bash
#!/bin/bash
# sysinfo_page - A script to produce an HTML file
echo "<html>
 <head>
   <title>
   The title of your page
#..."
```
