# LeetCode: 799. 香槟塔

[TOC]

## 1、题目描述

我们把玻璃杯摆成金字塔的形状，其中第一层有`1`个玻璃杯，第二层有`2`个，依次类推到第`100`层，每个玻璃杯`(250ml)`将盛有香槟。

从顶层的第一个玻璃杯开始倾倒一些香槟，当顶层的杯子满了，任何溢出的香槟都会立刻等流量的流向左右两侧的玻璃杯。当左右两边的杯子也满了，就会等流量的流向它们左右两边的杯子，依次类推。（当最底层的玻璃杯满了，香槟会流到地板上）

例如，在倾倒一杯香槟后，最顶层的玻璃杯满了。倾倒了两杯香槟后，第二层的两个玻璃杯各自盛放一半的香槟。在倒三杯香槟后，第二层的香槟满了 - 此时总共有三个满的玻璃杯。在倒第四杯后，第三层中间的玻璃杯盛放了一半的香槟，他两边的玻璃杯各自盛放了四分之一的香槟，如下图所示。

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-26-040736.png" alt="img" style="zoom:50%;" />

现在当倾倒了非负整数杯香槟后，返回第 `i` 行 `j` 个玻璃杯所盛放的香槟占玻璃杯容积的比例（`i` 和 `j`都从`0`开始）。

 

**示例 1:**

```
输入: poured(倾倒香槟总杯数) = 1, query_glass(杯子的位置数) = 1, query_row(行数) = 1
输出: 0.0
解释: 我们在顶层（下标是（0，0））倒了一杯香槟后，没有溢出，因此所有在顶层以下的玻璃杯都是空的。
```

**示例 2:**

```
输入: poured(倾倒香槟总杯数) = 2, query_glass(杯子的位置数) = 1, query_row(行数) = 1
输出: 0.5
解释: 我们在顶层（下标是（0，0）倒了两杯香槟后，有一杯量的香槟将从顶层溢出，位于（1，0）的玻璃杯和（1，1）的玻璃杯平分了这一杯香槟，所以每个玻璃杯有一半的香槟。
```

**注意:**

-   `poured 的范围[0, 10 ^ 9]。`
-   `query_glass 和query_row 的范围 [0, 99]。`



## 2、解题思路

-   dfs+记忆化

-   判断当前杯子流过的香槟有多少，就需知道上面流经上放的杯子的香槟的量，并且减去上方杯子本身的量



```python
from functools import lru_cache

class Solution:
    def champagneTower(self, poured: int, query_row: int, query_glass: int) -> float:

        @lru_cache()
        def dfs(i, j):
            if i == 0 and j == 0:
                return poured
            if j < 0 or j > i:
                return 0

            left = max(dfs(i - 1, j - 1) - 1, 0) / 2
            right = max(dfs(i - 1, j) - 1, 0) / 2
            return left + right

        ans = dfs(query_row, query_glass)

        return min(1.0, ans)
```

