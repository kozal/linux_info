# bash shell scripting

File extension for a script is not mandatory in Linux. OS checks first two bytes of file to check file type.

## shebang

first row starts with `#!`

which shell should be used to interpret the script

every script not starting with shebang is wrong.

```bash
#!/bin/bash
```

## readability

in bash script, no requirements on indentations. for readibility, white line (empty line) is important.

## exit codes

script starts a `sub-shell`; when completed, exit codes can be used to tell `parent shell` the result.

`exit 0` is success, `exit non-zero` is failure. If you use non standart exit codes, document them.

```bash
exit 167
# exit 167 means file not found.
```

To check last exit code:

```bash
$ echo $?
10
```

## heir documents

write variables in uppercase for readibility

```bash
cat << BLAH
what directory?
BLAH

# stop script and get input to variable
read DIR
cd $DIR
pwd
```

## source vs sub-shell

The commands are executed in subshell and after exit, we return to parent shell, so the director change etc does not affect parent shell and we return to original directory.

to execute in parent shell, we need to source it.

```bash
# subshell vs parent shell
$ ./script2
$ . script2
```

separate the static and dynamic part to files and use `source`.

file `script2b`
```bash
#!/bin/bash

. colors

echo the color is $COLOR
```

file `color`
```bash
COLOR=red
```

```bash
$ ./script2b
the color is red
```

> if you'll source a script, make sure it does not contain exit

export
: make variable avaliable to all sub-shells

## arguments

Arguments are written after command.

```bash
$ ls -l hede
```

option
: argument that changes the behaviour of script (command)

```bash
#!/bin/bash

echo "Hello $1, how are you today"
echo " hello $2, how are you"
echo " hello $10, how are you"
echo " hello ${10}"
shift
echo hi $1
echo "\$0 is $0"
```

`"`
: used to be sure that spaces are handled correctly

- `$10`: argument #1 concetenated with 0
- `${10}`: argument #10
- `$@` name of the script

`{}`
: does not work same in all shells, shebang is important

```bash
$ ./script3 a b c d e f g h i j k
Hello a, how are you today
 hello b, how are you
 hello a0, how are you
 hello j
hi b
$0 is ./script3
```

- `$*`: all arguments as 1 string
- `$#`: number of arguments
- `$@`: all arguments as element of its own

```bash
echo "\$* gives $*"
echo "\$# gives $#"
echo "\$@ gives $@"

echo showing the interpretation of \$*
for i in "$*"
do
    echo $i
done

echo showing the interpretation of \$@
for i in "$@"
do
    echo $i
done
```

```bash
$ ./script4 a b c d e f g h i j k l
$* gives a b c d e f
$# gives 6
$@ gives a b c d e f

showing the interpretation of $*
a b c d e f
showing the interpretation of $@
a
b
c
d
e
f

# "b c d" counted as 1 argument
$ ./script4 a "b c d" e
$* gives a b c d e
$# gives 3
$@ gives a b c d e
showing the interpretation of $*
a b c d e
showing the interpretation of $@
a
b c d
e
```

## command substitution

kernel version
```bash
$ uname -r
4.15.0-39-generic
```

using `$()` and `` ` `` (backtick) gives same result. but backtick may be problemattic because of readibility (mixed with `'`)

```bash
cp $file /lib/modules/`uname -r`
```

## pattern matching

pattern matching operators:

remove stuff from begining or end of the string

`#`: left to right
`%`: right to left

- `##`, `%%`: longest match of `*` with anything in front of it
- `#`, `%`: shortest match

```bash
# to test, use /usr/bin/blah
filename=${1##*/}
echo 'filename=${1##*/}'
echo "The name of the file is $filename"
directoryname=${1%/*}
echo 'directoryname=${1%/*}'
echo "the name of the directory is $directoryname"

$ ./script6 /usr/bin/blah
filename=${1##*/}
The name of the file is blah
directoryname=${1%/*}
the name of the directory is /usr/bin
```

`'`: nothing will be interpreted, everything will be displayed as is

if you change `##` with `#` and `%` with `%%`
```bash
The name of the file is usr/bin/blah
the name of the directory is
```

```bash
BLAH=rababarabarabarara
clear

echo BLAH=$BLAH
echo 'the result of ##*ba is' ${BLAH##*ba}
echo 'the result of #*ba is' ${BLAH#*ba}
echo 'the result of %%ba* is' ${BLAH%%ba*}
echo 'the result of %ba* is' ${BLAH%ba*}

$ ./script7
BLAH=rababarabarabarara
the result of ##*ba is rara
the result of #*ba is barabarabarara
the result of %%ba* is ra
the result of %ba* is rababarabara
```

if performance is important, use bash internals, not externals like `awk` etc

> if you can do it bash internals, do it that way

## conditions

man test

both lines are the exactly the same.

notice the empty space after `[` and before `]`

```bash
if [ -z $1 ]
if test -z $1
```

```bash
# if $1 is absent -> no variable provided
if test -z $1
then
    echo you have to provide an argument with this script
    exit 1
fi
echo the argument is $1

# the same thing
[ -z $1 ] && echo you have to provide an argument  && exit 1
echo the argument is $1
```

## troubleshooting

debugging

```bash
bash -x ./script10
```
