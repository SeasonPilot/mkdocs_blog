# LeetCode: 132. 分割回文串 II

[TOC]

## 1、题目描述

给定一个字符串 `s`，将 `s` 分割成一些子串，使每个子串都是回文串。

返回符合要求的最少分割次数。

**示例:**

```
输入: "aab"
输出: 1
解释: 进行一次分割就可将 s 分割成 ["aa","b"] 这样两个回文子串。


```



## 2、解题思路

-   自顶向下，递归求解
-   首先从前面找出第一个分割点，然后将剩下的字符串进行递归求解即可，中间结果使用缓存



```python
from functools import lru_cache


class Solution:
    @lru_cache(None)
    def minCut(self, s: str) -> int:
        # 已经是回文串，直接返回
        if s == s[::-1]:
            return 0

        ans = float('inf')
        for i in range(1, len(s) + 1):
            if s[:i] == s[:i][::-1]:
                ans = min(ans, self.minCut(s[i:]) + 1)
        return ans


```



-   使用动态规划

```
dp[i][j] 表示从i-j之间是否是回文串

if s[i] == s[j] and (j - i < 2 or dp[i + 1][j - 1]):
    dp[i][j] = True
    if i == 0:
        min_split[j] = 0
    else:
        min_split[j] = min(min_split[j], min_split[i - 1] + 1)

如上，如果两个字符相等，借助之前的回文串结果来更新
```





```python
class Solution:
    def minCut(self, s: str) -> int:
        length = len(s)
        min_split = list(range(length))
        dp = [[False] * length for _ in range(length)]
        for j in range(length):
            for i in range(j + 1):
                if s[i] == s[j] and (j - i < 2 or dp[i + 1][j - 1]):
                    dp[i][j] = True
                    if i == 0:
                        min_split[j] = 0
                    else:
                        min_split[j] = min(min_split[j], min_split[i - 1] + 1)
        return min_split[-1]


```

