# LeetCode: 361. 轰炸敌人

[TOC]

## 1、题目描述

想象一下炸弹人游戏，在你面前有一个二维的网格来表示地图，网格中的格子分别被以下三种符号占据：

-   `'W'` 表示一堵墙
-   `'E'` 表示一个敌人
-   `'0'`（数字 `0`）表示一个空位

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-20-130307.gif)


请你计算一个炸弹最多能炸多少敌人。

由于炸弹的威力不足以穿透墙体，炸弹只能炸到同一行和同一列没被墙体挡住的敌人。

注意：你只能把炸弹放在一个空的格子里

**示例:**

```
输入: [["0","E","0","0"],["E","0","W","E"],["0","E","0","0"]]
输出: 3 
解释: 对于如下网格

0 E 0 0 
E 0 W E 
0 E 0 0

假如在位置 (1,1) 放置炸弹的话，可以炸到 3 个敌人


```



## 2、解题思路

-   动态规划

从左上角到右下角扫描一遍，找出每个点能够对左上的杀伤力

从右下角到左上角扫描一遍，找出每个点能够对右下的杀伤力





```python
class Solution:
    def maxKilledEnemies(self, grid: List[List[str]]) -> int:
        if not grid:
            return 0
        row, col = len(grid), len(grid[0])
        dp = [[[0, 0, 0, 0] for _ in range(col)] for _ in range(row)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        #  [0, 0, 0, 0]
        # 左 上 右 下

        ans = 0

        for i in range(row):
            for j in range(col):
                up = [i - 1, j]
                left = [i, j - 1]
                if grid[i][j] == "W":
                    continue
                if available(*up):
                    dp[i][j][1] = dp[up[0]][up[1]][1]
                if available(*left):
                    dp[i][j][0] = dp[left[0]][left[1]][0]
                if grid[i][j] == "E":
                    dp[i][j][1] += 1
                    dp[i][j][0] += 1

        for i in range(row - 1, -1, -1):
            for j in range(col - 1, -1, -1):
                if grid[i][j] == "W":
                    continue
                right = [i, j + 1]
                bottom = [i + 1, j]
                if available(*right):
                    dp[i][j][2] = dp[right[0]][right[1]][2]
                if available(*bottom):
                    dp[i][j][3] = dp[bottom[0]][bottom[1]][3]
                if grid[i][j] == "E":
                    dp[i][j][2] += 1
                    dp[i][j][3] += 1
                if grid[i][j] == "0":
                    ans = max(ans, sum(dp[i][j]))

        return ans
```

