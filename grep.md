# Grep

If not already defined, for color output
```bash
$ grep --color=auto "John Williams" names.txt
```

## Grep1

[link](https://www.thegeekstuff.com/2009/03/15-practical-unix-grep-command-examples)

```~
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.

Two lines above this line is empty.
And this is the last line.
```

1. Search for the given string

```bash
$ grep "this" demo_file
$ grep 'this' demo_file
this line is the 1st lower case line in this file.
Two lines above this line is empty.
And this is the last line.
```

2. Multiple files: demo_file & demo_file1

When the Linux shell sees the meta character, it does the expansion and gives all the files as input to grep
```bash
$ grep 'this' demo_file* # check multiple files
demo_file:this line is the 1st lower case line in this file.
demo_file:Two lines above this line is empty.
demo_file:And this is the last line.
demo_file1:this line is the 1st lower case line in this file.
demo_file1:Two lines above this line is empty.
demo_file1:And this is the last line.
```

3. Case insensitive `grep -i`
```bash
$ grep -i "the" demo_file
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.
And this is the last line.
```

4. Match regular expression in files:

Searches for all the pattern that starts with “lines” and ends with “empty” with anything in-between
```bash
$ grep "lines.*empty" demo_file
Two lines above this line is empty.
```
From documentation of grep: A regular expression may be followed by one of several repetition operators:

- `?` The preceding item is optional and matched at most once.
- `*` The preceding item will be matched zero or more times.
- `+` The preceding item will be matched one or more times.
- `{n}` The preceding item is matched exactly n times.
- `{n,}` The preceding item is matched n or more times.
- `{,m}` The preceding item is matched at most m times.
- `{n,m}` The preceding item is matched at least n times, but not more than m times.

5. Checking for full words, not for sub-strings using `grep -w`

```bash
$ grep -i "in" demo_file
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.
Two lines above this line is empty.
And this is the last line.

$ grep -iw "in" demo_file
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.

$ grep -w "in" demo_file
this line is the 1st lower case line in this file.
```

6. Displaying lines before/after/around the match using `grep -A`, `grep -B` and `grep -C`

- `-A` is the option which prints the specified N lines after the match as shown below.
- `-B` is the option which prints the specified N lines before the match.
- `-C` is the option which prints the specified N lines in both the side(before & after) of match

```bash
$ grep "Its" demo_file
This Line Has All Its First Character Of The Word With Upper Case.

$ grep "Its" demo_file -A 2
This Line Has All Its First Character Of The Word With Upper Case.

Two lines above this line is empty.

$ grep "Its" demo_file -B 2
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.

$ grep "Its" demo_file -C 2
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.

Two lines above this line is empty.
```

7. Highlighting the search using `GREP_OPTIONS`
```bash
$ export GREP_OPTIONS='--color=auto' GREP_COLOR='100;8'
```

8. Searching in all files recursively using `grep -r`, `grep -R` or `grep --recursive`

Search in all the files under the current directory and its sub directories
```bash
$ grep -r "Its" *
```

9. Invert match using `grep -v`
```bash

$ grep -i "case" demo_file
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.

$ grep -iv "case" demo_file

Two lines above this line is empty.
And this is the last line.
```

10. Multiple pattern `grep -e`

search for more than 1 pattern: upper and 1st

```bash
$ grep -i -e "upper" -e "1st" demo_file
THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
this line is the 1st lower case line in this file.
This Line Has All Its First Character Of The Word With Upper Case.
```

11. Counting the number of matches using `grep -c`
```bash
$ grep -i "this" demo_file -c
5
```
7 occurences of "this" in 5 lines

12. Display only the file names which matches the given pattern using `grep -l`
```bash
$ grep -l "this" demo_*
demo_file
demo_file1
```

13. Show only the matched string `grep -o`
```bash
$ grep -o "Upper" demo_file
Upper
```
14. Show the position of match in the line  `grep -b`
```bash
$ grep -b "Upper" demo_file
102:This Line Has All Its First Character Of The Word With Upper Case.

$ grep -o -b "Upper" demo_file
157:Upper

$ grep -b "LINE" demo_file
0:THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.

$ grep -o -b "LINE" demo_file
5:LINE
32:LINE
```
"Upper" starts at 157th character but the line that contains it starts at 102th character,

15. Show line number while displaying the output using `grep -n`
```bash
$ grep -in "upper" demo_file
1:THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
3:This Line Has All Its First Character Of The Word With Upper Case.
```

## Grep2

[Corey](https://www.youtube.com/watch?v=VGgTmxXp7xQ&feature=em-subs_digest)

### Search text in a file

- (1. `grep`)
```bash
$ grep "Jane Williams" names.txt

$ grep "John Williams" names.txt
John Williams
John Williamson
```

- for exact match (5. `grep -w`)

```bash
$ grep -w "John Williams" names.txt
John Williams
```

- not be case sensitive (3. `grep -i` )
```bash
$ grep -wi "John Williams" names.txt
john williams
John Williams
```

- line number of the match (15. `grep -n` )
```bash
$ grep -win "John Williams" names.txt
51:john williams
431:John Williams
```

- Additional contex, see certain # of lines (6. `grep -A`, `grep -B` and `grep -C`)
write separate because they also have #of lines option: `grep -B 4`
```bash
# Before: -B
$ grep -win -B 4 "John Williams" names.txt
49-mariajones@bogusemail.com
50-
51:john williams
--
429-lauraarnold@bogusemail.com
430-
431:John Williams

# After: -A
$ grep -win -A 2 "John Williams" names.txt
51:john williams
52-304-555-4321
53-607 Martin Hollow, Chucktown WV 25311
--
431:John Williams
432-515-555-4529
433-606 Pearl St., Eerie MI 10261

# Context: -C
$ grep -win -C 2 "John Williams" names.txt
49-mariajones@bogusemail.com
50-
51:john williams
52-304-555-4321
53-607 Martin Hollow, Chucktown WV 25311
--
429-lauraarnold@bogusemail.com
430-
431:John Williams
432-515-555-4529
433-606 Pearl St., Eerie MI 10261
```

### Search text in multiple files

- Search for every file in current directory (2.)

```bash
# writing dir name instead of file name is not OK
$ grep -win "John Williams" .
grep: ./: Is a directory
$ grep -win "John Williams" ./
grep: ./: Is a directory

# adding * after dir name is OK
# Tried but could not search subdir /Personel
$ grep -win "John Williams" ./*
./memo.txt:3:In our meeting today, John Williams had mentioned that the work could be completed by the end of the month.
./names.txt:51:john williams
./names.txt:431:John Williams
grep: ./Personel: Is a directory

# search only txt files
$ grep -win "John Williams" ./*.txt
./memo.txt:3:In our meeting today, John Williams had mentioned that the work could be completed by the end of the month.
./names.txt:51:john williams
./names.txt:431:John Williams
```

- Search including sub-directories(8. `grep -r`)
```bash
# in recursive search dir name is OK
$ grep -winr "John Williams" .
./memo.txt:3:In our meeting today, John Williams had mentioned that the work could be completed by the end of the month.
./names.txt:51:john williams
./names.txt:431:John Williams
./Personel/emails.txt:5:John Williams
./Personel/phone_numbers.txt:5:John Williams
```

- Only show filenames that contain matches(12. `grep -l`)
```bash
$ grep -wirl "John Williams" .
./memo.txt
./names.txt
./Personel/emails.txt
./Personel/phone_numbers.txt
```

- Show filenames and # of matches(11. `grep -c`)
```bash
$ grep -wirc "John Williams" .
./memo.txt:1
./names.txt:2
./Personel/emails.txt:1
./Personel/phone_numbers.txt:1
```

### Pipe outputs

- eg: search history for latest new directories
pipe `history` into `grep`
```bash
$ history | grep "mkdir"
  317  mkdir bak
  320  mkdir kmz
  506  history | grep "mkdir"

$ ffmpeg -h | grep "version"
-version            show version
```

- eg: search history for latest new kmz directories
(pipe `history` into `grep`) into `grep`

```bash
$ history | grep "mkdir" | grep "kmz"
  320  mkdir kmz
  511  history | grep "mkdir" | grep "kmz"

# git commit about dotfiles
history | grep "git commit" | grep "dotfile"
```

### Regular expressions

Grep uses POSIX regular expressions by default.
Not perl compatible regex

in a regex `.`(dot) just matches any character

- find phone numbers (4. )

```bash
# search phone numbers
$ grep "...-...-...." names.txt
836-555-5439
442-555-9487
886-555-6636
...

# use pearl regex in Linux & win-git shell: GNU Grep
$ grep -P "\d{3}-\d{3}-\d{4}" names.txt

$ grep -V
grep (GNU grep) 3.0
```

OSX uses BSD Grep. To install GNU Grep:
```bash
$ grep -V
grep (BSD grep) 2.5.1-FreeBSD

$ brew install grep --with-default-names
```

- find files that contain phone numbers

```bash
$ grep -wirl -P "\d{3}-\d{3}-\d{4}" .
./names.txt
./Personel/phone_numbers.txt
```
