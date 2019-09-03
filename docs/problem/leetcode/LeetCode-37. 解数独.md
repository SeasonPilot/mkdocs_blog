# LeetCode: 37. 解数独

[TOC]

## 1、题目描述

编写一个程序，通过已填充的空格来解决数独问题。

一个数独的解法需**遵循如下规则**：

- 数字 `1-9` 在每一行只能出现一次。
- 数字 `1-9` 在每一列只能出现一次。
- 数字 `1-9` 在每一个以粗实线分隔的 `3x3` 宫内只能出现一次。
  空白格用 `'.'` 表示。

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-03-093823.png)

一个数独。

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-03-093849.png)

答案被标成红色。

**Note:**

- 给定的数独序列只包含数字 `1-9` 和字符 `'.'` 。
- 你可以假设给定的数独只有唯一解。
- 给定数独永远是 `9x9` 形式的。

## 2、解题思路

- 使用回溯法
- 需要注意的就是元素的选取，首先将每一行，每一列以及每个9宫格的缺失数字提取出来
- 每一次取3个集合中的交集中的元素放入数独中

```python
# 取出交集如下：
        nums = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

        rows = [set() for _ in range(9)]
        cols = [set() for _ in range(9)]
        nines = [set() for _ in range(9)]
        for i in range(9):
            for j in range(9):
                c = board[i][j]
                if c != ".":
                    rows[i].add(c)
                    cols[j].add(c)
                    nines[i // 3 * 3 + j // 3].add(c)
        for i in range(9):
            rows[i] = nums - rows[i]
            cols[i] = nums - cols[i]
            nines[i] = nums - nines[i]
```



```python
class Solution:
    def solveSudoku(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        nums = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

        rows = [set() for _ in range(9)]
        cols = [set() for _ in range(9)]
        nines = [set() for _ in range(9)]
        for i in range(9):
            for j in range(9):
                c = board[i][j]
                if c != ".":
                    rows[i].add(c)
                    cols[j].add(c)
                    nines[i // 3 * 3 + j // 3].add(c)
        for i in range(9):
            rows[i] = nums - rows[i]
            cols[i] = nums - cols[i]
            nines[i] = nums - nines[i]

        flag = False

        def dfs():
            nonlocal flag

            count = 0
            while count < 81:
                x = count // 9
                y = count % 9
                if board[x][y] == ".":
                    break
                count += 1
            else:
                flag = True
                return
            temp = rows[x] & cols[y] & nines[x // 3 * 3 + y // 3]
            if not temp:
                return

            for num in temp:
                board[x][y] = num
                rows[x].remove(num)
                cols[y].remove(num)
                nines[x // 3 * 3 + y // 3].remove(num)
                dfs()
                if flag:
                    return
                board[x][y] = "."
                rows[x].add(num)
                cols[y].add(num)
                nines[x // 3 * 3 + y // 3].add(num)

        dfs()
```

