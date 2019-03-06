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

| File            | Contents                                                                                                                                                       |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| /etc/profile    | A global configuration script that applies to all users.<br> *employs /etc/bash.bashrc and files in /etc/profile.d*                                            |
| ~/.bash_profile | A user's personal startup file.<br> Can be used to extend or override settings in the global configuration script.                                             |
| ~/.bash_login   | If ~/.bash_profile is not found, bash attempts to read this script.                                                                                            |
| ~/.profile      | If neither ~/.bash_profile nor ~/.bash_login is found, bash attempts to read this file.<br> This is the default in Debian-based distributions, such as Ubuntu. |

A **non-login shell** session typically occurs when we launch a terminal session in the GUI.

non-login shells also inherit the environment from their parent process

| File             | Contents                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------ |
| /etc/bash.bashrc | A global configuration script that applies to all users.                                                           |
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

### command substitution and quoting

Command substitution allows the output of a command to replace the command itself. Command substitution occurs when a command is enclosed as follows:

```bash
$(command)
#or
`command`
```

Single quotes won't interpolate anything, but double quotes will. For example: variables, backticks, certain `\` escapes, etc

- Enclosing characters in single quotes (`'`) preserves the literal value of each character within the quotes.
  - A single quote may not occur between single quotes, even when preceded by a backslash.

- Enclosing characters in double quotes (`"`) preserves the literal value of all characters within the quotes, with the exception of `$`, `` ` `` (backtick) , `\`, and, when history expansion is enabled, `!`.
  - The backslash retains its special meaning only when followed by one of the following characters: `$`, `` ` ``, `"`, `\`, or newline. Within double quotes, backslashes that are followed by one of these characters are removed. Backslashes preceding characters without a special meaning are left unmodified.

```bash
$ echo $(date +%Y%m%d)
20181211
$ echo `date +%Y%m%d`
20181211
$ echo "date +%Y%m%d"
date +%Y%m%d
$ echo 'date +%Y%m%d'
date +%Y%m%d

# double quotes
$ echo "$(echo "upg")"
upg
$ echo "$(echo 'upg')"
upg
# single quotes
$ echo '$(echo "upg")'
$(echo "upg")
$ echo '$(echo 'upg')'
$(echo upg)
```

## for

```bash
# backticks, not quotation marks
$ for i in `seq 1 10001`; do echo $i; done
$ for i in `seq 1 100`; do echo $i; ifconfig eth1; sleep 1; done
```

## set

These lines deliberately cause your script to fail
```bash
#!/bin/bash
set -euo pipefail

# or
set -e
set -u
set -o pipefail
```

set -e
:   The set -e option instructs bash to immediately exit if any command has a non-zero exit status. You wouldn't want to set this for your command-line shell, but in a script it's massively helpful

set -u
:   set -u affects variables. When set, a reference to any variable you haven't previously defined - with the exceptions of `$*` and `$@` - is an error, and causes the program to immediately exit.

set -o pipefail
:   This setting prevents errors in a pipeline from being masked. If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline. By default, the pipeline's return code is that of the last command - even if it succeeds.

```bash
$ grep some-string /non/existent/file | sort
grep: /non/existent/file: No such file or directory
$ echo $?
0
```

Here, `grep` has an exit code of `2`, writes an error message to `stderr`, and an empty string to `stdout`. This empty string is then passed through `sort`, which happily accepts it as valid input, and returns a status code of `0`. This is fine for a command line, but bad for a shell script: you almost certainly want the script to exit right then with a nonzero exit code...

```bash
$ set -o pipefail
$ grep some-string /non/existent/file | sort
grep: /non/existent/file: No such file or directory
$ echo $?
2
```

## IFS

The `IFS` variable - which stands for `Internal Field Separator` - controls what Bash calls word splitting.

When set to a string, each character in the string is considered by Bash to separate words. This governs how bash will iterate through a sequence.

```bash
#!/bin/bash
names=(
  "Aaron Maxwell"
  "Wayne Gretzky"
)

echo "With default IFS value..."
for name in ${names[@]}; do
  echo "$name"
done

echo ""
echo "With strict-mode IFS value..."
IFS=$'\n\t'
for name in ${names[@]}; do
  echo "$name"
done
```

```txt
With default IFS value...
Aaron
Maxwell
Wayne
Gretzky

With strict-mode IFS value...
Aaron Maxwell
Wayne Gretzky
```
