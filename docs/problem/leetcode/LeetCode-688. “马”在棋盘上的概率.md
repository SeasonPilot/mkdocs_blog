# LeetCode: 688. “马”在棋盘上的概率

[TOC]

## 1、题目描述

已知一个 `NxN` 的国际象棋棋盘，棋盘的行号和列号都是从 `0` 开始。即最左上角的格子记为 `(0, 0)`，最右下角的记为 `(N-1, N-1)`。 

现有一个 “马”（也译作 “骑士”）位于 `(r, c)` ，并打算进行 `K` 次移动。 

如下图所示，国际象棋的 “马” 每一步先沿水平或垂直方向移动 `2` 个格子，然后向与之相垂直的方向再移动 `1` 个格子，共有 `8` 个可选的位置。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-11-013532.png)

 

现在 “马” 每一步都从可选的位置（包括棋盘外部的）中独立随机地选择一个进行移动，直到移动了 `K` 次或跳到了棋盘外面。

求移动结束后，“马” 仍留在棋盘上的概率。

 

**示例：**

```
输入: 3, 2, 0, 0
输出: 0.0625
解释: 
输入的数据依次为 N, K, r, c
第 1 步时，有且只有 2 种走法令 “马” 可以留在棋盘上（跳到（1,2）或（2,1））。对于以上的两种情况，各自在第2步均有且只有2种走法令 “马” 仍然留在棋盘上。
所以 “马” 在结束后仍在棋盘上的概率为 0.0625。
```

**注意：**

-   `N 的取值范围为 [1, 25]`
-   `K 的取值范围为 [0, 100]`
-   `开始时，“马” 总是位于棋盘上`



## 2、解题思路

-   DFS+记忆化

从当前点像周围8个节点进行遍历，直到步数结束为止

保存中间结果，每个点在行走steps步后，保留在棋盘上面的概率

中间结果可以使用`lru_cache`缓存，也可以使用字典

```python
from functools import lru_cache


class Solution:
    def knightProbability(self, N: int, K: int, r: int, c: int) -> float:
        row, col = N, N

        def get_surround(x, y):
            surround = [(-2, -1), (-2, 1), (-1, -2), (1, -2), (2, -1), (2, 1), (-1, 2), (1, 2)]
            for dx, dy in surround:
                yield x + dx, y + dy

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        @lru_cache(None)
        def dfs(x, y, steps):
            one_part = 1 / 8

            if available(x, y):
                if steps <= 0:
                    return 1
                else:
                    ans = 0
                    for x1, y1 in get_surround(x, y):
                        ans += one_part * dfs(x1, y1, steps - 1)

                    return ans

            else:
                return 0

        return dfs(r, c, K)
```

