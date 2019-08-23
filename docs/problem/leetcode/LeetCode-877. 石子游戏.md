# LeetCode: 877. 石子游戏

[TOC]

## 1、题目描述

亚历克斯和李用几堆石子在做游戏。偶数堆石子排成一行，每堆都有正整数颗石子 `piles[i]` 。

游戏以谁手中的石子最多来决出胜负。石子的总数是奇数，所以没有平局。

亚历克斯和李轮流进行，亚历克斯先开始。 每回合，玩家从行的开始或结束处取走整堆石头。 这种情况一直持续到没有更多的石子堆为止，此时手中石子最多的玩家获胜。

假设亚历克斯和李都发挥出最佳水平，当亚历克斯赢得比赛时返回 `true` ，当李赢得比赛时返回 `false` 。



**示例：**

```
输入：[5,3,4,5]
输出：true
解释：
亚历克斯先开始，只能拿前 5 颗或后 5 颗石子 。
假设他取了前 5 颗，这一行就变成了 [3,4,5] 。
如果李拿走前 3 颗，那么剩下的是 [4,5]，亚历克斯拿走后 5 颗赢得 10 分。
如果李拿走后 5 颗，那么剩下的是 [3,4]，亚历克斯拿走后 4 颗赢得 9 分。
这表明，取前 5 颗石子对亚历克斯来说是一个胜利的举动，所以我们返回 true 。
```

**提示：**

-  $2 <= piles.length <= 500$ 
- `piles.length` 是偶数。
-  $1 <= piles[i] <= 500$ 
- `sum(piles)` 是奇数。

## 2、解题思路

- 使用动态规划

- `dp[i][j]`表示先手在i到j的范围中比对手多的分数

- 初始化：

  - `dp[i][i]` 为对应石头的值

- 状态转移方程：

  - `dp[i][j] = max(piles[i]-dp[i+1][j],piles[i]-dp[i][j-1])`
  - 需要注意的是，为了保证方程状态的正确性，`i`需要从大到小递减，因为`j`的更新是比`i`大的，所以这样能保证后续用到的值都是更新过的

  

```python
class Solution:
    def stoneGame(self, piles: List[int]) -> bool:
        length = len(piles)
        dp = [[0 for _ in range(length)] for _ in range(length)]

        for i in range(length):
            dp[i][i] = piles[i]

        for i in range(length - 1, -1, -1):
            for j in range(i + 1, length):
                dp[i][j] = max(piles[i] - dp[i + 1][j], piles[j] - dp[i][j - 1])
        return dp[0][length - 1] > 0
```

