# LeetCode: 712. 两个字符串的最小ASCII删除和

[TOC]

## 1、题目描述

给定两个字符串`s1, s2`，找到使两个字符串相等所需删除字符的`ASCII`值的最小和。

**示例 1:**

```
输入: s1 = "sea", s2 = "eat"
输出: 231
解释: 在 "sea" 中删除 "s" 并将 "s" 的值(115)加入总和。
在 "eat" 中删除 "t" 并将 116 加入总和。
结束时，两个字符串相等，115 + 116 = 231 就是符合条件的最小和。
```

**示例 2:**

```
输入: s1 = "delete", s2 = "leet"
输出: 403
解释: 在 "delete" 中删除 "dee" 字符串变成 "let"，
将 100[d]+101[e]+101[e] 加入总和。在 "leet" 中删除 "e" 将 101[e] 加入总和。
结束时，两个字符串都等于 "let"，结果即为 100+101+101+101 = 403 。
如果改为将两个字符串转换为 "lee" 或 "eet"，我们会得到 433 或 417 的结果，比答案更大。
```


**注意:**

- `0 < s1.length, s2.length <= 1000。`
- `所有字符串中的字符ASCII值在[97, 122]之间。`



## 2、解题思路

- 动态规划

- 初始化

  - `dp[i][j]`表示`s1`前面`i`个字符和`s2`前面`j`个字符删除得到所需的最小的数字

- 状态转换方程

  - 如果 `s1[i]==s2[i]: dp[i][j] = dp[i-1][j-1]`
- 如果 `s1[i]!=s2[i]: dp[i][j] = min(dp[i - 1][j] + ord(s1[i - 1]), dp[i][j - 1] + ord(s2[j - 1]))`
  
  



```python
class Solution:
    def minimumDeleteSum(self, s1: str, s2: str) -> int:
        N1, N2 = len(s1), len(s2)

        dp = [[0 for _ in range(N2 + 1)] for _ in range(N1 + 1)]

        for i in range(1, N1 + 1):
            dp[i][0] = dp[i - 1][0] + ord(s1[i - 1])

        for i in range(1, N2 + 1):
            dp[0][i] = dp[0][i - 1] + ord(s2[i - 1])

        for i in range(1, N1 + 1):
            for j in range(1, N2 + 1):
                if s1[i - 1] == s2[j - 1]:
                    dp[i][j] = dp[i - 1][j - 1]
                else:
                    dp[i][j] = min(dp[i - 1][j] + ord(s1[i - 1]), dp[i][j - 1] + ord(s2[j - 1]))

        return dp[N1][N2]
```

