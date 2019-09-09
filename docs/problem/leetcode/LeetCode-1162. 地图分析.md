# LeetCode: 1162. 地图分析

[TOC]

## 1、题目描述

你现在手里有一份大小为 `N x N` 的『地图』（网格） `grid`，上面的每个『区域』（单元格）都用 `0` 和 `1` 标记好了。其中 `0` 代表海洋，`1` 代表陆地，你知道距离陆地区域最远的海洋区域是是哪一个吗？请返回该海洋区域到离它最近的陆地区域的距离。

我们这里说的距离是『曼哈顿距离』`（ Manhattan Distance）`：`(x0, y0)` 和 `(x1, y1)` 这两个区域之间的距离是 `|x0 - x1| + |y0 - y1|` 。

如果我们的地图上只有陆地或者海洋，请返回 `-1`。

 

**示例 1：**

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-09-034453.jpg)

```
输入：[[1,0,1],[0,0,0],[1,0,1]]
输出：2
解释： 
海洋区域 (1, 1) 和所有陆地区域之间的距离都达到最大，最大距离为 2。
```

**示例 2：**

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-09-034459.jpg)

```
输入：[[1,0,0],[0,0,0],[0,0,0]]
输出：4
解释： 
海洋区域 (2, 2) 和所有陆地区域之间的距离都达到最大，最大距离为 4。
```

**提示：**

- `1 <= grid.length == grid[0].length <= 100`
- `grid[i][j] 不是 0 就是 1`



## 2、解题思路

- 使用动态规划

- 两遍扫描

- 第一遍从左上角开始扫描

  - 判断是否是陆地，如果是陆地，距离更新为0
  - 如果是海洋，判断上面和左面是不是陆地，更新到陆地的最小距离

- 第二遍从右下角扫描

  - 如果是海洋，判断右面和下面是不是陆地，更新到陆地的最小距离
  - 更新海洋到陆地的最大距离

  

```python
class Solution:
    def maxDistance(self, grid: List[List[int]]) -> int:
        
        
        inf = float('inf')
        row, col = len(grid), len(grid[0])
        distance = [[inf for _ in range(col)] for _ in range(row)]

        min_island = -1

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for i in range(row):
            for j in range(col):
                if grid[i][j] == 1:
                    distance[i][j] = 0
                else:
                    top, left = inf, inf
                    if available(i - 1, j):
                        if distance[i - 1][j] != inf and distance[i - 1][j] >= 0:
                            top = distance[i - 1][j] + 1
                    if available(i, j - 1):
                        if distance[i][j - 1] != inf and distance[i ][j - 1] >= 0:
                            left = distance[i][j - 1] + 1
                    distance[i][j] = min(top, left)
        for i in range(row - 1, -1, -1):
            for j in range(col - 1, -1, -1):
                if grid[i][j] == 0:
                    right, bottom = inf, inf

                    if available(i, j + 1):
                        if distance[i][j + 1] != inf and distance[i][j + 1] >= 0:
                            right = distance[i][j + 1] + 1
                    if available(i + 1, j):
                        if distance[i + 1][j] != inf and distance[i + 1][j] >= 0:
                            bottom = distance[i + 1][j] + 1

                    distance[i][j] = min(distance[i][j], right, bottom)

                    if distance[i][j] != inf:
                        min_island = max(min_island, distance[i][j])
        return min_island if min_island != inf else -1
```

