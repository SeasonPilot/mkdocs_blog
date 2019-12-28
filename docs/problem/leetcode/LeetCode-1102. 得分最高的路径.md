# LeetCode: 1102. 得分最高的路径

[TOC]

## 1、题目描述

给你一个 `R` 行 `C` 列的整数矩阵 `A`。矩阵上的路径从 `[0,0]` 开始，在 `[R-1,C-1]` 结束。

路径沿四个基本方向（上、下、左、右）展开，从一个已访问单元格移动到任一相邻的未访问单元格。

路径的得分是该路径上的 最小 值。例如，路径 `8 →  4 →  5 →  9` 的值为 `4` 。

找出所有路径中得分 最高 的那条路径，返回其 得分。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-28-133409.jpg)

```
输入：[[5,4,5],[1,2,6],[7,4,6]]
输出：4
解释： 
得分最高的路径用黄色突出显示。 
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-28-133418.jpg)

```
输入：[[2,2,1,2,2,2],[1,2,2,2,1,2]]
输出：2
```


**示例 3：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-28-133426.jpg)

```
输入：[[3,4,6,3,4],[0,2,1,1,7],[8,8,3,2,7],[3,2,4,9,8],[4,1,2,0,0],[4,6,5,4,3]]
输出：3
```

**提示：**

-   $1 <= R, C <= 100$
-   $0 <= A[i][j] <= 10^9$



## 2、解题思路

-   使用并查集
-   首先将可能的路径进行排序，每条路径连接两个点，路径值就是这两个点之间的最小值
-   判断左上节点和右下节点能够在一个集合的时候，返回当前的路径值



```python
from typing import List


class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def maximumMinimumPath(self, A: List[List[int]]) -> int:
        row, col = len(A), len(A[0])
        if row == 1 and col == 1:
            return A[0][0]
        paths = []
        d = DFU(row * col)
        start = 0
        end = row * col - 1
        for i in range(row):
            for j in range(col):
                if i - 1 >= 0:
                    paths.append([min(A[i][j], A[i - 1][j]), i * col + j, (i - 1) * col + j])
                if j - 1 >= 0:
                    paths.append([min(A[i][j], A[i][j - 1]), i * col + j, i * col + j - 1])
        for val, x, y in sorted(paths, reverse=True):
            if d.find(x) != d.find(y):
                d.union(x, y)
            if d.find(start) == d.find(end):
                return val

```

