# LeetCode: 1260. 二维网格迁移

[TOC]

## 1、题目描述

给你一个 `n` 行 `m` 列的二维网格 `grid` 和一个整数 `k`。你需要将 `grid` 迁移 `k` 次。

每次「迁移」操作将会引发下述活动：

-   `位于 grid[i][j] 的元素将会移动到 grid[i][j + 1]。`
-   `位于 grid[i][m - 1] 的元素将会移动到 grid[i + 1][0]。`
-   `位于 grid[n - 1][m - 1] 的元素将会移动到 grid[0][0]。`

请你返回 `k` 次迁移操作后最终得到的 二维网格。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-17-101425.png)

```
输入：grid = [[1,2,3],[4,5,6],[7,8,9]], k = 1
输出：[[9,1,2],[3,4,5],[6,7,8]]
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-17-101433.png)

```
输入：grid = [[3,8,1,9],[19,7,2,5],[4,6,11,10],[12,0,21,13]], k = 4
输出：[[12,0,21,13],[3,8,1,9],[19,7,2,5],[4,6,11,10]]
```


**示例 3：**

```
输入：grid = [[1,2,3],[4,5,6],[7,8,9]], k = 9
输出：[[1,2,3],[4,5,6],[7,8,9]]
```

**提示：**

-   $1 <= grid.length <= 50$
-   $1 <= grid[i].length <= 50$
-   $-1000 <= grid[i][j] <= 1000$
-   $0 <= k <= 100$



## 2、解题思路

-   直接计算出移动到的目的位置反算出坐标即可



```python
class Solution:
    def shiftGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        row, col = len(grid), len(grid[0])
        length = row * col

        k %= length
        if k == 0:
            return grid

        ans = [[0 for _ in range(col)] for _ in range(row)]

        for i in range(row):
            for j in range(col):
                new_pos = (i * col + j + k) % length
                new_x = new_pos // col
                new_y = new_pos % col
                ans[new_x][new_y] = grid[i][j]

        return ans
    
```

