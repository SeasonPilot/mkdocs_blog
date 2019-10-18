# LeetCode: 1139. 最大的以 1 为边界的正方形

[TOC]

## 1、题目描述

给你一个由若干 `0` 和 `1` 组成的二维网格 `grid`，请你找出边界全部由 `1` 组成的最大 正方形 子网格，并返回该子网格中的元素数量。如果不存在，则返回 `0`。

 

**示例 1：**

```
输入：grid = [[1,1,1],[1,0,1],[1,1,1]]
输出：9
```

**示例 2：**

```
输入：grid = [[1,1,0,0]]
输出：1
```

**提示：**

-   `1 <= grid.length <= 100`
-   `1 <= grid[0].length <= 100`
-   `grid[i][j] 为 0 或 1`



## 2、解题思路

-   首先找出当前位置到上和到左方向的最大的连续1的个数
-   然后找出当前位置到右和到下方向的最大的连续1的个数
-   判断能否围成正方形，可以则更新结果



```python
class Solution:
    def largest1BorderedSquare(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])
        ans = 0

        dp = [[[0, 0, 0, 0] for _ in range(col + 2)] for _ in range(row + 2)]
        # 左 上 右 下

        for i in range(row):
            for j in range(col):
                if grid[i][j]:
                    dp[i + 1][j + 1][0] = dp[i + 1][j][0] + 1
                    dp[i + 1][j + 1][1] = dp[i][j + 1][1] + 1
        for i in range(row - 1, -1, -1):
            for j in range(col - 1, -1, -1):
                if grid[i][j]:
                    dp[i + 1][j + 1][2] = dp[i + 1][j + 2][2] + 1
                    dp[i + 1][j + 1][3] = dp[i + 2][j + 1][3] + 1

                    min_edge = min(dp[i + 1][j + 1][2:])

                    for edge in range(min_edge):
                        if min(dp[i + 1 + edge][j + 1 + edge][:2]) > edge:
                            ans = max(ans, (edge + 1) ** 2)
        return ans
```

