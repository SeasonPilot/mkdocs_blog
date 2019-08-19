# LeetCode: 522. 最长特殊序列 II

[TOC]

## 1、题目描述

给定字符串列表，你需要从它们中找出最长的特殊序列。最长特殊序列定义如下：该序列为某字符串独有的最长子序列（即不能是其他字符串的子序列）。

子序列可以通过删去字符串中的某些字符实现，但不能改变剩余字符的相对顺序。空序列为所有字符串的子序列，任何字符串为其自身的子序列。

输入将是一个字符串列表，输出是最长特殊序列的长度。如果最长特殊序列不存在，返回 `-1` 。



**示例：**

```
输入: "aba", "cdc", "eae"
输出: 3
```

**提示：**

- 所有给定的字符串长度不会超过 `10` 。
- 给定字符串列表的长度将在 `[2, 50 ]` 之间。



## 2、解题思路

- 首先统计字符串出现的次数，仅需要判断出现次数为1的字符串
- 然后按照长度从大到小排列
- 每个字符串，都判断是否是其他字符串的子串，通过字符搜索实现
- 如果当前的字符串不是其他字符串的子串，返回当前字符串的长度即可



```python
class Solution:
    def findLUSlength(self, strs: List[str]) -> int:
        from collections import Counter
        c = Counter(strs)
        temp = sorted(c.keys(), key=len, reverse=True)

        def substr(s1: str, s2: str):
            pos = 0

            for char in s1:
                res = s2.find(char, pos)

                if res != -1:
                    pos = res + 1
                else:
                    return False
            return True

        for s in temp:
            if c[s] == 1:
                judge = True
                for i in temp:
                    if s == i:
                        continue

                    if substr(s, i):
                        judge = False
                        break

                if judge:
                    return len(s)
        return -1
```

