# LeetCode: 562. 矩阵中最长的连续1线段

[TOC]

## 1、题目描述

给定一个`01`矩阵 `M`，找到矩阵中最长的连续`1`线段。这条线段可以是水平的、垂直的、对角线的或者反对角线的。

**示例:**

```
输入:
[[0,1,1,0],
 [0,1,1,0],
 [0,0,0,1]]
输出: 3
```

`提示:` 给定矩阵中的元素数量不会超过 `10,000`。



## 2、解题思路

-   动态规划

-   每个节点保存四个值
    -   向上连续
    -   向左上连续
    -   向左连续
    -   向右上连续

更新`4`个值即可

```python
class Solution:
    def longestLine(self, M: List[List[int]]) -> int:
        if not M:
            return 0
        row, col = len(M), len(M[0])
        dp = [[[0, 0, 0, 0] for _ in range(col)] for _ in range(row)]
        ans = 0

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for i in range(row):
            for j in range(col):
                left_up = [i - 1, j - 1]
                up = i - 1, j
                left = i, j - 1
                if M[i][j] == 1:
                    dp[i][j] = [1, 1, 1, 1]
                    if available(*left_up):
                        dp[i][j][1] += dp[i - 1][j - 1][1]
                    if available(*up):
                        dp[i][j][0] += dp[i - 1][j][0]
                    if available(*left):
                        dp[i][j][2] += dp[i][j - 1][2]

        for i in range(row):
            for j in range(col - 1, -1, -1):
                if M[i][j] == 1 and available(i - 1, j + 1):
                    dp[i][j][3] = dp[i - 1][j + 1][3] + 1
                ans = max(ans, max(dp[i][j]))
        return ans

```

