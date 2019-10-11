# LeetCode: 576. 出界的路径数

[TOC]

## 1、题目描述

给定一个 `m × n` 的网格和一个球。球的起始坐标为 `(i,j)` ，你可以将球移到相邻的单元格内，或者往上、下、左、右四个方向上移动使球穿过网格边界。但是，你最多可以移动 `N` 次。找出可以将球移出边界的路径数量。答案可能非常大，返回 结果 $mod\ 10^{9} + 7$ 的值。

 

**示例 1：**

```
输入: m = 2, n = 2, N = 2, i = 0, j = 0
输出: 6
解释:
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-11-020026.png)

**示例 2：**

```
输入: m = 1, n = 3, N = 3, i = 0, j = 1
输出: 12
解释:
```

 ![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-11-020001.png)

**说明:**

-   `球一旦出界，就不能再被移动回网格内。`
-   `网格的长度和高度在 [1,50] 的范围内。`
-   `N 在 [0,50] 的范围内。`



## 2、解题思路

-   本题与688题目相似，都可以采用DFS+记忆化的形式实现

同样的，记忆化采用`lru_cache`或者字典实现，本例采用`lru_cache`实现



```python
from functools import lru_cache


class Solution:
    def findPaths(self, m: int, n: int, N: int, i: int, j: int) -> int:
        mod_num = 1000000007

        row, col = m, n

        def get_surround(x, y):
            surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]
            for dx, dy in surround:
                yield x + dx, y + dy

        # 坐标验证
        def available(x_pos, y_pos):
            return 0 <= x_pos < row and 0 <= y_pos < col

        @lru_cache(None)
        def dfs(x, y, steps):

            if available(x, y):
                if steps <= 0:
                    return 0
                else:
                    ans = 0
                    for x1, y1 in get_surround(x, y):
                        ans += dfs(x1, y1, steps - 1)
                    return ans % mod_num
            else:
                return 1

        return dfs(i, j, N)
```

