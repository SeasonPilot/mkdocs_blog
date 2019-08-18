# LeetCode: 498. 对角线遍历

[TOC]

## 1、题目描述

给定一个含有 M x N 个元素的矩阵（M 行，N 列），请以对角线遍历的顺序返回这个矩阵中的所有元素，对角线遍历如下图所示。

 

**示例:**

```
输入:
[
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]

输出:  [1,2,4,7,5,3,6,8,9]
```

**解释:**

 ![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/12/diagonal_traverse.png)

**说明:**

- 给定矩阵中的元素总数不会超过 100000 。

## 2、解题思路

- 右上与左下分两种情况判断
- 不断生成下一步的坐标

```python
class Solution:
    def findDiagonalOrder(self, matrix: List[List[int]]) -> List[int]:
        
        if not matrix or not matrix[0]:
            return []

        res = []
        # 右上
        direction = True

        ROW = len(matrix)
        COL = len(matrix[0])
        x = 0
        y = 0
        for i in range(ROW * COL):
            res.append(matrix[x][y])
            if direction:
                for index, (a, b) in enumerate([(x - 1, y + 1), (x, y + 1), (x + 1, y)]):
                    if 0 <= a < ROW and 0 <= b < COL:
                        x, y = a, b
                        direction = not direction if index else direction
                        break
            else:
                for index, (a, b) in enumerate([(x + 1, y - 1), (x + 1, y), (x, y + 1)]):
                    if 0 <= a < ROW and 0 <= b < COL:
                        x, y = a, b
                        direction = not direction if index else direction
                        break

        return res
```

