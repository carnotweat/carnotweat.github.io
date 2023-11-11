title: Git
date: 2023-11-07 10:00
tags: tools
summary: Git workflow!
---

Git workflow for a quite a capitavitng situation

Notes

I am keeping it github for example here , as it's best known

for use case, consider deploying to a VPS instead of gh-pages

- upsides
  - modularized codebase , a very simple example
- downsides
  - subtrees are hard to list
  
 until git remote add orgin

How I made it work for the first push (inverse order)

```
git subtree push  --prefix  site puppet gh-pages
(staging-site way didn't work)
git commit -m “Added mysite files” ./site
#or
git commit -o
git add site
git subtree add --prefix ./site 
git subtree add —-prefix site puppet staging-site
git commit --allow-empty -n -m "Initial commit."
git-identity (personal-config - before commit)
git remote add puppet https://github.com/carnotweat/carnotweat.github.io/
git init --bare carnotweat.github.io.git
git checkout -b main
git init
```
before adding origin , I ll test git pull gh-pages/cherrypick 

 To read the state
```
git remote -v show  puppet
git status --porcelain
git sub/tree show (aliases )
git worktree list
 git rev-parse HEAD
ls -l .git/refs/heads
git symbolic-ref HEAD
```
To force push
```
git subtree split --prefix site gh-pages
```

This will (after a lot of numbers) return a token, e.g.

157a66d050d7a6188f243243264c765f18bc85fb956. Then
```
git push puppet 157a66d050d7a6188f243243264c765f18bc85fb956:gh-pages --force
```
### Depending on Analysis

Branch not fully merged

find the number of commits by which your branch is behind the remote
```
git rev-list --left-right --count branch remote/branch
```
verify , if you lost any important commit
```
git log --graph --left-right --cherry-pick --oneline gh-pages gh-pages-old
```
Interective rebase

```
git rebase -i HEAD~N
or 
git rebase --edit-todo
```

followed by squash,pick in the $EDITOR ,stash, fetch, rebase,stash, then just add,commit push.[^1]

or

rename the branch as branch-old, fetch from puppet, checkout --track puppet/branch,rebase --root
old --onto branch, checkout branch, delete old, push.



Todo

1. Add build source as a (substituitable- variable) library

### claiming your commits

No global git identity config

- custom made unpublished shell builtins as nix pkgs in home-manager for
  - git-identity
    - using secret github emal for git push et al
  - git-import
    - import my gpg secret keys to authorise my commits from this machine.

There are others , but not relevant for this post

I prefer to sign my commits and even auth them with gpg-agent , instead of ssh-agent , to reduce
complexity. For the latter I need pass and emacs.

My nix[^2] and emacs config are available here. The former depends on flake. The latter is heavily
inspired from another source[^3].

[^1]: It's *impossible* to actually edit a commit. Whenever you do something that seems like editing
a commit, what actually happens in the background is the old commit gets deleted and a new one
is created with all the same data except the parts you changed (and a different id).
Since you've "edited" the commit to change the message, you are now behind the remote because the
original commit no longer exists in your local copy.
[^2]:  https://github.com/carnotweat/pipe-forge-nix/tree/master
[^3]: https://mmk2410.org/2023/04/02/publishing-my-emacs-configuration-using-gitea-actions/