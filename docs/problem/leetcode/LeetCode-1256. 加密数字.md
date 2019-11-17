# LeetCode: 1256. 加密数字

[TOC]

## 1、题目描述

给你一个非负整数 `num` ，返回它的「加密字符串」。

加密的过程是把一个整数用某个未知函数进行转化，你需要从下表推测出该转化函数：



![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-17-113434.png) 

**示例 1：**

```
输入：num = 23
输出："1000"
```


**示例 2：**

```
输入：num = 107
输出："101100"
```

**提示：**

$0 <= num <= 10^9$



## 2、解题思路

-   按照规律计算
-   从一开始记性计算，一位数，两位数，满足`2**n`的规律



```python
class Solution:
    def encode(self, num: int) -> str:
        if num == 0:
            return ""

        num += 1
        bits = int(math.log(num, 2))
        number = num - (2 ** bits)

        return bin(number)[2:].zfill(bits)
```

