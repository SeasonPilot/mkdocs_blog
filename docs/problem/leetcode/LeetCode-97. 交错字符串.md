# LeetCode: 97. 交错字符串

[TOC]

## 1、题目描述

给定三个字符串 `s1, s2, s3,` 验证 `s3` 是否是由 `s1` 和 `s2` 交错组成的。

**示例 1:**

```
输入: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
输出: true
```


**示例 2:**

```
输入: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
输出: false
```



## 2、解题思路

-   递归法
-   每次匹配一个字符
    -   如果第一个串能匹配，尝试匹配
    -   如果第二个串能匹配，尝试匹配
-   将结果取或，由于短路操作，只要取到`True`，就会直接返回结果



```python
from collections import Counter
from functools import lru_cache


class Solution:
    @lru_cache(None)
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        if Counter(s1) + Counter(s2) != Counter(s3):
            return False
        if s1 + s2 == s3 or s2 + s1 == s3:
            return True
        if (not s1 and s2 != s3) or (not s2 and s1 != s3):
            return False
        ans = False
        if s1[0] == s3[0]:
            ans = self.isInterleave(s1[1:], s2, s3[1:])
        if s2[0] == s3[0]:
            ans = ans or self.isInterleave(s1, s2[1:], s3[1:])

        return ans

```

