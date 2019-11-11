# LeetCode: 1252. 奇数值单元格的数目

[TOC]

## 1、题目描述

给你一个 `n` 行 `m` 列的矩阵，最开始的时候，每个单元格中的值都是 `0`。

另有一个索引数组 `indices，indices[i] = [ri, ci]` 中的 `ri` 和 `ci` 分别表示指定的行和列（从 `0` 开始编号）。

你需要将每对 `[ri, ci]` 指定的行和列上的所有单元格的值加 `1`。

请你在执行完所有 `indices` 指定的增量操作后，返回矩阵中 「奇数值单元格」 的数目。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-11-060728.png)

```
输入：n = 2, m = 3, indices = [[0,1],[1,1]]
输出：6
解释：最开始的矩阵是 [[0,0,0],[0,0,0]]。
第一次增量操作后得到 [[1,2,1],[0,1,0]]。
最后的矩阵是 [[1,3,1],[1,3,1]]，里面有 6 个奇数。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-11-060737.png)

```
输入：n = 2, m = 2, indices = [[1,1],[0,0]]
输出：0
解释：最后的矩阵是 [[2,2],[2,2]]，里面没有奇数。
```

**提示：**

-   $1 <= n <= 50$
-   $1 <= m <= 50$
-   $1 <= indices.length <= 100$
-   $0 <= indices[i][0] < n$
-   $0 <= indices[i][1] < m$



## 2、解题思路

-   针对每一个点，能够增加1的情况就是行和列包括这个点的横纵坐标，只需要统计出这个点横纵坐标被包含了多少次就得到最终的值



```python
from collections import defaultdict


class Solution:
    def oddCells(self, n: int, m: int, indices: List[List[int]]) -> int:
        ans = 0

        rows = defaultdict(int)
        cols = defaultdict(int)
        for x, y in indices:
            rows[x] += 1
            cols[y] += 1
        for i in range(n):
            for j in range(m):
                if rows[i] + cols[j] & 1:
                    ans += 1
        return ans
```

