# LeetCode: 52. N皇后 II

[TOC]

## 1、题目描述

`n` 皇后问题研究的是如何将 `n` 个皇后放置在 `n×n` 的棋盘上，并且使皇后彼此之间不能相互攻击。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-03-021629.png)

上图为 `8` 皇后问题的一种解法。

给定一个整数 `n`，返回 `n` 皇后不同的解决方案的数量。

示例:

```
输入: 4
输出: 2
解释: 4 皇后问题存在如下两个不同的解法。
[
 [".Q..",  // 解法 1
  "...Q",
  "Q...",
  "..Q."],

 ["..Q.",  // 解法 2
  "Q...",
  "...Q",
  ".Q.."]
]
```



## 2、解题思路

- 回溯法
- 解释参见`51`题

```python
class Solution:
    def totalNQueens(self, n: int) -> int:
        res = 0

        row = set()
        col = set()
        diagonal = set()
        back_diagonal = set()

        def dfs(r):
            nonlocal res, row, col, diagonal, back_diagonal, n
            if r == n:
                res += 1
                return
            for c in range(n):
                if r in row or c in col:
                    continue
                # 对角线判断
                # base =
                di = (r * n + c) % (n + 1) + (0 if c >= r else n)
                # 反对角线判断
                bdi = r + c

                if di in diagonal or bdi in back_diagonal:
                    continue

                row.add(r)
                col.add(c)
                diagonal.add(di)
                back_diagonal.add(bdi)

                dfs(r + 1)
                # 回溯
                row.remove(r)
                col.remove(c)
                diagonal.remove(di)
                back_diagonal.remove(bdi)

        dfs(0)
        return res
```

