# Linux0.12: 引导启动程序

[TOC]

## 1、引导程序概要

​	计算机的启动流程首先上电加载，开机加电之后，将CS设置为0xFFFF，IP设置为0x0000，这样组成的地址就是0xFFFF0，而这个就是BIOS的入口地址，之后CPU读取这个地址的代码

​	为了向前兼容，一般的都是生成ffff0的地址，然后前面地址全部置1，然后将代码copy到1M以下的部分



## 2、引导程序流程



```flow
st=>start: 加载512B引导
e=>end: 死机(无限循环)
op1=>operation: 移动当前代码到0x9000
op2=>operation: 修改软驱参数表|current
op3=>operation: 加载SETUP|current
op4=>operation: 获取磁盘每磁道扇区数|current
op5=>operation: 加载SYSTEM模块|current
op6=>operation: 判断软驱设备类型(1.2MB or 1.44MB)|current
cond1=>condition: 根文件系统已指定？
cond2=>condition: 软驱类型符合？
sub1=>subroutine: SETUP程序

st->op1->op2
op2->op3->op4
op4->op5
op5->cond1
cond1(yes,right)->sub1
cond1(no)->op6
op6->cond2
cond2(yes,right)->sub1
cond2(no)->e
```





