# LeetCode: 72. 编辑距离

[TOC]

## 1、题目描述

给定两个单词 word1 和 word2，计算出将 word1 转换成 word2 所使用的最少操作数 。

你可以对一个单词进行如下三种操作：

插入一个字符
删除一个字符
替换一个字符
**示例 1:**

```
输入: word1 = "horse", word2 = "ros"
输出: 3
解释: 
horse -> rorse (将 'h' 替换为 'r')
rorse -> rose (删除 'r')
rose -> ros (删除 'e')
```



**示例 2:**

```
输入: word1 = "intention", word2 = "execution"
输出: 5
解释: 
intention -> inention (删除 't')
inention -> enention (将 'i' 替换为 'e')
enention -> exention (将 'n' 替换为 'x')
exention -> exection (将 'n' 替换为 'c')
exection -> execution (插入 'u')
```



## 2、解题思路

- 使用动态规划

- 设置一个二维数组，横纵坐标，i，j 分别表示i的字符串转换到j的字符串所花的最小的距离
- 我们首先来确认一下转换方程

```
dp[i][j]     ==> 代表i长度的字符串转换到j长度所花的距离
dp[i-1][j]   ==> 代表i-1长度的字符串转换到j长度所花的距离
dp[i][j-1]   ==> 代表i长度的字符串转换到j-1长度所花的距离
dp[i-1][j-1]   ==> 代表i-1长度的字符串转换到j-1长度所花的距离
```

如上所示，那么经过什么操作，`dp[i-1][j]才能够变换到dp[i][j]`呢？

```
dp[i-1][j]       ==>    dp[i][j]
		只需要将i的最后一个字符删除，这样就得到了i-1，因此就能够通过dp[i-1][j]得到dp[i][j]
		所以，dp[i][j] = dp[i-1][j] +1

dp[i][j-1]       ==>    dp[i][j]
		i长度的字符串得到的是j-1，因此，我们只需要在i之后添加一个j字符串最后一个相同的字符，就得到了j
		所以，dp[i][j] = dp[i][j-1] +1
		
dp[i-1][j-1]     ==>    dp[i][j]
		这一个较为特殊，假设i的最后一个字符和j的最后一个字符是相同的，那么不需要变化，
		i[-1] == j[-1]
		dp[i][j] = dp[i-1][j-1]
		如果不相同，那么i的最后一个字符只需要进行一次变换，就得到了j
		i[-1] != j[-1]
		dp[i][j] = dp[i-1][j-1] +1
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
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1
        return dp[length_word1][length_word2]
```

