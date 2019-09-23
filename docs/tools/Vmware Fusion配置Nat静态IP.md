# Vmware Fusion配置Nat静态IP



## 1、Mac Vmware Fusion

​	我们在使用虚拟机的时候，经常遇到这样的问题，我们会换地方，ip会变化，如果虚拟机使用桥接的方式，那么很多与ip相关的服务都会出现问题，所以我们希望使用nat模式，不过遗憾的是，在Windows下，VMware配置nat十分之方便，但是在Mac下，却有点麻烦，因为默认情况下，不支持我们配置静态ip，这对于我们来说就不太方便了。

## 2、Fusion配置Nat静态IP

### 2.1 创建Nat网络

​	首先我们进入VMware Fusion的配置界面（快捷键是Command+,），然后打开网络配置：

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070239.png)

​	如上图，首先点击锁的按钮，进行解锁，需要输入密码才可以；

![iamge](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070246.png)

​	然后，我们点击`+`号，增加一个网络，在这里显示的是`vmnet2`，在其他机器可能是3，这一点不影响，然后，将上图所示的3代表的选项选中，将下面的DHCP的选项取消。

​	（**注意**：要配置静态ip，一定要取消DHCP选项！）

### 2.2 修改Nat网络配置

​	然后，我们需要打开终端；

​	进入下面的目录：

```bash
cd /Library/Preferences/VMware\ Fusion/
```

​	 ( **注意**：在路径中出现空格需要用`\`转义)

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070253.png)

​	然后我们就能看到上面的配置文件，首先打开`networking`:

```Bash
sudo vim networking
```

​	（**注意**：没有`vim`的用`vi`，一定记得加`sudo`，需要`root`权限才能修改）

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070258.png)

​	如上图，`VNET_2`开头的配置就是我们创建的那块网卡，标号为1的是子网掩码，标号为2的是子网地址，注意，是子网地址！

```
补充：
	通过子网掩码划分子网，比如说3个255：
		11111111.11111111.11111111.00000000
	然后我们有一个ip，与上面的子网掩码进行与操作，如果是一样的，那么就代表是在一个网段中；
	例如，192.168.2.1，192.168.2.2就是一个网段；
	但是，192.168.2.1，192.168.3.2就不是一个网段，进行与操作以后，有个3是不一样的。
	子网地址是子网的第一个地址，也就是说，如果是255.255.255.0，那么指望地址就是*.*.*.0，前面的*可以自己配置。
```

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070302.png)

​	然后我们进入`vmnet2`，看到上图所示的配置文件；

```Bash
sudo vim nat.conf
```

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070306.png)

​	如上图所示，修改这里的配置即可，第一个是ip，这里的ip的网关，下面的是子网，与前面的子网掩码保持一致，上面的ip除了子网的第一个和最后一个ip不能用，其他都可以用，这里我们配置为`192.168.2.2`。

​	还有一个重要的步骤，重新打开VMware的网络配置，如下图：

![image](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070311.png)

​	为了让VMware更新我们手动修改的配置，首先我们选中这个网络，然后将2所示的选项取消选中，这是后3会被点亮，点击应用，然后在将2选中，再点击应用，这样网络配置就更新了。

​	（实际上不更改配置，就是为了点击应用，让VMware更新一下配置）

### 2.3 虚拟机网络配置

​	接下来，我们来配置一下虚拟机，目前我装的是`CentOS 7.3 1611`，首先打开虚拟机的配置选项(快捷键是Command

+E)：

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070319.png)

​	打开网络，显示下图所示的选项：

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070325.png)

​	然后选中我们配置的网络：`vmnet2`。

### 2.4 虚拟机网络配置

​	然后我们打开虚拟机，进入下面的目录，找到网卡的配置文件：

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070330.png)

​	打开网卡的配置文件：

```
vi ifcfg-ens33
```

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070335.png)

​	如上图，其中子网掩码要与之前保持一致，然后ip只要在同一网段就可以，网关和DNS配置到我们之前配置的网关上去。

​	重启网络生效：

```Bash
systemctl restart network
```

​	查看ip:

```bash
ip a
```

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-11-070339.png)

​	至此就大功告成了！

