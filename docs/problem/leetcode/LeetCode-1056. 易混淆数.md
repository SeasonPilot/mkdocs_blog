# LeetCode: 1056. 易混淆数

[TOC]

## 1、题目描述

给定一个数字 N，当它满足以下条件的时候返回 true：

原数字旋转 180° 以后可以得到新的数字。

如 0, 1, 6, 8, 9 旋转 180° 以后，得到了新的数字 0, 1, 9, 8, 6 。

2, 3, 4, 5, 7 旋转 180° 后，得到的不是数字。

易混淆数 (confusing number) 在旋转180°以后，可以得到和原来不同的数，且新数字的每一位都是有效的。

 

**示例 1：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050614.png)

```
输入：6
输出：true
解释： 
把 6 旋转 180° 以后得到 9，9 是有效数字且 9!=6 。
```

**示例 2：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050618.png)

```
输入：89
输出：true
解释: 
把 89 旋转 180° 以后得到 68，86 是有效数字且 86!=89 。
```

**示例 3：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050622.png)

```
输入：11
输出：false
解释：
把 11 旋转 180° 以后得到 11，11 是有效数字但是值保持不变，所以 11 不是易混淆数字。 
```

**示例 4：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050626.png)

```
输入：25
输出：false
解释：
把 25 旋转 180° 以后得到的不是数字。
```



**提示：**

-  $0 <= N <= 10^9$ 

- 可以忽略掉旋转后得到的前导零，例如，如果我们旋转后得到 0008 那么该数字就是 8 。

## 2、解题思路

- 出现2，3，4，5，7返回FALSE
- 

```python
class Solution:
    def confusingNumber(self, N: int) -> bool:
        d = {
            "0": "0",
            "1": "1",
            "6": "9",
            "8": "8",
            "9": "6",
        }

        num = str(N)
        temp = []
        for n in num:
            if n not in d:
                return False
            temp.append(d[n])
        return "".join(reversed(temp)) != num
```

