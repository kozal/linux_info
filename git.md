<!-- markdownlint-disable MD014 -->
<!-- markdownlint-disable MD040 -->

# TOC

<!-- markdownlint-disable MD007 -->

- [TOC](#toc)
- [Config](#config)
  - [System](#system)
  - [Global](#global)
  - [Local](#local)
  - [Edit config files](#edit-config-files)
    - [set option](#set-option)
    - [unset option](#unset-option)
  - [Alias](#alias)
  - [Configuration](#configuration)
- [Branch](#branch)
  - [List branches](#list-branches)
  - [Switch branch](#switch-branch)
  - [Download remote branch](#download-remote-branch)
  - [Create branch](#create-branch)
  - [Create branch with uncommitted changes](#create-branch-with-uncommitted-changes)
    - [create branch from another branch](#create-branch-from-another-branch)
    - [create branch from a commit](#create-branch-from-a-commit)
  - [Delete branch](#delete-branch)
  - [Compare branches](#compare-branches)
  - [Merge branch](#merge-branch)
    - [fast forward](#fast-forward)
    - [no fast forward](#no-fast-forward)
    - [no ancestor](#no-ancestor)
    - [cherry pick](#cherry-pick)
  - [Rebase branch](#rebase-branch)
    - [merge vs rebase](#merge-vs-rebase)
- [Diff](#diff)
  - [Example](#example)
    - [pushed github as](#pushed-github-as)
    - [committed local as](#committed-local-as)
    - [staged (add) as](#staged-add-as)
    - [unstaged as](#unstaged-as)
    - [only show filenames in diff](#only-show-filenames-in-diff)
  - [Diff branches](#diff-branches)
  - [Diff tags](#diff-tags)
  - [Diff files from different branches](#diff-files-from-different-branches)
- [Unstaged files](#unstaged-files)
  - [Undo modify](#undo-modify)
- [Stage files](#stage-files)
  - [Partial add](#partial-add)
  - [Undo git add](#undo-git-add)
- [Commit files](#commit-files)
  - [Add forgotten to commit](#add-forgotten-to-commit)
  - [Undo git commit](#undo-git-commit)
  - [Go back to a commit: Detached HEAD](#go-back-to-a-commit-detached-head)
- [Status](#status)
- [History](#history)
  - [Number of entries](#number-of-entries)
  - [Format output](#format-output)
  - [Show extra info](#show-extra-info)
  - [Limit output with time](#limit-output-with-time)
  - [Log grep](#log-grep)
- [Grep](#grep)
- [Rename file](#rename-file)
- [Remove from Git](#remove-from-git)
  - [Remove git from project](#remove-git-from-project)
  - [Remove tracking for a file/sub-folder](#remove-tracking-for-a-filesub-folder)
- [Tag](#tag)
  - [Create Tag](#create-tag)
  - [Delete tag](#delete-tag)
  - [Checkout tag](#checkout-tag)
  - [Diff from tag](#diff-from-tag)
- [Repo](#repo)
  - [Push/Pull](#pushpull)
  - [Create New Repo](#create-new-repo)
  - [Add repo to GitHub](#add-repo-to-github)
  - [Clone from remote](#clone-from-remote)
- [Stash](#stash)
  - [Diff stash](#diff-stash)
  - [Get file from stash](#get-file-from-stash)
  - [Clear stash](#clear-stash)
- [Definitions](#definitions)
  - [Origin](#origin)
  - [Master](#master)
  - [Head](#head)
    - [attached vs detached HEAD](#attached-vs-detached-head)
  - [Reflog info](#reflog-info)
- [Git Objects](#git-objects)
- [Git Architecture](#git-architecture)
  - [Git commands](#git-commands)
  - [Git snapshots](#git-snapshots)
  - [Hash](#hash)
  - [Parents and Ancestors](#parents-and-ancestors)

<!-- markdownlint-enable MD007 -->

# Config

Git has 3 configuration levels. It stores configuration options in three separate files, which lets you scope options to individual repositories (local), user (Global), or the entire system (system):

- `local`: \<repo\>/.git/config – Repository-specific settings.
- `global`: /.gitconfig – User-specific settings. This is where options set with the --global flag are stored.
- `system`: $(prefix)/etc/gitconfig – System-wide settings.

The **order of priority** for configuration levels is: **local, global, system**.<br>
This means when looking for a configuration value,
Git will start at the local level and bubble up to the system level.

By **default**, git config will write to a **local** level if no configuration option is passed.

```bash
$ git --version
# list variables set in all config files
$ git config --list
```

## System

`system` level configuration is applied across an entire machine. This covers all users on an operating system and all repos.
`git config --system`

```bash
# list variables set in system config
$ git config --system --list

# or with cat
# Windows in 2 different files:
$ cat /c/ProgramData/Git/config
$ cat /c/Program\ Files/Git/mingw64/etc/gitconfig
# other:
$ cat /etc/gitconfig
$ cat /usr/local/etc/gitconfig      # homebrew git
```

## Global

`global` level configuration is user-specific,
meaning it is applied to an operating system user.

`git config --global`

Overrides `system` configuration level.

```bash
# list variables set in global config
$ git config --global --list
# or with cat
$ cat ~/.gitconfig
$ cat /c/Users/<username>/.gitconfig
```

## Local

`local` level configuration is repo specific,
applied to the context repository git config gets invoked in.

`git config --local`

Overrides `global` and `system` configuration levels

At the root of repo

```bash
# list variables set in local config
$ git config --local --list
# or with cat
$ cat .git/config
$ cat <repopath>/<reponame>/.git/config
```

## Edit config files

- They can be edited by opening by a text editor
- or opening in terminal:

```bash
# edit with terminal editor
$ git config --global --edit
```

- or alternatively set and unset from terminal:

### set option

Use quotes if value is multiple words

```bash
# add local and global settings
$ git config --local user.name "Your Name Here"
$ git config --global grep.lineNumber true
$ git config --local user.email myemail@gmail.com
```

### unset option

```bash
# remove local user.name setting
$ git config --local --unset user.name
```

## Alias

```bash
# add alias and use
$ git config --global alias.ci commit
$ git ci
```

## Configuration

```bash
$ git config --global user.name omer
$ git config --global alias.st status
$ git config --global color.ui auto
$ git config --global grep.lineNumber true
$ git config --global color.grep.filename magenta
$ git config --global color.grep.linenumber green
$ git config --global color.grep.match red

# with --no-pager
$ git config --global alias.lg '!git --no-pager log --graph --pretty=format:"%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
# or without --no-pager, shows page by page
$ git config --global alias.lg 'log --graph --pretty=format:"%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
```

# Branch

A branch in Git is simply a lightweight movable pointer to one of the commits. The default branch name in Git is master. As you initially make commits, you’re given a `master` branch that points to the last commit you made. Every time you commit, it moves forward automatically.

## List branches

```bash
# listing branches
$ git branch                        # list existing local branches
$ git branch --list                 # same as git branch
$ git branch -r                     # list existing remote branches
$ git branch -a                     # list existing local and remote branches
```

list branches with commits

```bash
$ git branch -v
  iss53   93b412c fix javascript issue
* master  7a98805 Merge branch 'iss53'
  testing 782fd34 add scott to the author list in the readmes
```

list merged branches. safe to delete `iss53`

```bash
$ git branch --merged
  iss53
* master
```

list unmerged branches.

```bash
$ git branch --no-merged
  testing
```

## Switch branch

Check [Head](#head) for illustration

```bash
# switch br_name and back to master
$ git checkout <br_name>
$ git checkout master
```

## Download remote branch

```bash
$ git checkout --track origin/br_name   # download and switch to br_name
# or
$ git checkout <remotebranch>
```

## Create branch

Creates a new pointer for you to move around.

By default git checkout -b will base the new-branch off the current `HEAD`.

```bash
$ git branch br_name2               # create branch
$ git checkout br_name2             # switch to branch
# or
$ git checkout -b <new-branch>      # create and switch to new branch
```

## Create branch with uncommitted changes

The changes in the working directory and changes staged in index do not belong to any branch.
So uncommitted changes will move when a branch is created. Simply create a branch.

### create branch from another branch

An optional additional branch parameter can be passed to git checkout.
`existing-branch` is passed which then bases new-branch off of existing-branch instead of the current `HEAD`.

```bash
$ git checkout -b <new-branch> <existing-branch>
# create a new feature branch from development branch
$ git checkout -b myfeature develop
```

### create branch from a commit

like existing branch, a new branch can be created from an existing commit.

```bash
# create the branch via a hash:
$ git checkout -b <new-branch> <sha1-of-commit>
# create the branch using a symbolic reference:
$ git checkout -b <new-branch> HEAD~3
```

## Delete branch

`git -df` = `git -D`

```bash
$ git branch -d <br_name>                # delete local branch
$ git branch -D <br_name>                # delete local branch dont care unmerged
$ git branch -df <br_name>               # delete local branch dont care unmerged
$ git push repo_name --delete <br_name>  # delete remote branch
```

## Compare branches

Show the commits that are in the "test" branch but not yet in the "release" branch, along with the list of paths each commit modifies.

```bash
$ git log --name-status release..test
```

## Merge branch

```bash
$ git checkout master               # switch back
$ git merge br_name                 # merge branch into master branch
$ git branch -d deneme              # delete the branch
```

### fast forward

If the commit (`C4`/`C3`) pointed to by the branch (`hotfix`/`iss53`) you merged in was directly ahead of the commit (`C2`) you’re on, Git simply moves the pointer forward.

Here, `master` can be fast forwarded one of the `hotfix` or `iss53` because it is ancestor of those branches. 

![fast forward](https://git-scm.com/book/en/v2/images/basic-branching-4.png)

```bash
$ git log                           # on new_branch, displays master also
* 1b1e8b9 omer: making change in branch -   (HEAD -> new_branch) (2 days ago)
* 1ade3ab omer: update newest22 -   (master) (5 days ago)
* bedcd55 omer: Revert "update newest2" -   (5 days ago)

$ git checkout master               # switch to master
Switched to branch 'master'

$ git log                           # logs only master since new_branch is ahead
* 1ade3ab omer: update newest22 -   (HEAD -> master) (5 days ago)
* bedcd55 omer: Revert "update newest2" -   (5 days ago)

$ git merge new_branch              #merge 2 branches
Updating 1ade3ab..1b1e8b9
Fast-forward

$ git log                           # both branch points same commit
* 1b1e8b9 omer: making change in branch -   (HEAD -> master, new_branch) (2 days ago)
* 1ade3ab omer: update newest22 -   (5 days ago)
* bedcd55 omer: Revert "update newest2" -   (5 days ago)

$ git branch -d new_branch          # delete new_branch
Deleted branch new_branch (was 1b1e8b9).

$ git log                           # no info in history about the new_branch
* 1b1e8b9 omer: making change in branch -   (HEAD -> master) (2 days ago)
* 1ade3ab omer: update newest22 -   (5 days ago)
* bedcd55 omer: Revert "update newest2" -   (5 days ago)
```

### no fast forward

if we don't want to move head pointer to other branch to keep the history, we can use `--no-ff`: no fast forward.

This avoids losing information about the historical existence of a branch (newer_branch) and groups together all commits that together added the feature

```bash
$ git merge --no-ff newer_branch
Merge made by the 'recursive' strategy.
$ git branch -d newer_branch        # delete the branch
Deleted branch newer_branch (was 05e9557).
$ git log                           # no info in history about the new_branch
*   8376cc1 omer: Merge branch 'newer_branch' -   (HEAD -> master) (50 seconds ago)
|\
| * c86586f omer: making changes in newer -   (2 minutes ago)
|/
* 1b1e8b9 omer: making change in branch -   (2 days ago)
* 1ade3ab omer: update newest22 -   (5 days ago)
```

### no ancestor

the commit on the branch you’re on (`master`) isn’t a direct ancestor of the branch you’re merging in (`iss53`). 

In this case, Git does a simple three-way merge, using the two snapshots pointed to by the branch tips and the **common ancestor** of the two.

![no fast forward](https://git-scm.com/book/en/v2/images/basic-merging-1.png)

Instead of just moving the branch pointer forward, Git creates a new snapshot that results from this three-way merge and automatically creates a new commit that points to it. This is referred to as a merge commit, and is special in that it has more than one parent.

![3 way merge](https://git-scm.com/book/en/v2/images/basic-merging-2.png)

### cherry pick

`git cherry-pick` - Apply the changes introduced by some existing commits.

2 commits difference bw branches and only apply some of them

```bash
$ git lg -3                         # on development branch
* ae04782 omer: corrected a register name in comments - (HEAD -> development)  (3 days ago)
* 9dca6a0 omer: update readme -   (3 days ago)
* 4ef0a27 omer: version 3.7 -   (tag: v3.7, origin/master, master) (4 months ago)

$ git checkout master               # switch to master
$ git cherry-pick 9dca6a0           # apply selected commit to master

$ git lg -2
* 15cbbe7 omer: update readme -   (HEAD -> master) (37 seconds ago)
* 4ef0a27 omer: version 3.7 -   (tag: v3.7, origin/master) (4 months ago)
```

## Rebase branch

When you rebase stuff, you’re abandoning existing commits and creating new ones that are similar but different. 

The golden rule of git rebase is to **never use it on public branches**.

Since rebase only occurs on local repo and rebasing results in brand new commits, Git will think that your master branch’s history has diverged from everybody else’s.

The only way to synchronize the two master branches is to **merge** them back together.

```bash
git rebase
```

### merge vs rebase

The snapshot pointed to by ` C4'` is exactly the same as the one that was pointed to by `C5` in the merge example.

![branches](https://git-scm.com/book/en/v2/images/basic-rebase-1.png)

Merge branches:
![merge](https://git-scm.com/book/en/v2/images/basic-rebase-2.png)

Rebase branches

```bash
$ git checkout experiment
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: added staged command
```

![rebase](https://git-scm.com/book/en/v2/images/basic-rebase-3.png)

After rebase, you can fast forward `master`:

```bash
$ git checkout master
$ git merge experiment
```

![fast forward](https://git-scm.com/book/en/v2/images/basic-rebase-4.png)

# Diff

## Example

`README.md`

### pushed github as

```bash
GUI to control zoomlens card over UART
```

### committed local as

```bash
GUI to control zoomlens card over UART with TMCL interface
```

### staged (add) as

```
GUI to control zoomlens card over UART with TMCL interface
* add more
```

### unstaged as

```
GUI to control zoomlens card over UART with TMCL interface
* add more
* just unstaged
```

Changes in the working tree not yet staged for the next commit.

```bash
$ git diff README.md                # staged vs unstaged
+* just unstaged
```

Changes between the index and your last commit; what you would be committing if you run "git commit" without "-a" option.

```bash
$ git diff --staged README.md       # committed vs staged
+* add more

$ git diff --cached README.md       # committed vs staged
+* add more
```

Changes in the working tree since your last commit; what you would be committing if you run "git commit -a"

```bash
$ git diff HEAD                     # committed vs staged and unstaged
+* add more
+* just unstaged
```

also a longer alternative

```bash
$ git status -vv
Changes to be committed:
        modified:   README.md

Changes not staged for commit:
        modified:   README.md

# c: committed, i: index
Changes to be committed:
diff --git c/README.md i/README.md
+* add more
--------------------------------------------------
# i: index, w: workspace
Changes not staged for commit:
diff --git i/README.md w/README.md
+* just unstaged
```

Show the difference between local repo and remote repo

```bash
$ git diff origin/master master     # pushed vs committed
# $ git log -p
# -GUI to control zoomlens card over UART.
# +GUI to control zoomlens card over UART with TMCL interface
```

### only show filenames in diff

`--staged` flag can also be used

```bash
$ git diff --name-only
README.md
doc/serial_gui.sublime-project
```

```bash
$ git diff --name-status
M       README.md
D       doc/serial_gui.sublime-projectREADME.md
```

## Diff branches

```bash
$ git diff topic master             # (1)
$ git diff topic..master            # (2)
$ git diff topic...master           # (3)
$ git diff <br_name>...<br_name2>
```

1. Changes between the tips of the topic and the master branches.
2. Same as above. space is same as two dots
3. Changes that occurred on the master branch since when the topic branch was started off it.

## Diff tags

```bash
$ git diff v3.4                     # diff from tag

$ git diff v0.101 --name-only       # diff from tag only filenames:

# diff committed from latest tag:
$ LATEST_TAG=$(git describe --tags --abbrev=0)
$ git diff --name-only HEAD $LATEST_TAG
$ git diff --name-only HEAD v3.4
```

## Diff files from different branches

```bash
$ git diff  <br_name> <br_name2> -- <filename>
```


# Unstaged files

You can stage, stage&commit or discard files

## Undo modify

```bash
$ git checkout -- .                 # discard all unstaged files
$ git checkout README.md            # discard 1 file
$ git checkout -- README.md         # discard 1 file
```

# Stage files

Adding files to the index

```bash
$ git add -A                        # -A: all, add any new/modified/removed files to the index
$ git add .                         # Stages all (in git 2.x), same as "git add -A"
$ git add -u                        # -u: update, stages modified and deleted, without new
$ git add <fname>                   # add 1 file
$ git add *.<ext>                   # add files by extension
```

## Partial add

Interactively choose parts of patch between the index and the work tree and add them to the index.
You can use `git add --patch <filename>` (or `-p` for short)

```bash
$ git add --patch <fname>           # add file interactively
$ git add -p <fname>                # add file interactively
```

## Undo git add

```bash
$ git reset                         # unstage files
$ git reset <fname>                 # remove 1 file
```

# Commit files

Record changes to the local repo

```bash
$ git commit -m "Initial Commit"    # commit locally
$ git commit -am "Initial Commit"   # stage and commit
```

Running `git commit` checksums all project directories and stores them as [tree objects](#git-objects) in the Git repository. Git then creates a [commit object](#git-objects) that has the metadata and a pointer to the root project tree object so it can re-create that snapshot when needed.

## Add forgotten to commit

If a file is forgotten to be committed, it can be added

```bash
$ git commit -m 'initial commit'
$ git log --pretty=oneline
ca82a6dff817ec66f44342007202690a93763949 (HEAD -> master) initial commit

$ git add forgotten_file
$ git commit --amend
$ git log --pretty=oneline
c46f20e853ee5283384667fe410228136e0789e6 (HEAD -> master) initial commit
```

## Undo git commit

`git reset`: Reset current HEAD to the specified state

- `git reset HEAD~`: Undoes the commit and leaves the changes you committed unstaged
- `git reset --soft HEAD~`: Undoes the commit and leaves the changes you committed staged
- `git reset --hard HEAD~`: Undoes the commit and deletes the changes you committed

`git revert HEAD`: Undoes commit by creating a new commit and keeping old one.
So latest commit is same as 2 ancestor commits

```bash
$ git log --pretty=oneline
c46f20e... (HEAD -> master) commit first file
ca82a6d... (origin/master, origin/HEAD) changed the version number

$ git reset HEAD~
$ git log --pretty=oneline
ca82a6d... (origin/master, origin/HEAD) changed the version number
```

```bash
$ git reset --soft 085bb3bc...      # move HEAD by deleting commits. changes to staged
$ git reset --hard 085bb3bc...      # move HEAD by deleting commits. changes deleted
```

revert can be used with commit number
`git revert HEAD~3`

```bash
$ git log --pretty=oneline
09616c725044a3f9531441a3647e33739d6dfbf3 (HEAD -> master) newest2
ab754484e5e062cc6787349a54b8b08084bdd00b update terminal

$ git revert HEAD

$ git log --pretty=oneline
bedcd551cf0379553d49e4c3ef75901655536f10 (HEAD -> master) Revert "update newest2"
dc11ed5d725a043752774c0aca65a23128e09dd4 update newest2
09616c725044a3f9531441a3647e33739d6dfbf3 newest2
```

## Go back to a commit: Detached HEAD

```bash
$ git checkout HEAD~2               # point head 2 commits back
$ git checkout 3eec234              # point head to a commit
```

# Status

Displays paths that have differences

- between the index file and the current HEAD commit, paths that have differences
- between the working tree and the index file
- paths in the working tree that are not tracked by Git

```bash
# check status
$ git status
...
        modified:   CHANGELOG.md
...
```

```bash
# status in short format
$ git status -s
M CHANGELOG.md
```

```bash
# status and diff staged vs committed
$ git status -v                     # (1)

# status and diff unstaged and staged vs committed
$ git status -vv                    # (2)
```

1. In addition to the names of files that have been changed, also show the textual changes that are staged to be committed
2. If -v is specified twice, then also show the changes in the working tree that have not yet been staged

# History

can be used with -2 option to limit

```bash
$ git log -2
```

```bash
$ git log
commit ca82a6dff817ec66f44342007202690a93763949
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Mon Mar 17 21:52:11 2008 -0700

    changed the version number

commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
    ...
```

## Number of entries

display last n commits

```bash
$ git log -3
# or
$ git log -n 3
# or
$ git log --max-count=3
```

## Format output

`--pretty` option changes the log output to formats other than the default.

`--format` da `--pretty` yerine kullanılabilir.

```bash
# each log is one line
$ git log --pretty=oneline -n 3
1ade3ab37b5219a2b2b3475950d42e020221dfde (HEAD -> master) update newest22
bedcd551cf0379553d49e4c3ef75901655536f10 Revert "update newest2"
dc11ed5d725a043752774c0aca65a23128e09dd4 update newest2

# specific format:
$ git log --pretty=format:"%h - %an, %ar : %s"
...
a11bef0 - Scott Chacon, 10 years ago : first commit
```

- `%h`: Abbreviated commit hash
- `%an`: Author name
- `ar`: Author date, relative
- `s`: Subject

## Show extra info

`-p` or `--patch`, which shows the difference introduced in each commit.
shows log and diff

```bash
$ git log -p
```

if you want to see some abbreviated stats for each commit,
you can use the `--stat` option.
Show statistics for files modified in each commit

```bash
$ git log --stat
$ git log --shortstat
```

like `git diff`, `--name-only` and `--name-status` options exists

- `--name-only`: Show the list of files modified after the commit information.
- `--name-status`: Show the list of files affected with added/modified/deleted information as well.

## Limit output with time

- `--since` and `--after`: Limit the commits to those made after the specified date
- `--until` and `--before`: Limit the commits to those made before the specified date
- `--author`: Only show commits in which the author entry matches the specified string.
- `-<n>`: Show only the last n commits
- `--` is optional, used to tell git log that subsequent arguments are file paths and not branch names.

```bash
$ git log --since=2.weeks
$ git log --since=2018-01-01
$ git log --after="2014-7-1" --before="2014-7-4"
$ git log --author="John\|Mary"     # commits by either Mary or John
$ git log -- foo.py bar.py          # commits that affected either the foo.py or the bar.py
$ git log -S"Hello, World!"         # when string is added to any file in project,
$ git log --no-merges               # discard merge commits
$ git log --merges                  # show only merge commits
```

## Log grep

`--grep`: Only show commits with a commit message containing the string

Can also be used without quotes

```bash
$ git_log --grep='BackLash'
* 9454942 omer: Motor_Focus_Move_to_Relative_Position_BackLash -   (9 months ago)
* e812ea3 omer: Motor_Focus_Move_to_Relative_Position_BackLash -   (9 months ago)
* f32d6bc omer: Added Get_Iris_Pos(), Motor_Go_to_Iris_Pos(), Motor_Focus_Move_to_Position_BackLash() -   (9 months ago)

# case insensitive
$ git_log -i --grep=backlash
* 43d5795 omer: Fixed backlash in homing, Fixed move negative if position remains same; Increase table sizes for 10 zoom levels -   (8 months ago)
* 9454942 omer: Motor_Focus_Move_to_Relative_Position_BackLash -   (9 months ago)
* e812ea3 omer: Motor_Focus_Move_to_Relative_Position_BackLash -   (9 months ago)
* f32d6bc omer: Added Get_Iris_Pos(), Motor_Go_to_Iris_Pos(), Motor_Focus_Move_to_Position_BackLash() -   (9 months ago)
```

# Grep

Look for specified patterns in the tracked files in the work tree

```bash
# ToDo.txt is defined in .gitignore
$ git grep 'backlash'
CHANGELOG.md:- setting `IDX_TARGET` as well as `IDX_XACTUAL` in backlash handling; `motor_func.c`
CHANGELOG.md:- `Motor_Focus_Move_to_Position_BackLash()` to handle backlash
```

It is different than grep, as grep search files whether it is tracked or not

```bash
# ToDo.txt is defined in .gitignore
$ grep 'backlash' *.*
CHANGELOG.md:- setting `IDX_TARGET` as well as `IDX_XACTUAL` in backlash handling; `motor_func.c`
CHANGELOG.md:- `Motor_Focus_Move_to_Position_BackLash()` to handle backlash
ToDo.txt:backlash hede
```

To display line numbers by default:

```bash
$ git config --global grep.lineNumber true
```

# Rename file

```bash
$ git mv file_from file_to
```

alternatively

```bash
$ mv README.md README
$ git rm README.md
$ git add README
```

# Remove from Git

## Remove git from project

In main folder

```bash
$ rm -rf .git
```

## Remove tracking for a file/sub-folder

first add `foldername` to `.gitignore`

```bash
$ git rm --cached README.md
$ git rm -r --cached <foldername>
```

# Tag

## Create Tag

```bash
$ git tag                               # list tags
# create new tag
$ git tag -a v2.30 -m "UART Settings"   # -a: tag annotated
$ git push --tags                       # push tags to remote
```

## Delete tag

```bash
$ git tag -d v2.0                   # undo tag
$ git push origin :v2.0             # push tag delete
```

## Checkout tag

```bash
$ git checkout v1.0                 # get a specified tag
$ git checkout master               # return to master
```

## Diff from tag

```bash
$ git diff v3.4                     # Show changes between a specified tag
$ git diff --name-only HEAD v3.4    # only show changed files bw 2 tags
```

# Repo

## Push/Pull

git pull repo_name branch_name

```bash
$ git pull origin master            # download changes from remote repo
$ git push -u origin master         # push from local repo to remote repo
```

## Create New Repo

```bash
# create new repo
$ git init
$ git add .
$ git commit -m "hede"
```

## Add repo to GitHub

Go to github.com, push + button -> new reprository

```bash
$ git remote add origin <remote repository URL>   # Sets the new remote
$ git remote -v                                   # Verifies remote URL
$ git push ...
```

## Clone from remote

Create a copy or clone of remote repositories.

`master` branch will be pulled

```bash
# Clone Previous Project into directory
$ git clone <url> <dirname>
# . means to current directory
$ git clone https://github.com/*****/serial_gui.git .
```

# Stash

Stash the changes in a dirty working directory away

```bash
$ git checkout hede                 # try to switch branch
Please commit your changes or stash them before you switch branches.
$ git stash                         # stash changes
$ git checkout hede                 # switch to branch
$ git checkout master               # switch back
$ git stash apply                   # re-apply topmost changes (this doesnt clear changes from stash)
$ git stash pop                     # re-apply topmost changes (clears changes from stash)
```

`git stash pop` is `git stash apply && git stash drop`

## Diff stash

A stash is represented as a commit whose tree records the state of the working directory, and its first parent is the commit at HEAD when the stash was created.

`stash@{0}^1`: first parent of given stash 

```bash
$ git diff stash@{0}^1 stash@{0}
$ git diff stash@{0}^1 stash@{0} -- <filename>
```

## Get file from stash

Get file from stash and stage

```bash
$ git checkout stash@{0} -- <filename>
$ git checkout stash@{0} -- .gitignore

# save file in stash as a new file
$ git show stash@{0}:<full filename>  >  <newfile>
$ git show stash@{0}:inc/TMCL.h > new_file.h
```

## Clear stash

```bash
$ git stash show                    # Show the changes recorded in the lates stash
$ git stash list                    # List the stash entries that you currently have
stash@{0}: WIP on master: 8861caa v0.102
$ git stash drop stash@{0}          # Remove a single stash entry from the list
$ git stash clear                   # Remove all the stash entries
```

# Definitions

## Origin

**origin:** alias to a repo name. Avoids the user having to type the whole remote URL when prompting a push.

Set by *default* for convention by Git when cloning from a remote for the first time.

When you clone another repository, Git automatically creates a remote named `origin` and points to it.

Can be changed.

```bash
$ git remote -v
origin  https://github.com/user1/project1.git (fetch)
origin  https://github.com/user1/project1.git (push)

$ git remote rename origin mynewalias
```

## Master

**master:** the default branch created when you initialized a git repository

local master (`master`) and remote master (`origin/master`) can point different commits.
i.e when you have unpushed commits or unpulled features.

```bash
$ git log --pretty=oneline
b7400e183bb0e... (HEAD -> master) new commit
ca82a6dff817e... (origin/master, origin/HEAD) changed the version number

$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
```

## Head

**HEAD:**  pointer to the local branch (pointer) you’re currently on (in [attached](#attached-vs-detached-head) state).

Branch is a pointer/label to the most recent commit. So `HEAD` --> `branch` --> latest commit

with `git branch`command, branches are listed and `HEAD` is indicated with `*`

```bash
$ git branch
  iss53
* master
  testing
```

`HEAD` is Git’s way of referring to the current snapshot.

There can only be a single `HEAD` at any given time.

The content of `HEAD` is stored inside `.git/HEAD` and it contains the 40 bytes SHA-1 of the current commit.

The `HEAD` is a pointer that holds your position within all your different commits.
By default `HEAD` points to your most recent commit, so it can be used as a quick
way to reference that commit without having to look up the SHA.

```bash
# display where HEAD is pointing
$ git symbolic-ref HEAD
refs/heads/master
# or
$ cat .git/HEAD
ref: refs/heads/master

$ git checkout abc_demo             # switch branch
$ git symbolic-ref HEAD
refs/heads/abc_demo
```

___
HEAD file pointing to the branch you’re on.

```bash
$ git branch testing
```

![head1](https://git-scm.com/figures/18333fig0305-tn.png)
___

HEAD points to another branch when you switch branches

```bash
$ git checkout testing
```

![head2](https://git-scm.com/figures/18333fig0306-tn.png)
___

The branch that HEAD points to moves forward with each commit

```bash
$ git commit -a -m 'made a change'
```

![head3](https://git-scm.com/figures/18333fig0307-tn.png)
___

HEAD moves to another branch on a checkout

```bash
$ git commit -a -m 'made a change'
```

![head4](https://git-scm.com/figures/18333fig0308-tn.png)

### attached vs detached HEAD

If `HEAD` points a branch, you are in `attached HEAD`.
Git automatically moves the branch pointer and `HEAD` pointer pointing branch pointer along when you create a new commit.

If you checkout specific SHA1 hash or tag, you go in to `detached HEAD` state.

![Referenced Image][2]

```bash
$ git checkout v0.104               # point HEAD to a tag
# or
$ git checkout 3eec234              # point head to a commit
# or
$ git checkout HEAD~2               # point head 2 commits back

> omer@10:53 in perspect ((3eec234...))
$ git symbolic-ref HEAD
fatal: ref HEAD is not a symbolic ref
> omer@10:53 in perspect ((3eec234...))
$ cat .git/HEAD
3eec2348ecdb55833c91275d82cdbaa7f...
```

`detached HEAD` state is a warning telling you that everything you’re doing is “detached” from the rest of your project’s development. Git won't automatically move the `HEAD` pointer.

The point is, your development <font color="red">should always</font> take place on a **branch**. <font color="red">Never</font> on a `detached HEAD` !!!
If you want to test a feature in an older version of the project, use branch

```bash
$ git checkout -b test-branch 3eec234
```

## Reflog info

Manage reflog information

`HEAD@{2}` means "where HEAD used to be two moves ago",
`master@{one.week.ago}` means "where master used to point to one week ago in this local repository

```bash
$ git reflog
7db162b (HEAD -> master) HEAD@{0}: checkout: moving from ca82a6dff817ec66f44342007202690a93763949 to master
ca82a6d (origin/master, origin/HEAD) HEAD@{1}: checkout: moving from master to HEAD~17db162b (HEAD -> master) HEAD@{2}: checkout: moving from 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7 to master
085bb3b HEAD@{3}: checkout: moving from master to HEAD~2
7db162b (HEAD -> master) HEAD@{4}: checkout: moving from 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7 to master
```

move `HEAD` to a previous state, not previous commit.

```bash
git checkout HEAD@{2}               # move head 2 entry back
```

previous state can also be master

```bash
$ git checkout abc_demo             # switch to branch
$ git checkout master               # switch back to master branch
$ git reflog
2f8c359 (HEAD -> master, origin/master) HEAD@{0}: checkout: moving from abc_demo to master
ced3449 (abc_demo) HEAD@{1}: checkout: moving from master to abc_demo
2f8c359 (HEAD -> master, origin/master) HEAD@{2}: checkout: moving from abc_demo to master
```

# Git Objects

Git objects are stored in `.git/objects` directory.

Object types are:

- `commit`: contains the directory tree object hash, parent commit hash, author, committer, date and message
- `tree`: contains the directory listing for the commit
- `blob`: contains the file snapshot
- `tag`: contains the hash of the tagged object

`git cat-file`: Provide content or type and size information for repository objects

- `-t`                    show object type
- `-p`                    pretty-print object's content

```bash
# create a file, add and commit
$ echo "An example file" > example_file.txt

# display a log info
$ git log -1
commit cf1fdb215f948795523cde2987107944d1374777
Author: Matthew Brett <matthew.brett@gmail.com>

# get type of object with -t
$ git cat-file -t cf1fdb215f948795523cde2987107944d1374777
commit

# get content of object with -p
$ git cat-file -p cf1fdb215f948795523cde2987107944d1374777
tree 83207f0274383b4a79ff6d6c297e95204ba961bc
author Matthew Brett <matthew.brett@gmail.com> 1487004984 +0000

# use hash from commit objects tree and get type of object
$ git cat-file -t 83207f0274383b4a79ff6d6c297e95204ba961bc
tree

# get content of object with
$ git cat-file -p 83207f0274383b4a79ff6d6c297e95204ba961bc
100644 blob 2f781156939ad540b2434d012446154321e41e03   example_file.txt

$ git cat-file -t 2f781156939ad540b2434d012446154321e41e03
blob

$ git cat-file -p 2f781156939ad540b2434d012446154321e41e03
An example file
```

Single commit repo

![Single commit repo](https://git-scm.com/book/en/v2/images/commit-and-tree.png)

Multi commit repo

![multiple commits](https://git-scm.com/book/en/v2/images/commits-and-parents.png)

# Git Architecture

## Git commands

- index = staging area, add = stage
- local repo = `.git` directory

- Committed means that the data is safely stored in your local database.
- Modified means that you have changed the file but have not committed it to your database yet.
- Staged means that you have marked a modified file in its current version to go into your next commit snapshot.

![Referenced Image][1]

## Git snapshots

Git thinks of its data more like a series of snapshots.
With Git, every time you commit, or save the state of your project, Git basically takes a picture of what all your files look like at that moment and stores a reference to that snapshot.
if files have not changed, Git doesn’t store the file again, just a link to the previous identical file.
Git thinks about its data more like a stream of snapshots.

![Referenced Image](https://git-scm.com/book/en/v2/images/snapshots.png "Storing data as snapshots of the project over time")

## Hash

Git stores everything in its database not by file name but by the hash value of its contents.

The mechanism that Git uses for this checksumming is called a SHA-1 hash. This is a 40-character string composed of hexadecimal characters.

## Parents and Ancestors

- `~` specifies ancestors
- `^` specifies parents

- `A^` = `A^1`: `First parent of A` = `B`
- `A^2`: `Second parent of A` = `C`
- `A^^` = `A^1^1`
- `A^^2` = `A^1^2`
- `A~2`: up two levels in the hierarchy: `grandparent of A`, favoring the first parent in cases of ambiguity

```
G   H   I   J
 \ /     \ /
  D   E   F
   \  |  / \
    \ | /   |
     \|/    |
      B     C
       \   /
        \ /
         A
A =      = A^0
B = A^   = A^1     = A~1
C = A^2  = A^2
D = A^^  = A^1^1   = A~2
E = B^2  = A^^2
F = B^3  = A^^3 = A^2^
G = A^^^ = A^1^1^1 = A~3
H = D^2  = B^^2    = A^^^2  = A~2^2
I = F^   = B^3^    = A^^3^
J = F^2  = B^3^2   = A^^3^2
```

![Referenced Image][3]

[1]: git/git_info.png "Git architecture"
[2]: git/head.png "HEAD"
[3]: git/parents.png "Parents"
