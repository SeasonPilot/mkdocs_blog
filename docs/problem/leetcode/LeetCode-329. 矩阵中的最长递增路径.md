# LeetCode: 329. 矩阵中的最长递增路径

[TOC]

## 1、题目描述

给定一个整数矩阵，找出最长递增路径的长度。

对于每个单元格，你可以往上，下，左，右四个方向移动。 你不能在对角线方向上移动或移动到边界外（即不允许环绕）。

**示例 1:**

```
输入: nums = 
[
  [9,9,4],
  [6,6,8],
  [2,1,1]
] 
输出: 4 
解释: 最长递增路径为 [1, 2, 6, 9]。
```

**示例 2:**

```
输入: nums = 
[
  [3,4,5],
  [3,2,6],
  [2,2,1]
] 
输出: 4 
解释: 最长递增路径是 [3, 4, 5, 6]。注意不允许在对角线方向上移动。
```



## 2、解题思路

- 使用拓扑排序
- 将每个坐标映射为一个数值
- 使用字典记录每个节点指向的节点，以及当前节点的入度
- 初始化
  - 首先将所有入度为0的节点取出来
- 然后将入度为0的节点指向的节点的入度减一，如果度减少为0，放入临时数组中
- 不断地遍历，直到整个集合中没有入度为0的节点为止

**说明：**由于只有降序才能形成通路，所以不会有环路发生

```python
class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        from collections import defaultdict
        if not matrix:
            return 0
        row = len(matrix)
        col = len(matrix[0])
        # 上左-坐标
        surround = [(-1, 0), (0, -1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        out_degree = defaultdict(list)
        in_degree = defaultdict(int)

        d = []
        step = 0

        for i in range(row):
            for j in range(col):
                for dx, dy in surround:
                    base = i * col + j
                    if available(i + dx, j + dy):
                        base_diff = (i + dx) * col + j + dy
                        if matrix[i][j] > matrix[i + dx][j + dy]:
                            in_degree[base_diff] += 1
                            out_degree[base].append(base_diff)
                        elif matrix[i][j] < matrix[i + dx][j + dy]:
                            in_degree[base] += 1
                            out_degree[base_diff].append(base)

        for i in range(row * col):
            if in_degree[i] == 0:
                d.append(i)

        while d:
            temp = []
            for point in d:
                for t in out_degree[point]:
                    in_degree[t] -= 1
                    if in_degree[t] == 0:
                        temp.append(t)
            d = temp
            step += 1

        return step
```

