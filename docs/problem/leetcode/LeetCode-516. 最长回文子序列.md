# LeetCode: 516. 最长回文子序列

[TOC]

## 1、题目描述

给定一个字符串s，找到其中最长的回文子序列。可以假设s的最大长度为1000。

```
示例 1:
输入:

"bbbab"
输出:

4
一个可能的最长回文子序列为 "bbbb"。

示例 2:
输入:

"cbbd"
输出:

2
一个可能的最长回文子序列为 "bb"。
```



## 2、解题思路

`dp[i][j]` 表示 s 的第 i 个字符到第 j 个字符组成的子串中，最长的回文序列长度是多少

状态转移方程
- 如果 s 的第 i 个字符和第 j 个字符相同的话

- $dp[i][j] = dp[i + 1][j - 1] + 2$

- 如果 s 的第 i 个字符和第 j 个字符不同的话

- $dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])$ 

 `i` 从最后一个字符开始往前遍历，`j` 从 `i + 1` 开始往后遍历

```python
class Solution:
    def longestPalindromeSubseq(self, s: str) -> int:
        N = len(s)
        dp = [[0 for _ in range(N)] for _ in range(N)]

        for i in range(N):
            dp[i][i] = 1

        for i in range(N - 1, -1, -1):
            for j in range(i + 1, N):

                if s[i] == s[j]:
                    dp[i][j] = dp[i + 1][j - 1] + 2
                else:

                    dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])
        return dp[0][N - 1]
```

