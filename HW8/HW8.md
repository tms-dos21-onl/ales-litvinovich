## 1. Склонировать текущий репозиторий <FIRSTNAME>-<LASTNAME> (например, ivan-ivanov) на локальную машину.

```console
Ales@KOMPUTER MINGW64 /e
$ git clone https://github.com/tms-dos21-onl/ales-litvinovich.git
Cloning into 'ales-litvinovich'...
remote: Enumerating objects: 248, done.
remote: Counting objects: 100% (68/68), done.
remote: Compressing objects: 100% (43/43), done.
remote: Total 248 (delta 32), reused 27 (delta 11), pack-reused 180
Receiving objects:  81% (201/248)
Receiving objects: 100% (248/248), 75.12 KiB | 1.83 MiB/s, done.
Resolving deltas: 100% (94/94), done.
```
## 2. Вывести список всех удаленных репозиториев для локального.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git fetch
```


## 3. Вывести список всех веток.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git branch
* main
```

## 4. Вывести последние 3 коммитa с помощью git log.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git log -3
commit 65a9e7dc22883babde811032afb589b1ca78d4a5 (HEAD -> main, origin/main, origin/HEAD)
Author: Ales <a.litvinovich>
Date:   Mon Apr 22 08:49:16 2024 +0300

    mod READMI

commit d8a77ecbef3dd419ccd518a29fd219317c35246e
Author: Ales <a.litvinovich>
Date:   Mon Apr 22 08:47:45 2024 +0300

    new READMI

commit 6c7e62ae522deba598ffcfa2c9288784dfaa29eb
Author: Ales <87812043+Ales0110@users.noreply.github.com>
Date:   Thu Mar 28 21:10:08 2024 +0300

    Update HW6.md
```

## 5. Создать пустой файл README.md и сделать коммит.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git commit -m "new READMI"
[main 49404f2] new READMI
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 READMI.md
```

## 6. Добавить фразу "Hello, DevOps" в README.md файл и сделать коммит.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   READMI.md
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git add .
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git commit -m "mod readmi"
[main 2e29eed] mod readmi
 1 file changed, 1 insertion(+)
```

## 7. Сделать реверт последнего коммита. Вывести последние 3 коммитa с помощью git log.

```console
[main 54c1fc2] Revert "mod readmi"
 1 file changed, 1 deletion(-)
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git log -3
commit 54c1fc213c1cb31a576ec8bd468470f7e2f0e413 (HEAD -> main)
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 15:56:45 2024 +0300

    Revert "mod readmi"

    This reverts commit 2e29eed4ea175474e6f99990b0d19173c5e261ec.

commit 2e29eed4ea175474e6f99990b0d19173c5e261ec (origin/main, origin/HEAD)
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 15:47:08 2024 +0300

    mod readmi

commit 49404f20d2a817c8cbe9b255d19d64a998fd6091
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 15:44:45 2024 +0300

    new READMI
```

## 8. Удалить последние 3 коммита с помощью git reset.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git reset --hard HEAD~3
HEAD is now at ef57b2d Delete READMI.md
```

## 9. Вернуть коммит, где добавляется пустой файл README.md. Для этого найти ID коммита в git reflog, а затем сделать cherry-pick.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git reflog
ef57b2d (HEAD -> main) HEAD@{0}: reset: moving to HEAD~3
54c1fc2 HEAD@{1}: revert: Revert "mod readmi"
2e29eed (origin/main, origin/HEAD) HEAD@{2}: commit: mod readmi
49404f2 HEAD@{3}: commit: new READMI
ef57b2d (HEAD -> main) HEAD@{4}: pull: Fast-forward
65a9e7d HEAD@{5}: clone: from https://github.com/tms-dos21-onl/ales-litvinovich.git
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git cherry-pick 49404f2
[main af9b5b1] new READMI
 Date: Sun Apr 28 15:44:45 2024 +0300
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 READMI.md
```

## 10. Удалить последний коммит с помощью git reset.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git reset --hard HEAD~1
HEAD is now at ef57b2d Delete READMI.md
```

## 11. Переключиться на ветку main или master. Если ветка называется master, то переименовать её в main.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git checkout main
Already on 'main'
```

## 12. Скопировать файл https://github.com/tms-dos21-onl/_sandbox/blob/main/.github/workflows/validate-shell.yaml, положить его по такому же относительному пути в репозиторий. Создать коммит и запушить его в удаленный репозиторий.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git push
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 12 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 495 bytes | 495.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/tms-dos21-onl/ales-litvinovich.git
   2e29eed..c865943  main -> main
```

## 13. Создать из ветки main ветку develop. Переключиться на неё и создать README.md в корне репозитория. Написать в этом файле какие инструменты DevOps вам знакомы и с какими вы бы хотели познакомиться больше всего (2-3 пункта). Сделать коммит.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git branch develop
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git checkout develop
Switched to branch 'develop'
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ touch READMI.md
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git add .
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git commit -m "new readmi"
[develop 97b0e5e] new readmi
 1 file changed, 2 insertions(+)
 create mode 100644 READMI.md
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git push --set-upstream origin develop
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 12 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 354 bytes | 354.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote:
remote: Create a pull request for 'develop' on GitHub by visiting:
remote:      https://github.com/tms-dos21-onl/ales-litvinovich/pull/new/develop
remote:
To https://github.com/tms-dos21-onl/ales-litvinovich.git
 * [new branch]      develop -> develop
branch 'develop' set up to track 'origin/develop'.
```

## 14. Создать из ветки main ветку support и создать там файл LICENSE в корне репозитория с содержимым https://www.apache.org/licenses/LICENSE-2.0.txt. Сделать коммит. Вывести последние 3 коммитa.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git checkout support
Switched to branch 'support'
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (support)
$ touch LICENSE.md
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (support)
$ git add .
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (support)
$ git commit -m "new license"
[support a3f1d4d] new license
 1 file changed, 207 insertions(+)
 create mode 100644 LICENSE.md
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (support)
$ git log -3
commit a3f1d4df547bcdda753aafcc0fa0a7ad79ed6027 (HEAD -> support)
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 16:21:26 2024 +0300

    new license

commit c865943fa9df1931686576163d50e105defdbb07 (origin/main, origin/HEAD)
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 16:05:14 2024 +0300

    1

commit 2e29eed4ea175474e6f99990b0d19173c5e261ec (main)
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 15:47:08 2024 +0300

    mod readmi
```

## 15. Переключиться обратно на ветку main и создать там файл LICENSE в корне репозитория с содержимым https://github.com/git/git-scm.com/blob/main/MIT-LICENSE.txt. Сделать коммит. Вывести последние 3 коммитa.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git checkout main
Switched to branch 'main'
Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ touch LICENSE.md
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git add .
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git commit -m "new license"
[main 9aee45e] new license
 1 file changed, 21 insertions(+)
 create mode 100644 LICENSE.md
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git log -3
commit 9aee45eb0a9cc6478eb6355fe802cece9491078a (HEAD -> main)
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 16:24:59 2024 +0300

    new license

commit 2e29eed4ea175474e6f99990b0d19173c5e261ec
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 15:47:08 2024 +0300

    mod readmi

commit 49404f20d2a817c8cbe9b255d19d64a998fd6091
Author: Ales <alesworld1@gmail.com>
Date:   Sun Apr 28 15:44:45 2024 +0300

    new READMI
```

## 16. Сделать merge ветки support в ветку main и решить конфликты путем выбора содержимого любой одной лицензии.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git checkout main
Already on 'main'
Your branch and 'origin/main' have diverged,
and have 1 and 1 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git merge support
Auto-merging LICENSE.md
CONFLICT (add/add): Merge conflict in LICENSE.md
Automatic merge failed; fix conflicts and then commit the result.
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main|MERGING)
$ git add .
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main|MERGING)
$ git commit -m "merge"
[main f39236a] merge
```

## 17. Переключиться на ветку develop и сделать rebase относительно ветки main.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (main)
$ git checkout develop
Switched to branch 'develop'
Your branch is up to date with 'origin/develop'.
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git rebase main
Successfully rebased and updated refs/heads/develop.
```

## 18. Вывести историю последних 10 коммитов в виде графа с помощью команды git log -10 --oneline --graph.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git log -10 --oneline --graph
* 609eba3 (HEAD -> develop) new readmi
*   f39236a (main) merge
|\
| * a3f1d4d (support) new license
| * c865943 (origin/main, origin/HEAD) 1
* | 9aee45e new license
|/
* 2e29eed mod readmi
* 49404f2 new READMI
* ef57b2d Delete READMI.md
* 65a9e7d mod READMI
* d8a77ec new READMI
```

## 19. Запушить ветку develop. В истории коммитов должен быть мерж support -> main.

```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git push
To https://github.com/tms-dos21-onl/ales-litvinovich.git
 ! [rejected]        develop -> develop (non-fast-forward)
error: failed to push some refs to 'https://github.com/tms-dos21-onl/ales-litvinovich.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git pull
Merge made by the 'ort' strategy.
```
```console
Ales@KOMPUTER MINGW64 /e/ales-litvinovich (develop)
$ git push
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 12 threads
Compressing objects: 100% (12/12), done.
Writing objects: 100% (12/12), 5.69 KiB | 5.69 MiB/s, done.
Total 12 (delta 6), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (6/6), completed with 1 local object.
To https://github.com/tms-dos21-onl/ales-litvinovich.git
   97b0e5e..3c494a3  develop -> develop
```
## 20. Зайти в свой репозиторий на GitHub и создать Pull Request из ветки develop в ветку main.
done
