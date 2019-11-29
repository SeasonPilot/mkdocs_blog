# LeetCode: 115. 不同的子序列

[TOC]

## 1、题目描述

给定一个字符串 `S` 和一个字符串 `T`，计算在 `S` 的子序列中 `T` 出现的个数。

一个字符串的一个子序列是指，通过删除一些（也可以不删除）字符且不干扰剩余字符相对位置所组成的新字符串。（例如，`"ACE"` 是 `"ABCDE"` 的一个子序列，而 `"AEC"` 不是）

**示例 1:**

```
输入: S = "rabbbit", T = "rabbit"
输出: 3
解释:

如下图所示, 有 3 种可以从 S 中得到 "rabbit" 的方案。
(上箭头符号 ^ 表示选取的字母)

rabbbit
^^^^ ^^
rabbbit
^^ ^^^^
rabbbit
^^^ ^^
```


**示例 2:**

```
输入: S = "babgbag", T = "bag"
输出: 5
解释:

如下图所示, 有 5 种可以从 S 中得到 "bag" 的方案。 
(上箭头符号 ^ 表示选取的字母)

babgbag
^^ ^
babgbag
^^    ^
babgbag
^    ^^
babgbag
  ^  ^^
babgbag
    ^^^
```



## 2、解题思路

-   动态规划
-   初始化

```
dp[i][j] 表示s前面i个字符能够匹配t前面j个字符的次数

dp[i][0] = 1 while i in [0,len(s)]
```

-   状态转换方程

```
if s[i - 1] == t[j - 1]:
    dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j]
else:
    dp[i][j] = dp[i - 1][j]
```



```python
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        l1, l2 = len(s), len(t)

        dp = [[0 for _ in range(l2 + 1)] for _ in range(l1 + 1)]

        for i in range(l1 + 1):
            dp[i][0] = 1

        for j in range(1, l2 + 1):
            for i in range(j, l1 + 1):
                if s[i - 1] == t[j - 1]:
                    dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j]
                else:
                    dp[i][j] = dp[i - 1][j]
        return dp[l1][l2]
    
```

