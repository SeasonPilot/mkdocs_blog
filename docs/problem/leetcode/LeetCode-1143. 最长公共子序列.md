# LeetCode: 1143. 最长公共子序列

[TOC]

## 1、题目描述

给定两个字符串 `text1` 和 `text2`，返回这两个字符串的最长公共子序列。

一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。
例如，`"ace"` 是 `"abcde"` 的子序列，但 `"aec"` 不是 `"abcde"` 的子序列。两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。

若这两个字符串没有公共子序列，则返回 `0`。

**示例 1:**

```
Input: text1 = "abcde", text2 = "ace" 
Output: 3  
Explanation: 最长公共子序列是 "ace"，它的长度为 3。
```


**示例 2:**

```
Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: 最长公共子序列是 "abc"，它的长度为 3。
```


**示例 3:**

```
Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: 两个字符串没有公共子序列，返回 0。
```

**提示:**

-   `1 <= text1.length <= 1000`
-   `1 <= text2.length <= 1000`
-   `输入的字符串只含有小写英文字符。`



## 2、解题思路

-   动态规划
-   初始状态：

```
dp[i][j] 表示text1中前i个字符与text2中前j个字符能够匹配多少
```

-   状态转换方程

```
if text1[i - 1] == text2[j - 1]:
    dp[i][j] = dp[i - 1][j - 1] + 1
else:
    dp[i][j] = max(dp[i][j], dp[i][j - 1], dp[i - 1][j])
```



```python
class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        l1, l2 = len(text1), len(text2)
        dp = [[0 for _ in range(l2 + 1)] for _ in range(l1 + 1)]

        for i in range(1, l1 + 1):
            for j in range(1, l2 + 1):
                if text1[i - 1] == text2[j - 1]:
                    dp[i][j] = dp[i - 1][j - 1] + 1
                else:
                    dp[i][j] = max(dp[i][j], dp[i][j - 1], dp[i - 1][j])
        return dp[l1][l2]
```

