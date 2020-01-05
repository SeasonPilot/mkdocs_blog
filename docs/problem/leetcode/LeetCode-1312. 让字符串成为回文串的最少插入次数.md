# LeetCode: 1312. 让字符串成为回文串的最少插入次数

[TOC]

## 1、题目描述

给你一个字符串 `s` ，每一次操作你都可以在字符串的任意位置插入任意字符。

请你返回让 `s` 成为回文串的 **最少操作次数** 。

「回文串」是正读和反读都相同的字符串。

 

**示例 1：**

```
输入：s = "zzazz"
输出：0
解释：字符串 "zzazz" 已经是回文串了，所以不需要做任何插入操作。
```

**示例 2：**

```
输入：s = "mbadm"
输出：2
解释：字符串可变为 "mbdadbm" 或者 "mdbabdm" 。
```

**示例 3：**

```
输入：s = "leetcode"
输出：5
解释：插入 5 个字符后字符串变为 "leetcodocteel" 。
```

**示例 4：**

```
输入：s = "g"
输出：0
```

**示例 5：**

```
输入：s = "no"
输出：1
```

 

**提示：**

-   `1 <= s.length <= 500`
-   `s` 中所有字符都是小写字母。



## 2、解题思路

-   动态规划

初始化：

```
dp[i][j] 表示从i到j最短需要插入多少字符
```

状态转换：

```python
if i == j:
    dp[i][j] = 0
else:
    if s[i] == s[j]:
        if i + 1 == j:
            dp[i][j] = 0
        else:
            dp[i][j] = dp[i + 1][j - 1]
    else:
        if i + 1 == j:
            dp[i][j] = 1
        else:
            dp[i][j] = min(dp[i + 1][j] + 1, dp[i][j - 1] + 1, dp[i + 1][j - 1] + 2)
```



```python
class Solution:
    def minInsertions(self, s: str) -> int:

        length = len(s)
        if length <= 1:
            return 0

        dp = [[length for _ in range(length)] for _ in range(length)]
        for gap in range(length - 1):
            for i in range(length - gap):
                j = i + gap
                if i == j:
                    dp[i][j] = 0
                else:
                    if s[i] == s[j]:
                        if i + 1 == j:
                            dp[i][j] = 0
                        else:
                            dp[i][j] = dp[i + 1][j - 1]
                    else:
                        if i + 1 == j:
                            dp[i][j] = 1
                        else:
                            dp[i][j] = min(dp[i + 1][j] + 1, dp[i][j - 1] + 1, dp[i + 1][j - 1] + 2)

        if length - 1 == 1:
            if s[0] == s[length - 1]:
                return 0
            else:
                return 1
        else:
            if s[0] == s[length - 1]:
                return dp[1][length - 2]
            else:
                return min(dp[0][length - 2] + 1, dp[1][length - 1] + 1, dp[1][length - 2] + 2)

```

