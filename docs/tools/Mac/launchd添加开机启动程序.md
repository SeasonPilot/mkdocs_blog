# launchd添加开机启动程序

[TOC]



## 0、准备

Launchd是Darwin核心启动后所调用的第一个也是唯一一个进程，剩下所有的系统服务和用户进程都由它管理。

-   Mac 下 Launchd 指定目录有：

```
~/Library/LaunchAgents
/Library/LaunchAgents
/Library/LaunchDaemons
/System/Library/LaunchAgents
/System/Library/LaunchDaemons
```



-   其中的区别：

```
/System/Library 目录下存放的是系统文件
/Library 、~/Library/ 目录是用户存放的第三方软件
LaunchDaemons 是用户未登陆前就启动的服务
LaunchAgents 是用户登陆后启动的服务
```



-   常用配置关键字

```
Label - 标识符，用来表示该任务的唯一性
Program - 程序名称，用来说明运行哪个程序、脚本
ProgramArguments - 数组程序名，同上，只是可以运行多个程序
WatchPaths - 监控路径，当路径文件有变化是运行程序，也是数组
RunAtLoad - 是否在加载的同时
```



## 1、创建plist文件

```
sudo vi /Library/LaunchDaemons/{name}.plist
```



```script
<?xml version="1.0" encoding="UTF-8"?>  
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">  
<plist version="1.0">  
<dict>  
        <key>Label</key>  
        <string>{name}.plist</string>  
        <key>ProgramArguments</key>  
        <array>  
                <string>/usr/local/bin/nginx</string>  
        </array>  
        <key>KeepAlive</key>  
        <false/>  
        <key>RunAtLoad</key>  
        <true/>  
        <key>StandardErrorPath</key>  
        <string>/usr/local/var/log/nginx/error.log</string>  
        <key>StandardOutPath</key>  
        <string>/usr/local/var/log/nginx/access.log</string>  
</dict>  
</plist>  
```

## 2、注册服务

-   加载

```
sudo launchctl load -w /Library/LaunchDaemons/{name}.plist
```

-   卸载

```
sudo launchctl unload -w /Library/LaunchDaemons/{name}.plist
```



## 3、reboot并自动运行

**立即运行**

```
sudo launchctl start /Library/LaunchDaemons/{name}.plist
```

**查看启动日志**

```
cat /var/log/system.log
```

