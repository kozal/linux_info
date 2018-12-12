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
