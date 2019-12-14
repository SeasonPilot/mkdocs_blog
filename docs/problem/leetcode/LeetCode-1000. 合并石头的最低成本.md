# LeetCode: 1000. 合并石头的最低成本

[TOC]

## 1、题目描述

有 `N` 堆石头排成一排，第 i 堆中有 `stones[i]` 块石头。

每次移动`（move）`需要将连续的 `K` 堆石头合并为一堆，而这个移动的成本为这 `K` 堆石头的总数。

找出把所有石头合并成一堆的最低成本。如果不可能，返回 `-1` 。

 

**示例 1：**

```
输入：stones = [3,2,4,1], K = 2
输出：20
解释：
从 [3, 2, 4, 1] 开始。
合并 [3, 2]，成本为 5，剩下 [5, 4, 1]。
合并 [4, 1]，成本为 5，剩下 [5, 5]。
合并 [5, 5]，成本为 10，剩下 [10]。
总成本 20，这是可能的最小值。
```


**示例 2：**

```
输入：stones = [3,2,4,1], K = 3
输出：-1
解释：任何合并操作后，都会剩下 2 堆，我们无法再进行合并。所以这项任务是不可能完成的。.
```


**示例 3：**

```
输入：stones = [3,5,1,2,6], K = 3
输出：25
解释：
从 [3, 5, 1, 2, 6] 开始。
合并 [5, 1, 2]，成本为 8，剩下 [3, 8, 6]。
合并 [3, 8, 6]，成本为 17，剩下 [17]。
总成本 25，这是可能的最小值。
```

**提示：**

-   $1 <= stones.length <= 30$
-   $2 <= K <= 30$
-   $1 <= stones[i] <= 100$



## 2、解题思路

-   动态规划

如果能够合并，那么第一次合并需要`K`个，剩余的合并仅需要`K-1`个，因此，如果能够合并为1个，因此满足下面的条件才可以：

-   `（length -1）%（K-1） ==0`

```
dp(i,j)表示需要计算的的范围

在[i，j]范围中，最后一次计算元素长度肯定恰好等于K，因此将当前范围分成左右两部分，将最小值取出来
然后判断当前的范围能否合并成一个元素，如果能够合并，就增加合并成本
```





```python
from itertools import accumulate
from functools import lru_cache


class Solution:
    def mergeStones(self, stones: List[int], K: int) -> int:
        length = len(stones)
        if (length - 1) % (K - 1):
            return -1
        prefix_sum = [0] + list(accumulate(stones))

        @lru_cache(None)
        def dfs(i, j):
            if j - i + 1 < K:
                return 0
            res = min(dfs(i, mid) + dfs(mid + 1, j) for mid in range(i, j, K - 1))
            if (j - i) % (K - 1) == 0:
                res += prefix_sum[j + 1] - prefix_sum[i]
            return res

        return dfs(0, length - 1)

```

