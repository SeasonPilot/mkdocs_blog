# LeetCode: 583. 两个字符串的删除操作

[TOC]

## 1、题目描述

给定两个单词 `word1` 和 `word2`，找到使得 `word1` 和 `word2` 相同所需的最小步数，每步可以删除任意一个字符串中的一个字符。

**示例 1:**

```
输入: "sea", "eat"
输出: 2
解释: 第一步将"sea"变为"ea"，第二步将"eat"变为"ea"
```

**说明:**

- `给定单词的长度不超过500。`
- `给定单词中的字符只含有小写字母。`



## 2、解题思路

- 动态规划
- 初始化

```
dp[i][j]  表示word1前面i个字符变成word2前面j个字符相同需要的操作数
```

- 状态转换方程

```
if word1[i - 1] == word2[j - 1]:
    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1] - 1) + 1
else:
    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1] + 1) + 1
```



```python
class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        length_word1 = len(word1)
        length_word2 = len(word2)

        if not length_word1 or not length_word2:
            return length_word1 + length_word2

        dp = [[0 for _ in range(length_word2 + 1)] for _ in range(length_word1 + 1)]
        
        for i in range(length_word1 + 1):
            dp[i][0] = i
        for i in range(length_word2 + 1):
            dp[0][i] = i
            
        for i in range(1, length_word1 + 1):
            for j in range(1, length_word2 + 1):

                if word1[i - 1] == word2[j - 1]:
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1] - 1) + 1
                else:
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1] + 1) + 1
        return dp[length_word1][length_word2]
```

