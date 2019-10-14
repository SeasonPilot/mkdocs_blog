# Parallel复制虚拟机之网卡配置

[TOC]

```
操作系统：macOS High Sierra
虚拟机操作系统：centos6.5
虚拟机软件：Parallel Desktop
<vmware fusion配置同理，参见另一篇帖子>
```



## 前言

	一般的我们会使用虚拟机来做测试，在有些生产环境也会使用虚拟机，如果想要安装多台虚拟机的时候，就可以先装好一台，然后使用虚拟机软件中的克隆功能，直接克隆出来，这样容易出现一个问题，克隆的机器的mac地址与系统中的不匹配，导致上不了网，所以这里就简单记录一下如何进行修改。

## 1、Parallel配置NAT

	默认情况下，Parallel会使用dhcp服务分配ip，不过这样有点不太方便，所以首先来更改一下，变成静态ip。
	
	![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-163954.png)
	
	如上图，我们打开Parallel的配置，找到网络配置，其中，`Enable IPv4 DHCP`是需要选上的，这个不需要变，然后修改我们的网络配置信息，如图中红框标识。
	
	这样，我们就有了一个可以使用的ip段，`192.168.2.2~192.168.2.254`，然后如果想要然虚拟机上网，还需要网关，这个我们需要到配置文件中查看。

![images](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-163957.png)

	使用终端进入如图所示的目录，找到红框标识的文件；
	
	然后打开，使用vi，vim，less等都可以，这里使用vim打开；

```
路径为：
/Library/Preferences/Parallels
```

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164000.png)

	如上图所示，标识1表示网络类型与描述，标识2为dhcp地址，也是我们想要的网关地址，标识3表示地址范围。
	
	有一点需要注意，在标识2上面的ip，`192.168.2.2`是dhcp服务器的ip，所以我们在配置的时候是不能用这个ip的。
	
	现在我们已经获得了网络地址范围，子网掩码，网关，下面就可以来配置虚拟机了。

## 2、克隆虚拟机网络配置

	首先，确认一下克隆的虚拟机的网卡是否正确；

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164015.png)

	然后我们来配置虚拟机的网络；
	
	有两个地方需要修改，

```
目录1：
	/etc/sysconfig/network-scripts  # 网络配置文件
目录2：
	/etc/udev/rules.d # 系统设备
```

	我们首先进入目录2中；

![images](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164018.png)



	看到上面所示的文件，打开它；

![images](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164019.png)

	如上图，第一行表示之前虚拟机的信息，这一行可以注释掉，或者删掉，需要记一下第二行的硬件mac地址，一会配置要用。（如果熟悉vim的多窗口编辑，这个是很简单的。）
	
	然后进入目录1；

![images](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164021.png)

	上图所示的文件即为网卡配置文件，之前的名字后置为0，改为1；
	
	然后打开文件：

![images](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164022.png)

	如上图，将红框表示的全部更改一下，网卡名改为`eth1`，`HWADDR`改为刚刚记住的硬件mac地址，然后再讲网络配置一下，网关与DNS配置为前面看到的网关地址即可。
	
	然后重启网络：

```
service network restart
```

![images](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-14-164025.png)

	至此，大功告成了！