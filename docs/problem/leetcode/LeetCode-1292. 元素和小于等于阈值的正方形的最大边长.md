# LeetCode: 1292. 元素和小于等于阈值的正方形的最大边长

[TOC]

## 1、题目描述

给你一个大小为 `m x n` 的矩阵 `mat` 和一个整数阈值 `threshold`。

请你返回元素总和小于或等于阈值的正方形区域的最大边长；如果没有这样的正方形区域，则返回 **0** 。
 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-15-064329.png)

```
输入：mat = [[1,1,3,2,4,3,2],[1,1,3,2,4,3,2],[1,1,3,2,4,3,2]], threshold = 4
输出：2
解释：总和小于 4 的正方形的最大边长为 2，如图所示。
```

**示例 2：**

```
输入：mat = [[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2],[2,2,2,2,2]], threshold = 1
输出：0
```

**示例 3：**

```
输入：mat = [[1,1,1,1],[1,0,0,0],[1,0,0,0],[1,0,0,0]], threshold = 6
输出：3
```

**示例 4：**

```
输入：mat = [[18,70],[61,1],[25,85],[14,40],[11,96],[97,96],[63,45]], threshold = 40184
输出：2
```

 

**提示：**

-   `1 <= m, n <= 300`
-   `m == mat.length`
-   `n == mat[i].length`
-   `0 <= mat[i][j] <= 10000`
-   `0 <= threshold <= 10^5`

## 2、解题思路

-   二分法

-   首先计算出当前节点到左上角矩形节点之和

-   最小边长为0，最大为长和宽的最小值

-   然后采用二分法查找，判断依据为当前边长是否找到满足阈值的正方形

    

```python
class Solution:
    def maxSideLength(self, mat: List[List[int]], threshold: int) -> int:
        row, col = len(mat), len(mat[0])
        areas = [[0 for _ in range(col + 1)] for _ in range(row + 1)]

        for i in range(1, 1 + row):
            for j in range(1, 1 + col):
                areas[i][j] = mat[i - 1][j - 1] + areas[i - 1][j] + areas[i][j - 1] - areas[i - 1][j - 1]

        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        def check(edges):
            for i in range(row):
                for j in range(col):
                    ni, nj = i + edges - 1, j + edges - 1
                    if available(ni, nj):
                        areas_x, areas_y = ni + 1, nj + 1
                        if areas[areas_x][areas_y] - areas[areas_x - edges][areas_y] - areas[areas_x][areas_y - edges] + areas[areas_x - edges][
                            areas_y - edges] <= threshold:
                            return True
            return False

        left = 0
        right = min(row, col)

        while left < right:
            mid = (left + right) // 2 + 1
            if check(mid):
                left = mid
            else:
                right = mid - 1
        return left

```

