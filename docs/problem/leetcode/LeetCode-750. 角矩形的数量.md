# LeetCode: 750. 角矩形的数量

[TOC]

## 1、题目描述

给定一个只包含 `0` 和 `1` 的网格，找出其中角矩形的数量。

一个 角矩形 是由四个不同的在网格上的 `1` 形成的轴对称的矩形。注意只有角的位置才需要为 `1`。并且，`4` 个 `1` 需要是不同的。

 

**示例 1：**

```
输入：grid = 
[[1, 0, 0, 1, 0],
 [0, 0, 1, 0, 1],
 [0, 0, 0, 1, 0],
 [1, 0, 1, 0, 1]]
输出：1
解释：只有一个角矩形，角的位置为 grid[1][2], grid[1][4], grid[3][2], grid[3][4]。
```

**示例 2：**

```
输入：grid = 
[[1, 1, 1],
 [1, 1, 1],
 [1, 1, 1]]
输出：9
解释：这里有 4 个 2x2 的矩形，4 个 2x3 和 3x2 的矩形和 1 个 3x3 的矩形。
```

**示例 3：**

```
输入：grid = 
[[1, 1, 1, 1]]
输出：0
解释：矩形必须有 4 个不同的角。
```

**注：**

-   网格 `grid` 中行和列的数目范围为 `[1, 200]`。
-   `Each grid[i][j] will be either 0 or 1.`
-   网格中 `1` 的个数不会超过 `6000`。




## 2、解题思路

-   找出不同列的组合，两个点都为以的行的个数，然后找出两两组合的数量

```
例如
[[1, 0, 0, 1, 0],
 [0, 0, 1, 0, 1],
 [0, 0, 0, 1, 0],
 [1, 0, 1, 0, 1]]
 
 找出 第0列和第一列都为1的行数  ： 0

```



```python
import math
from itertools import combinations


class Solution:
    def countCornerRectangles(self, grid: List[List[int]]) -> int:
        if len(grid) < 2 or len(grid[0]) < 2:
            return 0
        row, col = len(grid), len(grid[0])
        ans = 0

        def comb(n, m):
            return math.factorial(n) // (math.factorial(n - m) * math.factorial(m))

        for x, y in combinations(range(col), 2):
            cur_count = 0
            for r in range(row):
                if grid[r][x] == 1 and grid[r][y] == 1:
                    cur_count += 1
            if cur_count >= 2:
                ans += comb(cur_count, 2)
        return ans

```



-   借助集合，找出组合数量

```python
from collections import defaultdict


class Solution:
    def countCornerRectangles(self, grid: List[List[int]]) -> int:
        if len(grid) < 2 or len(grid[0]) < 2:
            return 0
        row, col = len(grid), len(grid[0])
        ans = 0

        cols = defaultdict(set)
        for i in range(row):
            for j in range(col):
                if grid[i][j] == 1:
                    cols[i].add(j)

        for i in range(row):
            for j in range(i + 1, row):
                current = len(cols[i].intersection(cols[j]))
                ans += current * (current - 1) // 2
        return ans
```

