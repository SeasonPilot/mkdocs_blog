# LeetCode: 1351. 统计有序矩阵中的负数

[TOC]

## 1、题目描述



给你一个 `m * n` 的矩阵 `grid`，矩阵中的元素无论是按行还是按列，都以非递增顺序排列。 

请你统计并返回 `grid` 中 **负数** 的数目。

 

**示例 1：**

```
输入：grid = [[4,3,2,-1],[3,2,1,-1],[1,1,-1,-2],[-1,-1,-2,-3]]
输出：8
解释：矩阵中共有 8 个负数。
```

**示例 2：**

```
输入：grid = [[3,2],[1,0]]
输出：0
```

**示例 3：**

```
输入：grid = [[1,-1],[-1,-1]]
输出：3
```

**示例 4：**

```
输入：grid = [[-1]]
输出：1
```

 

**提示：**

-   `m == grid.length`
-   `n == grid[i].length`
-   `1 <= m, n <= 100`
-   `-100 <= grid[i][j] <= 100`



## 2、解题思路

-   因为是横向纵向都是递减的，因此，首先进行行遍历
-   找到第一个小于0的数字，记住这一列，这个点右下方的矩形所包括的点都不用判断，肯定小于0

```python
class Solution:
    def countNegatives(self, grid: List[List[int]]) -> int:

        row, col = len(grid), len(grid[0])
        ans = 0
        right_border = col
        for i in range(row):
            for j in range(col):
                if j >= right_border:
                    ans += col - j
                    break
                if grid[i][j] < 0:
                    ans += col - j
                    right_border = min(right_border, j)
                    break
        return ans
```

