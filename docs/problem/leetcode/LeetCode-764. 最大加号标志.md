# LeetCode: 764. 最大加号标志

[TOC]

## 1、题目描述

在一个大小在 `(0, 0)` 到 `(N-1, N-1)` 的`2D`网格 `grid` 中，除了在 `mines` 中给出的单元为 `0`，其他每个单元都是 `1`。网格中包含 `1` 的最大的轴对齐加号标志是多少阶？返回加号标志的阶数。如果未找到加号标志，则返回 `0`。

一个 `k"` 阶由 `1` 组成的“轴对称”加号标志具有中心网格  `grid[x][y] = 1` ，以及`4`个从中心向上、向下、向左、向右延伸，长度为 `k-1`，由 `1` 组成的臂。下面给出 `k"` 阶“轴对称”加号标志的示例。注意，只有加号标志的所有网格要求为 `1`，别的网格可能为 `0` 也可能为 `1`。

 

**k 阶轴对称加号标志示例:**

```
阶 1:
000
010
000

阶 2:
00000
00100
01110
00100
00000

阶 3:
0000000
0001000
0001000
0111110
0001000
0001000
0000000
```

**示例 1：**

```
输入: N = 5, mines = [[4, 2]]
输出: 2
解释:

11111
11111
11111
11111
11011

在上面的网格中，最大加号标志的阶只能是2。一个标志已在图中标出。
```

**示例 2：**

```
输入: N = 2, mines = []
输出: 1
解释:

11
11

没有 2 阶加号标志，有 1 阶加号标志。
```

**示例 3：**

```
输入: N = 1, mines = [[0, 0]]
输出: 0
解释:

0

没有加号标志，返回 0 。
```

**提示：**

-   `整数N 的范围： [1, 500].`
-   `mines 的最大长度为 5000.`
-   `mines[i] 是长度为2的由2个 [0, N-1] 中的数组成.`
-   `(另外,使用 C, C++, 或者 C# 编程将以稍小的时间限制进行判断.)`



## 2、解题思路

-   题目的要求主要是求解每一个点上下左右最短的那个长度是多少，然后找出所有点中最长的
-   使用dp，左上扫描一次，右下扫描一次



```python
import itertools


class Solution:
    def orderOfLargestPlusSign(self, N: int, mines: List[List[int]]) -> int:
        dp = [[[0, 0, 0, 0] for _ in range(N)] for _ in range(N)]

        mines_set = set([tuple([x, y]) for x, y in mines])

        # 坐标验证
        def available(m, n):
            return 0 <= m < N and 0 <= n < N

        for i in range(N):
            for j in range(N):
                if (i, j) not in mines_set:
                    if available(i - 1, j):
                        dp[i][j][0] = dp[i - 1][j][0] + 1
                    else:
                        dp[i][j][0] = 1

                    if available(i, j - 1):
                        dp[i][j][1] = dp[i][j - 1][1] + 1
                    else:
                        dp[i][j][1] = 1

        for i in range(N - 1, -1, -1):
            for j in range(N - 1, -1, -1):
                if (i, j) not in mines_set:
                    if available(i + 1, j):
                        dp[i][j][2] = dp[i + 1][j][2] + 1
                    else:
                        dp[i][j][2] = 1

                    if available(i, j + 1):
                        dp[i][j][3] = dp[i][j + 1][3] + 1
                    else:
                        dp[i][j][3] = 1

        return max([min(node) for node in itertools.chain(*dp)])

```

