# LeetCode: 625. 最小因式分解

[TOC]

## 1、题目描述

给定一个正整数 `a`，找出最小的正整数 `b` 使得 `b` 的所有数位相乘恰好等于 `a`。

如果不存在这样的结果或者结果不是 `32` 位有符号整数，返回 `0`。

 

**样例 1**

```
输入：

48 
输出：

68
```

**样例 2**

```
输入：

15
输出：

35


```



## 2、解题思路

-   从大到小`（9-1）`找出能够整除当前数字的数
-   然后判断是否是小于`2 ** 31 - 1`，也就是`32`位能够表示的最大整数



```python
class Solution:
    def smallestFactorization(self, a: int) -> int:
        ans = []
        max_num = 2 ** 31 - 1
        for i in range(11):
            if a <= 9:
                ans.append(a)
                break
            for num in range(9, 0, -1):
                cur = a / num
                if cur == int(cur):
                    ans.append(num)
                    a = int(cur)
                    break
        if len(ans) > 10:
            return 0
        res = int("".join(map(str, reversed(ans))))
        return res if res <= max_num else 0
```

