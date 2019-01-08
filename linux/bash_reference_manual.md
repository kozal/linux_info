# Bash Reference Manual

[GNU.org Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html#Top)

## 3. Basic Shell Features

### 3.1. Shell syntax

#### 3.1.2. quoting

Single quotes won't interpolate anything, but double quotes will. For example: variables, backticks, certain `\` escapes, etc

- Enclosing characters in single quotes (`'`) preserves the literal value of each character within the quotes.
  - A single quote may not occur between single quotes, even when preceded by a backslash.

- Enclosing characters in double quotes (`"`) preserves the literal value of all characters within the quotes, with the exception of `$`, `` ` `` (backtick) , `\`, and, when history expansion is enabled, `!`.
  - The backslash retains its special meaning only when followed by one of the following characters: `$`, `` ` ``, `"`, `\`, or newline. Within double quotes, backslashes that are followed by one of these characters are removed. Backslashes preceding characters without a special meaning are left unmodified.

```bash
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

### 3.5. Shell expansions

#### 3.5.1 Brace Expansion

Patterns to be brace expanded take the form of an optional *preamble*, followed by **either a series of comma-separated strings or a sequence expression between a pair of braces**, followed by an optional *postscript*.

A correctly-formed brace expansion must contain unquoted opening and closing braces, and at least one unquoted comma or a valid sequence expression.

- Brace expansions may be nested. **left to right order** is preserved.
- sequence expression takes the form `{x..y[..incr]}`. Note that both x and y must be of the same type. When the increment is supplied, it is used as the difference between each term. The default increment is 1 or -1 as appropriate.

```bash
$ echo a{d,c,b}e
ade ace abe
$ echo a{1..5}e
a1e a2e a3e a4e a5e
$ echo a{1..7..2}e
a1e a3e a5e a7e

$ mkdir /home/omer/temp/{old,new,dist,bugs}
$ ls /home/omer/temp
bugs  dist  new  old
```

#### 3.5.4. command substitution

Command substitution allows the output of a command to replace the command itself. Command substitution occurs when a command is enclosed as follows:

```bash
$(command)
#or
`command`
```

```bash
$ echo $(date +%Y%m%d)
20181211
$ echo `date +%Y%m%d`
20181211
$ echo "date +%Y%m%d"
date +%Y%m%d
$ echo 'date +%Y%m%d'
date +%Y%m%d
```
