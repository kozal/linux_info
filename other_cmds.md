# Linux general

## add commands

shopt, eval, chmod, chown
```bash
$ chmod u=rwx,g=rx,o=r myfile
$ chmod 754 myfile
```

## file descriptor

Whenever you execute a program, operating system always opens three files `STDIN`, `STDOUT`, and `STDERR` as we know whenever a file is opened, operating system (from kernel) returns a non-negative integer called as `File Descriptor`. The file descriptor for these files are 0, 1, 2 respectively.

- `0` is the handle for standard input or `STDIN`
- `1` is the handle for standard output or `STDOUT`
- `2` is the handle for standard error or `STDERR`

## `>` output redirection

Used to redirect the program output and append the output at the end of the file

- `>` redirects output to a file, overwriting the file.
- `>>` redirects output to a file appending the redirected output at the end.

`M>N`
: `M` is a file descriptor, which defaults to 1, if not explicitly set.
`N` is a filename.
File descriptor `M` is redirect to file `N`.

`M>&N`
`M` is a file descriptor, which defaults to 1, if not set.
`N` is another file descriptor.
File descriptor `M` is redirect to file descriptor `N`.

```bash
# https://www.tldp.org/LDP/abs/html/io-redirection.html
2>&1
    # Redirects stderr to stdout.
    # Error messages get sent to same place as standard output.

i>&j
    # Redirects file descriptor i to j.
    # All output of file pointed to by i gets sent to file pointed to by j.

>&j
    # Redirects, by default, file descriptor 1 (stdout) to j.
    # All stdout gets sent to file pointed to by j.

[j]<>filename
    #  Open file "filename" for reading and writing,
    #+ and assign file descriptor "j" to it.

$ echo 1234567890 > File    # Write string to "File".
$ exec 3<> File             # Open "File" and assign fd 3 to it.
$ read -n 4 <&3             # Read only 4 characters.
$ echo -n . >&3             # Write a decimal point there.
$ exec 3>&-                 # Close fd 3.
$ cat File
1234.67890
```

## `|` pipe

`|` pipe standard output of 1 command to another

```bash
|
    # Pipe.
    # General purpose process and command chaining tool.
    # Similar to ">", but more general in effect.
    # Useful for chaining commands, scripts, files, and programs together.
$ cat *.txt | sort | uniq > result-file
    # Sorts the output of all the .txt files and deletes duplicate lines,
    # finally saves results to "result-file".
```

## `&&` and `||`

```bash
"A ; B"     # Run A and then B, regardless of success of A
"A && B"    # Run B if A succeeded
"A || B"    # Run B if A failed
"A &"       # Run A in background.
```

`&&` executes the right-hand command of `&&` only if the previous one succeeded.
`||` executes the right-hand command of `||` only it the previous one failed.
`;` separate individual commands
`|` pipe standard output of 1 command to another

The right side of `&&` will only be evaluated if the **exit status** of the left side is zero. `||` is the opposite: it will evaluate the right side **only if** the left side exit status is nonzero.

For programs on the left side, If the test inside evaluates to true, it returns zero; it returns nonzero otherwise.

`diff && echo` will print if files are same so output of `diff` is zero.

`diff || echo` will print if files are different so output of `diff` is nonzero.

```bash
$ false && echo false!

$ true && echo true!
true!
$ true || echo true!

$ false || echo false!
false!
```

## `/dev/null`

`/dev/null` is a black hole where any data sent, **will be discarded**. Redirecting a stream into it means **hiding an output**.

`/dev/null` accepts and discards all input; produces no output (always returns an end-of-file indication on a read)

Appending to or writing to `/dev/null` with `>` or `>>` has the same net effect.

2 hits and 1 error message:

```bash
$ find . -name "hede"
find: ‘./AppData/Local/Microsoft/Windows/INetCache/Low/Content.IE5’: Permission denied
./workspace/gr/m2/.git/logs/refs/heads/hede
./workspace/gr/m2/.git/refs/heads/hede
```

Only shows the found files, no errors displayed. Because `2>/dev/null` sends error to `/dev/null`

```bash
$ find . -name "hede" 2>/dev/null
./workspace/gr/m2/.git/logs/refs/heads/hede
./workspace/gr/m2/.git/refs/heads/hede
```

## `test` command

[link](http://wiki.bash-hackers.org/commands/classictest)

`test <EXPRESSION>`
`[ <EXPRESSION> ]`

Check if file `/etc/passwd` exists:

```bash
$ if [ -e /etc/passwd ]; then   echo "Alright man..."; fi
Alright man...

$ if test -e /etc/passwd; then   echo "Alright man..."; fi
Alright man...
```

file tests:

| Operator syntax     | Description                                                              |
| ------------------- | ------------------------------------------------------------------------ |
| -e <FILE>           | True if <FILE> exists.                                                   |
| -f <FILE>           | True, if <FILE> exists and is a regular file.                            |
| -d <FILE>           | True, if <FILE> exists and is a directory.                               |
| -r <FILE>           | True, if <FILE> exists and is readable.                                  |
| -w <FILE>           | True, if <FILE> exists and is writable.                                  |
| -x <FILE>           | True, if <FILE> exists and is executable.                                |
| -s <FILE>           | True, if <FILE> exists and has size bigger than 0 (not empty).           |
| <FILE1> -nt <FILE2> | True, if <FILE1> is newer than <FILE2> (mtime).                          |
| <FILE1> -ot <FILE2> | True, if <FILE1> is older than <FILE2> (mtime).                          |
| <FILE1> -ef <FILE2> | True, if <FILE1> and <FILE2> refer to the same device and inode numbers. |
| ...                 | ...                                                                      |

String tests

| Operator syntax        | Description                                                     |
| ---------------------- | --------------------------------------------------------------- |
| -z <STRING>            | True, if <STRING> is empty.                                     |
| -n <STRING>            | True, if <STRING> is not empty (this is the default operation). |
| <STRING1> = <STRING2>  | True, if the strings are equal.                                 |
| <STRING1> != <STRING2> | True, if the strings are not equal.                             |
| ...                    | ...                                                             |

Arithmetic tests

| Operator syntax           | Description                                                     |
| ------------------------- | --------------------------------------------------------------- |
| <INTEGER1> -eq <INTEGER2> | True, if the integers are equal.                                |
| <INTEGER1> -ne <INTEGER2> | True, if the integers are NOT equal.                            |
| <INTEGER1> -le <INTEGER2> | True, if the first integer is less than or equal second one.    |
| <INTEGER1> -ge <INTEGER2> | True, if the first integer is greater than or equal second one. |
| <INTEGER1> -lt <INTEGER2> | True, if the first integer is less than second one.             |
| <INTEGER1> -gt <INTEGER2> | True, if the first integer is greater than second one.          |

Misc syntax

| Operator syntax    | Description                                                                                                          |
| ------------------ | -------------------------------------------------------------------------------------------------------------------- |
| <TEST1> -a <TEST2> | True, if <TEST1> and <TEST2> are true (AND).                                                                         |
| <TEST1> -o <TEST2> | True, if either <TEST1> or <TEST2> is true (OR).                                                                     |
| ! <TEST>           | True, if <TEST> is false (NOT).                                                                                      |
| ( <TEST> )         | Group a test (for precedence). Attention: In normal shell-usage, the "(" and ")" must be escaped; use "\(" and "\)"! |
| -o <OPTION_NAME>   | True, if the shell option <OPTION_NAME> is set.                                                                      |
| -v <VARIABLENAME>  | True if the variable <VARIABLENAME> has been set. Use var[n] for array elements.                                     |
| -R <VARIABLENAME>  | True if the variable <VARIABLENAME> has been set and is a nameref variable (since 4.3-alpha)                         |


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
