# LeetCode: 1140. 石子游戏 II

[TOC]

## 1、题目描述

亚历克斯和李继续他们的石子游戏。许多堆石子 排成一行，每堆都有正整数颗石子 `piles[i]`。游戏以谁手中的石子最多来决出胜负。

亚历克斯和李轮流进行，亚历克斯先开始。最初，`M = 1`。

在每个玩家的回合中，该玩家可以拿走剩下的 前 `X` 堆的所有石子，其中 `1 <= X <= 2M`。然后，`令 M = max(M, X)`。

游戏一直持续到所有石子都被拿走。

假设亚历克斯和李都发挥出最佳水平，返回亚历克斯可以得到的最大数量的石头。

 

**示例：**

```
输入：piles = [2,7,9,4,4]
输出：10
解释：
如果亚历克斯在开始时拿走一堆石子，李拿走两堆，接着亚历克斯也拿走两堆。在这种情况下，亚历克斯可以拿到 2 + 4 + 4 = 10 颗石子。 
如果亚历克斯在开始时拿走两堆石子，那么李就可以拿走剩下全部三堆石子。在这种情况下，亚历克斯可以拿到 2 + 7 = 9 颗石子。
所以我们返回更大的 10。 
```

**提示：**

- `1 <= piles.length <= 100`
- `1 <= piles[i] <= 10 ^ 4`



## 2、解题思路

- 深度优先搜索加记忆化

- 当前位置能取得的最大值为：

  - 当前位置到最后面的和值 - 后面位置能够取得的最大值

```
index = 1
while index <= 2 * M and current_pos + index <= length:
     res = max(res, sums[current_pos] - dfs(current_pos + index, max(M, index)))
     index += 1
```

如上，这个过程很多都是重复的，因此记忆化来降低复杂性



```python

class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        from itertools import accumulate
        from functools import lru_cache
        length = len(piles)
        sums = list(reversed(list(accumulate(reversed(piles)))))

        @lru_cache(None)
        def dfs(current_pos, M):
            res = 0

            index = 1
            while index <= 2 * M and current_pos + index <= length:
                res = max(res, sums[current_pos] - dfs(current_pos + index, max(M, index)))
                index += 1

            return res

        return dfs(0, 1)
```

