# LeetCode: 526. 优美的排列

[TOC]

## 1、题目描述

假设有从 1 到 N 的 N 个整数，如果从这 N 个数字中成功构造出一个数组，使得数组的第 i 位 `(1 <= i <= N)` 满足如下两个条件中的一个，我们就称这个数组为一个优美的排列。条件：

- 第 i 位的数字能被 i 整除
- i 能被第 i 位上的数字整除

现在给定一个整数 N，请问可以构造多少个优美的排列？

**示例1:**

```
输入: 2
输出: 2
解释: 

第 1 个优美的排列是 [1, 2]:
  第 1 个位置（i=1）上的数字是1，1能被 i（i=1）整除
  第 2 个位置（i=2）上的数字是2，2能被 i（i=2）整除

第 2 个优美的排列是 [2, 1]:
  第 1 个位置（i=1）上的数字是2，2能被 i（i=1）整除
  第 2 个位置（i=2）上的数字是1，i（i=2）能被 1 整除
```

说明:**

- N 是一个正整数，并且不会超过15。




## 2、解题思路

- 使用回溯法
- 设置一个访问状态数组，记录已经访问过哪些数字
- 判断当前能否将这个数字放入数组，如果可以，标记为已使用，递归，并且递归完成后，标记为未使用，按照新的路径重新进行查找



```python
class Solution:
    def countArrangement(self, N: int) -> int:
        visited = [False] * N
        res = 0

        def dfs(count):
            nonlocal N, res
            if count == N + 1:
                res += 1

            for i in range(N):
                if not visited[i]:
                    if not (i + 1) % count or not count % (i + 1):
                        visited[i] = True
                        dfs(count + 1)
                        visited[i] = False

        dfs(1)

        return res
```

