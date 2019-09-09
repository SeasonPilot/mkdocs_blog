# LeetCode: 835. 图像重叠

[TOC]

## 1、题目描述

给出两个图像 `A` 和 `B` ，`A` 和 `B` 为大小相同的二维正方形矩阵。（并且为二进制矩阵，只包含`0`和`1`）。

我们转换其中一个图像，向左，右，上，或下滑动任何数量的单位，并把它放在另一个图像的上面。之后，该转换的重叠是指两个图像都具有 `1` 的位置的数目。

（请注意，转换不包括向任何方向旋转。）

最大可能的重叠是什么？

**示例 1:**

```
输入：A = [[1,1,0],
          [0,1,0],
          [0,1,0]]
     B = [[0,0,0],
          [0,1,1],
          [0,0,1]]
输出：3
解释: 将 A 向右移动一个单位，然后向下移动一个单位。
```


**注意:** 

- `1 <= A.length = A[0].length = B.length = B[0].length <= 30`
- `0 <= A[i][j], B[i][j] <= 1`



## 2、解题思路

- 采取固定一个移动另一个的形式进行遍历
  - 固定B，A分别向右和向下移动
  - 固定A，B分别向右和向下移动

```python
import numpy as np


class Solution:
    def largestOverlap(self, A: List[List[int]], B: List[List[int]]) -> int:
        length = len(A)
        a = np.array(A)
        b = np.array(B)

        res = 0

        for i in range(length):
            for j in range(length):
                temp_a = sum(sum(a[0:length - i, 0:length - j] * b[i:length, j:length]))
                temp_b = sum(sum(b[0:length - i, 0:length - j] * a[i:length, j:length]))

                res = max(res, temp_a, temp_b)

        return res

```

