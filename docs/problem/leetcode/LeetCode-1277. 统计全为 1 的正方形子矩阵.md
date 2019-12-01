# LeetCode: 1277. 统计全为 1 的正方形子矩阵

[TOC]

## 1、题目描述

给你一个 `m * n` 的矩阵，矩阵中的元素不是 `0` 就是 `1`，请你统计并返回其中完全由 `1` 组成的 正方形 子矩阵的个数。

 

**示例 1：**

```
输入：matrix =
[
  [0,1,1,1],
  [1,1,1,1],
  [0,1,1,1]
]
输出：15
解释： 
边长为 1 的正方形有 10 个。
边长为 2 的正方形有 4 个。
边长为 3 的正方形有 1 个。
正方形的总数 = 10 + 4 + 1 = 15.
```


**示例 2：**

```
输入：matrix = 
[
  [1,0,1],
  [1,1,0],
  [1,1,0]
]
输出：7
解释：
边长为 1 的正方形有 6 个。 
边长为 2 的正方形有 1 个。
正方形的总数 = 6 + 1 = 7.
```

**提示：**

-   $1 <= arr.length <= 300$
-   $1 <= arr[0].length <= 300$
-   $0 <= arr[i][j] <= 1$



## 2、解题思路

-   使用动态规划

初始化

```
dp[i][j]表示从i，j向左上角能够形成的最大的正方形的边长

这个边长也代表了这个点对整体正方形个数的增益，也就是以当前点为右下角的点的情况下，能够形成的正方形的个数，如果边长为3，表示能够形成边长为1，2，3的3个正方形
```

状态转换方程

```
dp[i][j] = min(dp[up[0]][up[1]], dp[left[0]][left[1]], dp[up_left[0]][up_left[1]])+1
当前节点能够根据上方，左上方和左边三个点的情况判断当前点的最大边长
```



```python
class Solution:
    def countSquares(self, matrix: List[List[int]]) -> int:
        row, col = len(matrix), len(matrix[0])

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        dp = [[0 for _ in range(col)] for _ in range(row)]
        ans = 0
        for i in range(row):
            for j in range(col):
                if matrix[i][j]:
                    up = [i - 1, j]
                    left = [i, j - 1]
                    up_left = [i - 1, j - 1]
                    if available(*up_left):
                        dp[i][j] = min(dp[up[0]][up[1]], dp[left[0]][left[1]], dp[up_left[0]][up_left[1]])

                    dp[i][j] += 1
                ans += dp[i][j]
        return ans
```

