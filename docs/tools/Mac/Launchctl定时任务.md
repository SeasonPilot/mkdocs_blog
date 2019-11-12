# Launchctl定时任务

[TOC]

macOS 使用 `launchd` 进程来管理守护进程和代理，而您还可以用它来运行 shell 脚本。您不与 [launchd](x-man-page://launchd) 直接交互，而是使用 [launchctl](x-man-page://launchctl) 命令来载入或卸载 `launchd` 守护进程和代理。

在系统启动期间，`launchd` 是内核在设置电脑时首先运行的进程。若您想要 shell 脚本作为守护进程运行，应由 `launchd` 来启动它。其他用于启动守护进程和代理的机制可能会被 Apple 酌情移除。



## 一、编写一个plist文件

launchctl 将根据这个plist文件的信息来启动任务，值得注意的是 Label 对应的值需要保证唯一性，作为任务的唯一标示。可以使用如下命令来验证plist格式的正确性(不代表命令有效)：

```
$ plutil-lint /Users/denglibing/Library/LaunchAgents/com.denglibing.checkin.plist
```

完整的 plist 文件：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.zhang.jobstart</string>
    <key>RunAtLoad</key>
    <true/>
    <key>ProgramArguments</key>
    <array> <string>/Users/zhang/jobstart.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <array>
        <dict>
            <key>Weekday</key>
            <integer>1</integer>
            <key>Hour</key>
            <integer>8</integer>
            <key>Minute</key>
            <string>58</string>
        </dict>
        <dict>
            <key>Weekday</key>
            <integer>2</integer>
            <key>Hour</key>
            <integer>8</integer>
            <key>Minute</key>
            <string>52</string>
        </dict>
    </array>
    <key>StandardOutPath</key>
    <string>/Users/zhang/mylog/outlog</string>
    <key>StandardErrorPath</key>
    <string>/Users/zhang/mylog/errorlog</string>
</dict>
</plist>
```



支持两种方式配置执行时间：

-   `StartInterval`: 指定脚本每间隔多长时间（单位：秒）执行一次；
-   `StartCalendarInterval`: 可以指定脚本在多少分钟、小时、天、星期几、月时间上执行，类似如crontab的中的设置，包含下面的 key:

```
Minute <integer>
The minute on which this job will be run.

Hour <integer>
The hour on which this job will be run.

Day <integer>
The day on which this job will be run.

Weekday <integer>
The weekday on which this job will be run (0 and 7 are Sunday).

Month <integer>
The month on which this job will be run.
```



## 二、编写定时脚本

即上面plist文档中的 `checkin_request.sh` 脚本：

```bash
$ chmod a+x /Users/zhangguohaocheckin_request.sh
```



## 三、plist文件的位置

可以通过查看以下配置文件来了解由 `launchd` 管理的各种守护进程和代理：

| 文件夹                      | 用途                                         |
| :-------------------------- | :------------------------------------------- |
| /系统/资源库/LaunchDaemons/ | Apple 提供的系统守护进程                     |
| /系统/资源库/LaunchAgents/  | Apple 提供的基于每个用户且所有用户适用的代理 |
| /资源库/LaunchDaemons/      | 第三方系统守护进程                           |
| /资源库/LaunchAgents/       | 基于每个用户且所有用户适用的第三方代理       |
| ~/资源库/LaunchAgents/      | 仅适用于登录用户的第三方代理                 |

建议放在 `~/Library/LaunchAgents` 下面



## 四、加载命令

```bash
# 加载任务, -w选项会将plist文件中无效的key覆盖掉，建议加上
$ launchctl load -w com.zhangguohao.checkin.plist

# 卸载任务
$ launchctl unload -w com.zhangguohao.checkin.plist

# 立即执行一次
$ launchctl start com.zhangguohao.checkin.plist

# 删除任务
$ launchctl stop com.zhangguohao.checkin.plist

# 查看任务列表, 使用 grep '任务部分名字' 过滤
$ launchctl list | grep 'com.zhangguohao'

```



## 五、plist注意事项

```
1、Label：对应的需要保证全局唯一性；
2、Program：要运行的程序；
3、ProgramArguments：命令语句
4、StartCalendarInterval：运行的时间，单个时间点使用dict，多个时间点使用 array <dict>
5、StartInterval：时间间隔，与StartCalendarInterval使用其一，单位为秒
6、StandardInPath、StandardOutPath、StandardErrorPath：标准的输入输出错误文件，这里建议不要使用 .log 作为后缀，会打不开里面的信息。
7、定时启动任务时，如果涉及到网络，但是电脑处于睡眠状态，是执行不了的，这个时候，可以定时的启动屏幕就好了。
```



## 六、参考链接

-   [Scheduling Timed Jobs](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html)

-   [MacOS launchd plist StartInterval and StartCalendarInterval examples](https://alvinalexander.com/mac-os-x/launchd-plist-examples-startinterval-startcalendarinterval)
-   [Mac launchctl StartInterval not working](http://alvinalexander.com/mac-os-x/mac-os-x-startinterval-broken-launchctl-throttleinterval)

-   https://www.launchd.info/

