# LeetCode: 51. N皇后

[TOC]

## 1、题目描述

`n` 皇后问题研究的是如何将 `n` 个皇后放置在 `n×n` 的棋盘上，并且使皇后彼此之间不能相互攻击。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-03-020654.png)

上图为 `8` 皇后问题的一种解法。

给定一个整数 n，返回所有不同的 `n` 皇后问题的解决方案。

每一种解法包含一个明确的 `n` 皇后问题的棋子放置方案，该方案中 `'Q'` 和 `'.'` 分别代表了皇后和空位。

**示例:**

```
输入: 4
输出: [
 [".Q..",  // 解法 1
  "...Q",
  "Q...",
  "..Q."],

 ["..Q.",  // 解法 2
  "Q...",
  "...Q",
  ".Q.."]
]
解释: 4 皇后问题存在两个不同的解法。
```



## 2、解题思路

- 回溯法
- 皇后问题的关键在于如何快速判断是否在攻击范围中

行与列很好判断

> 说明：左上到右下为对角线，右上到左下为反对角线



**对角线判断说明**

对角线一共是`2*n-1`条，对每一个点进行编号，`base = row * n +col` ， 由于在同一个对角线上面的点，就是下一行多1的那个点，因此直接`%(n+1)`就能判断

不过左下角的那一半无法通过这个形式判断，会与右上角重复，但是左下角的所有的点坐标都是列小于行，根据这个进行判别

```
di = (r * n + c) % (n+1) + (0 if c >= r else n)
```

这样就得到当前这个点所在的对角线的编号了

**反对角线判断说明**

反对角线很简单，只需要将横纵坐标加起来即可，相等的就在同一条反对角线上面

```
bdi = r + c
```





```python
class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        lines = []

        for i in range(n):
            lines.append(['.'] * i + ["Q"] + ["."] * (n - i - 1))

        res = []

        row = set()
        col = set()
        diagonal = set()
        back_diagonal = set()

        temp = []

        def dfs(r):
            nonlocal row, col, diagonal, back_diagonal, n
            if r == n:
                res.append(["".join(x) for x in temp])
                return
            for c in range(n):
                if r in row or c in col:
                    continue
                # 对角线判断
                # base =
                di = (r * n + c) % (n+1) + (0 if c >= r else n)
                # 反对角线判断
                bdi = r + c

                if di in diagonal or bdi in back_diagonal:
                    continue

                row.add(r)
                col.add(c)
                diagonal.add(di)
                back_diagonal.add(bdi)
                temp.append(lines[c])

                dfs(r + 1)
                # 回溯
                temp.pop()
                row.remove(r)
                col.remove(c)
                diagonal.remove(di)
                back_diagonal.remove(bdi)

        dfs(0)
        return res
```

