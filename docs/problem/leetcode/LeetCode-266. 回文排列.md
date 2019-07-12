# LeetCode: 266. 回文排列

[TOC]

## 1、题目描述

给定一个字符串，判断该字符串中是否可以通过重新排列组合，形成一个回文字符串。

示例 1：

输入: "code"
输出: false
示例 2：

输入: "aab"
输出: true
示例 3：

输入: "carerac"
输出: true



## 2、解题思路

- 找出字符串中字符出现的次数
- 将成对出现的去掉，仅剩下单独出现的字符次数统计
- 如果字符数是奇数，单独字符数应该为1，否则为0



```python
from collections import Counter
class Solution:
    def canPermutePalindrome(self, s: str) -> bool:
        length = len(s)
        count =  Counter(s)


        flag = 0
        for i in count.items():
            if i[1] ==1:
                flag += 1
            elif i[1] % 2 == 0:
                continue
            elif i[1] % 2:
                flag +=1
            else:
                return False

        if length % 2 and flag == 1:
            return True
        elif length %2 ==0 and not flag:
            return True
        else:
            return False
```

