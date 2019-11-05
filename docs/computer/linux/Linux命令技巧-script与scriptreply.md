# Linux命令技巧：script与scriptreply

[TOC]



## 1、script

详细的说明可以man script来查看

```
Usage:
 script [options] [file]

Options:
 -a, --append            append the output
 -c, --command <command> run command rather than interactive shell
 -e, --return            return exit code of the child process
 -f, --flush             run flush after each write
     --force             use output file even when it is a link
 -q, --quiet             be quiet
 -t, --timing[=<file>]   output timing data to stderr (or to FILE)
 -V, --version           output version information and exit
 -h, --help              display this help and exit

-a, --append	输出录制的文件，在现有内容上追加新的内容
-c, --command	直接执行命令，而非是交互式的shell
-e, --return	返回子shell的退出码
-f, --flush	每次操作后都立即刷新缓存。 如果不设置这个选项，则不会实时写入文件
-q, --quiet	可以使script命令以静默模式运行，不显示script启动和exit的命令，察觉不到在录屏
-t, --timing[=<file>]	输出录制的时间数据，输出到屏幕或者存到指定文件中，回放的时候用到
-V, --version	显示版本并退出
-h, --help	    显示使用说明并退出
```

## 2、scriptreply

```
Usage:
 scriptreplay [-t] timingfile [typescript] [divisor]

Options:
 -t, --timing <file>     script timing output file
 -s, --typescript <file> script terminal session output file
 -d, --divisor <num>     speed up or slow down execution with time divisor
 -V, --version           output version information and exit
 -h, --help              display this help and exit

-t, - -timing file	     包含记录时序的文件
-s, - -typescript file	 包含脚本终端输出的文件
-d, –divisor number	     加速播放速度倍数（可以是小数：放慢）
-V, - -version	         显示版本并退出
-h, - -help	             显示使用说明并退出
```



## 3、实例

### 3.1 记录命令历史

```bash
➜  ~ script
Script started, file is typescript
➜  ~ ls
install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ pwd
/root
➜  ~ exit
Script done, file is typescript
➜  ~ cat typescript
Script started on Tue 05 Nov 2019 08:21:57 PM CST
➜  ~ ls
install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ pwd
/root
➜  ~ exit

Script done on Tue 05 Nov 2019 08:22:06 PM CST
➜  ~
```

如上所示，默认不指定参数的情况下，直接使用`script`命令，默认输出到`typescript`，会记录所有的终端的输出，可以使用`cat,more`等查看

### 3.2 记录历史与时序

如果想要能够进行命令的回放，就需要记录历史时序

```bash
➜  ~ script -ta.tm
Script started, file is typescript
➜  ~ ls
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ pwd
/root
➜  ~ exit
Script done, file is typescript
➜  ~ scriptreplay -t a.tm typescript
➜  ~ ls
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ pwd
/root
➜  ~ exit
➜  ~
```

如上所示，通过指定时序文件，就能够使用`scriptreply`进行命令的回放



### 3.3 静默模式执行命令

```bash
➜  ~ script -ta.tm -c'ls -al' typescript
Script started, file is typescript
total 136
dr-xr-x---.  9 root root  4096 Nov  5 20:30 .
dr-xr-xr-x. 19 root root  4096 Nov  5 20:30 ..
-rw-r--r--   1 root root     0 Nov  5 20:30 a.tm
-rw-------   1 root root  3767 Nov  5 19:57 .bash_history
-rw-r--r--.  1 root root    18 Dec 29  2013 .bash_logout
-rw-r--r--.  1 root root   176 Dec 29  2013 .bash_profile
-rw-r--r--.  1 root root   176 Dec 29  2013 .bashrc
drwxr-xr-x   3 root root  4096 Jan 21  2019 .cache
drwxr-xr-x   3 root root  4096 Jan 21  2019 .config
-rw-r--r--.  1 root root   100 Dec 29  2013 .cshrc
-rwxr-xr-x   1 root root  8109 Nov  5 18:31 install.sh
drwxr-xr-x  12 root root  4096 Nov  5 18:32 .oh-my-zsh
drwxr-xr-x   2 root root  4096 Nov  5 18:09 .pip
drwxr-----   3 root root  4096 Nov  5 18:26 .pki
-rw-r--r--   1 root root    73 Nov  5 18:09 .pydistutils.cfg
drwxr-xr-x   2 root root  4096 Nov  5 20:16 script_log
-rw-r--r--   1 root root  3258 Nov  5 19:18 scriptreply.txt
-rw-r--r--   1 root root   248 Nov  5 19:35 script.sh
-rw-r--r--   1 root root    10 Nov  5 18:32 .shell.pre-oh-my-zsh
drwx------   2 root root  4096 Jan 21  2019 .ssh
-rw-r--r--.  1 root root   129 Dec 29  2013 .tcshrc
-rw-r--r--   1 root root     0 Nov  5 20:30 typescript
-rw-------   1 root root  3617 Nov  5 20:10 .viminfo
-rw-r--r--   1 root root 36397 Nov  5 18:32 .zcompdump-VM_0_6_centos-5.0.2
-rw-------   1 root root  6203 Nov  5 20:30 .zsh_history
-rw-r--r--   1 root root  3597 Nov  5 18:33 .zshrc
Script done, file is typescript
➜  ~ cat typescript
Script started on Tue 05 Nov 2019 08:30:46 PM CST
total 136
dr-xr-x---.  9 root root  4096 Nov  5 20:30 .
dr-xr-xr-x. 19 root root  4096 Nov  5 20:30 ..
-rw-r--r--   1 root root     0 Nov  5 20:30 a.tm
-rw-------   1 root root  3767 Nov  5 19:57 .bash_history
-rw-r--r--.  1 root root    18 Dec 29  2013 .bash_logout
-rw-r--r--.  1 root root   176 Dec 29  2013 .bash_profile
-rw-r--r--.  1 root root   176 Dec 29  2013 .bashrc
drwxr-xr-x   3 root root  4096 Jan 21  2019 .cache
drwxr-xr-x   3 root root  4096 Jan 21  2019 .config
-rw-r--r--.  1 root root   100 Dec 29  2013 .cshrc
-rwxr-xr-x   1 root root  8109 Nov  5 18:31 install.sh
drwxr-xr-x  12 root root  4096 Nov  5 18:32 .oh-my-zsh
drwxr-xr-x   2 root root  4096 Nov  5 18:09 .pip
drwxr-----   3 root root  4096 Nov  5 18:26 .pki
-rw-r--r--   1 root root    73 Nov  5 18:09 .pydistutils.cfg
drwxr-xr-x   2 root root  4096 Nov  5 20:16 script_log
-rw-r--r--   1 root root  3258 Nov  5 19:18 scriptreply.txt
-rw-r--r--   1 root root   248 Nov  5 19:35 script.sh
-rw-r--r--   1 root root    10 Nov  5 18:32 .shell.pre-oh-my-zsh
drwx------   2 root root  4096 Jan 21  2019 .ssh
-rw-r--r--.  1 root root   129 Dec 29  2013 .tcshrc
-rw-r--r--   1 root root     0 Nov  5 20:30 typescript
-rw-------   1 root root  3617 Nov  5 20:10 .viminfo
-rw-r--r--   1 root root 36397 Nov  5 18:32 .zcompdump-VM_0_6_centos-5.0.2
-rw-------   1 root root  6203 Nov  5 20:30 .zsh_history
-rw-r--r--   1 root root  3597 Nov  5 18:33 .zshrc

Script done on Tue 05 Nov 2019 08:30:46 PM CST
➜  ~
```

如上所示，上面没有使用静默模式执行，在终端会显示命令的执行信息，并且记录

```bash
➜  ~ script -q -ta.tm -c'ls -al'  typescript
total 136
dr-xr-x---.  9 root root  4096 Nov  5 20:33 .
dr-xr-xr-x. 19 root root  4096 Nov  5 20:32 ..
-rw-r--r--   1 root root     0 Nov  5 20:33 a.tm
-rw-------   1 root root  3767 Nov  5 19:57 .bash_history
-rw-r--r--.  1 root root    18 Dec 29  2013 .bash_logout
-rw-r--r--.  1 root root   176 Dec 29  2013 .bash_profile
-rw-r--r--.  1 root root   176 Dec 29  2013 .bashrc
drwxr-xr-x   3 root root  4096 Jan 21  2019 .cache
drwxr-xr-x   3 root root  4096 Jan 21  2019 .config
-rw-r--r--.  1 root root   100 Dec 29  2013 .cshrc
-rwxr-xr-x   1 root root  8109 Nov  5 18:31 install.sh
drwxr-xr-x  12 root root  4096 Nov  5 18:32 .oh-my-zsh
drwxr-xr-x   2 root root  4096 Nov  5 18:09 .pip
drwxr-----   3 root root  4096 Nov  5 18:26 .pki
-rw-r--r--   1 root root    73 Nov  5 18:09 .pydistutils.cfg
drwxr-xr-x   2 root root  4096 Nov  5 20:16 script_log
-rw-r--r--   1 root root  3258 Nov  5 19:18 scriptreply.txt
-rw-r--r--   1 root root   248 Nov  5 19:35 script.sh
-rw-r--r--   1 root root    10 Nov  5 18:32 .shell.pre-oh-my-zsh
drwx------   2 root root  4096 Jan 21  2019 .ssh
-rw-r--r--.  1 root root   129 Dec 29  2013 .tcshrc
-rw-r--r--   1 root root     0 Nov  5 20:33 typescript
-rw-------   1 root root  3617 Nov  5 20:10 .viminfo
-rw-r--r--   1 root root 36397 Nov  5 18:32 .zcompdump-VM_0_6_centos-5.0.2
-rw-------   1 root root  6342 Nov  5 20:32 .zsh_history
-rw-r--r--   1 root root  3597 Nov  5 18:33 .zshrc
➜  ~
```

如上所示，这时候少了录屏的提示，用户无感知

### 3.4 记录时序重定向

```bash
➜  ~ script -q -t -c'ls'  typescript 2>a.tm
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ cat a.tm
0.178327 70
➜  ~ cat typescript
Script started on Tue 05 Nov 2019 08:36:39 PM CST
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~
```

如果仅指定`-t`，时序会打印大终端，这时候可以用重定向存到文件中

### 3.5 追加模式

默认的都是覆盖模式，下面使用追加模式

```bash
➜  ~ script -ta.tm -c'ls'  typescript
Script started, file is typescript
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
Script done, file is typescript
➜  ~ script -a -ta.tm -c'ls'  typescript
Script started, file is typescript
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
Script done, file is typescript
➜  ~ cat a.tm
0.727428 70
➜  ~ cat typescript
Script started on Tue 05 Nov 2019 08:38:05 PM CST
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript

Script done on Tue 05 Nov 2019 08:38:05 PM CST
Script started on Tue 05 Nov 2019 08:38:17 PM CST
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript

Script done on Tue 05 Nov 2019 08:38:17 PM CST
➜  ~
```



```bash
➜  ~ script -t -c'ls'  typescript 2>a.tm
Script started, file is typescript
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
Script done, file is typescript
➜  ~ script -a -t -c'ls'  typescript 2>>a.tm
Script started, file is typescript
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
Script done, file is typescript
➜  ~ cat a.tm
0.568868 70
0.875158 70
➜  ~ cat typescript
Script started on Tue 05 Nov 2019 08:40:01 PM CST
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript

Script done on Tue 05 Nov 2019 08:40:01 PM CST
Script started on Tue 05 Nov 2019 08:40:16 PM CST
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript

Script done on Tue 05 Nov 2019 08:40:16 PM CST
➜  ~
```



### 3.6 返回退出码

如果不加`-e`参数，退出的时候，退出码为`0`,如果需要执行命令的最后一条是否成功，可以选择加上这个选项，直接返回子`shell`执行的退出码

```bash
➜  ~ script
Script started, file is typescript
➜  ~ hello
zsh: command not found: hello
➜  ~ exit
Script done, file is typescript
➜  ~ echo $?
0
➜  ~ script -e
Script started, file is typescript
➜  ~ hello
zsh: command not found: hello
➜  ~ exit
Script done, file is typescript
➜  ~ echo $?
127
➜  ~
```



### 3.7 配置用户登录自动记录

有些时候我们有些特殊需求，当用户登陆，我们自动启动一个脚本进行记录

下面的命令放到了`/etc/profile`中，这样当用户登陆，就能够自动的进行记录信息，可以看到用户的操作与输出。

>   或者单独的文件放到`/etc/profile.d`中



```bash
#!/bin/bash

logpath="/var/scriptlog/"
current_date=$(date +%Y-%m-%d_%H_%M_%S)
current_user=`whoami`

logfilename="${logpath}${current_user}_${current_date}"
logfile="${logfilename}.his"
logtime="${logfilename}.tm"

test "$(ps -ocommand= -p $PPID | awk '{print $1}')" == 'script' || (script -t${logtime} -f ${logfile}  )
```

上面的命令行可以加上一个`-q`静默选项，体验更好一些

```bash
(base)  ~  ssh root@***.***.***.***
Last login: Tue Nov  5 20:53:43 2019 from 106.39.42.125
Script started, file is /var/scriptlog/root_2019-11-05_20_57_58.his
➜  ~ ls
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ pwd
/root
➜  ~ exit
Script done, file is /var/scriptlog/root_2019-11-05_20_57_58.his
➜  ~ cd /var/scriptlog
➜  scriptlog ll
total 8.0K
-rw-r--r-- 1 root root 1.2K Nov  5 20:58 root_2019-11-05_20_57_58.his
-rw-r--r-- 1 root root  211 Nov  5 20:58 root_2019-11-05_20_57_58.tm
➜  scriptlog cat root_2019-11-05_20_57_58.his
Script started on Tue 05 Nov 2019 08:57:58 PM CST
➜  ~ ls
a.tm  install.sh  script_log  scriptreply.txt  script.sh  typescript
➜  ~ pwd
/root
➜  ~ exit

Script done on Tue 05 Nov 2019 08:58:08 PM CST
➜  scriptlog
```

如上所示，就能够直接看到用户之前的操作了。

