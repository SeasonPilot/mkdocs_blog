# LeetCode: 267. 回文排列 II

[TOC]

## 1、题目描述

给定一个字符串 s ，返回其通过重新排列组合后所有可能的回文字符串，并去除重复的组合。

如不能形成任何回文排列时，则返回一个空列表。

```
示例 1：
输入: "aabb"
输出: ["abba", "baab"]

示例 2：
输入: "abc"
输出: []
```



## 2、解题思路

- 排列生成法（超时）
- 超时的主要原因是因为没考虑到很多重复字符



```python
from itertools import permutations
from collections import Counter


class Solution:
    def generatePalindromes(self, s: str) -> [str]:
        c = Counter(s)

        center = 0
        temp = []
        for key, value in c.items():
            if value & 1:
                if center:
                    return []
                value -= 1
                center = key

            temp.extend([key] * (value // 2))

        res = set()
        for i in permutations(temp):
            if center:
                res.add("".join(i) + center + "".join(reversed(i)))

            else:
                res.add("".join(i) + "".join(reversed(i)))
        return list(res)
```



- 使用dfs回溯法生成全排列，并且去重
- 

```python
class Solution:
    def generatePalindromes(self, s: str) -> [str]:
        from collections import Counter
        c = Counter(s)
        center = 0
        temp = []
        for key, value in c.items():
            if value & 1:
                if center:
                    return []
                value -= 1
                center = key

            temp.extend([key] * (value // 2))

        res = set()

        if not temp and center:
            res.add(center)
            return list(res)

        def dfs(string, k):

            if k == len(string) - 1:
                res.add("".join(string) + (center if center else "") + "".join(reversed(string)))
                return
            else:

                for i in range(k, len(string)):
                    # 去重复
                    if i == k or string[i] != string[k]:
                        string[i], string[k] = string[k], string[i]
                        dfs(string, k + 1)
                        string[i], string[k] = string[k], string[i]

        dfs(temp, 0)
        return list(res)
```

