# LeetCode: 861. 翻转矩阵后的得分

[TOC]

## 1、题目描述

有一个二维矩阵 A 其中每个元素的值为 0 或 1 。

移动是指选择任一行或列，并转换该行或列中的每一个值：将所有 0 都更改为 1，将所有 1 都更改为 0。

在做出任意次数的移动后，将该矩阵的每一行都按照二进制数来解释，矩阵的得分就是这些数字的总和。

返回尽可能高的分数。

 

**示例：**

```
输入：[[0,0,1,1],[1,0,1,0],[1,1,0,0]]
输出：39
解释：
转换为 [[1,1,1,1],[1,0,0,1],[1,1,1,1]]
0b1111 + 0b1001 + 0b1111 = 15 + 9 + 15 = 39
```

提示：**

- `1 <= A.length <= 20`
- `1 <= A[0].length <= 20`
- `A[i][j] 是 0 或 1`

## 2、解题思路

- 分别进行行列翻转
- 行翻转
  - 如果最左侧的值为0，则进行翻转
- 列翻转
  - 如果每一列中0的数量大于1的数量，则进行翻转
- 最后进行加和统计

```python
class Solution:
    def matrixScore(self, A: List[List[int]]) -> int:
        row = len(A)
        col = len(A[0])

        def get_bin_value(l):
            res = 0
            for num in range(len(l)):
                if l[-1 - num]:
                    res += 1 << num
            return res

        # 行翻转
        for i in range(row):
            if not A[i][0]:
                for j in range(col):
                    A[i][j] = A[i][j] ^ 1

        # 列翻转
        for j in range(col):

            count = sum([A[x][j] for x in range(row)])
            if count < row / 2:
                for i in range(row):
                    A[i][j] = A[i][j] ^ 1

        # 求和
        ans = 0
        for i in range(row):
            ans += get_bin_value(A[i])

        return ans

```

