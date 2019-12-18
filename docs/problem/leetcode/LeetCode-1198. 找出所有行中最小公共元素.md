# LeetCode: 1198. 找出所有行中最小公共元素

[TOC]

## 1、题目描述

给你一个矩阵 `mat`，其中每一行的元素都已经按 **递增** 顺序排好了。请你帮忙找出在所有这些行中 **最小的公共元素**。

如果矩阵中没有这样的公共元素，就请返回 `-1`。

 

**示例：**

```
输入：mat = [[1,2,3,4,5],[2,4,5,8,10],[3,5,7,9,11],[1,3,5,7,9]]
输出：5
```

**提示：**

-   $1 <= mat.length, mat[i].length <= 500$
-   $1 <= mat[i][j] <= 10^4$
-   `mat[i]` 已按递增顺序排列。



## 2、解题思路

-   转换成找出第一个出现数量等于行数的数字



```python
from collections import defaultdict


class Solution:
    def smallestCommonElement(self, mat: List[List[int]]) -> int:
        count = defaultdict(int)

        row, col = len(mat), len(mat[0])
        for j in range(col):
            for i in range(row):
                cur = mat[i][j]
                count[cur] += 1
                if count[cur] == row:
                    return cur
        return -1
```

