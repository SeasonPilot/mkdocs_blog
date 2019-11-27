# LeetCode: 85. 最大矩形

[TOC]

## 1、题目描述

给定一个仅包含 `0` 和 `1` 的二维二进制矩阵，找出只包含 `1` 的最大矩形，并返回其面积。

**示例:**

```
输入:
[
  ["1","0","1","0","0"],
  ["1","0","1","1","1"],
  ["1","1","1","1","1"],
  ["1","0","0","1","0"]
]
输出: 6
```



## 2、解题思路

-   借助84题的思路，每一行向上做一个类似于84题目一样的矩形，每一行使用这个函数求解最大矩形面积

    

```python
class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        if not matrix:
            return 0
        ans = 0
        row, col = len(matrix), len(matrix[0])

        dp = [[0 for _ in range(col)] for _ in range(row)]

        dp[0] = list(map(int, matrix[0]))

        for i in range(1, row):
            for j in range(col):
                if matrix[i][j] == "1":
                    dp[i][j] = dp[i - 1][j] + 1
        for r in dp:
            ans = max(ans, self.largestRectangleArea(r))
        return ans

    def largestRectangleArea(self, heights: List[int]) -> int:
        heights = [0] + heights + [0]

        stack = [0]
        res = 0

        for i in range(1, len(heights)):
            while heights[i] < heights[stack[-1]]:
                temp = stack.pop()
                res = max(res, (i - stack[-1] - 1) * heights[temp])
            stack.append(i)

        return res
```

