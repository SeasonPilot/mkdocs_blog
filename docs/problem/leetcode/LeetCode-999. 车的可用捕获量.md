# LeetCode: 999. 车的可用捕获量

[TOC]

## 1、题目描述

在一个 8 x 8 的棋盘上，有一个白色车`（rook）`。也可能有空方块，白色的象`（bishop）`和黑色的卒`（pawn）`。它们分别以字符` “R”`，`“.”`，`“B”` 和` “p”` 给出。大写字符表示白棋，小写字符表示黑棋。

车按国际象棋中的规则移动：它选择四个基本方向中的一个（北，东，西和南），然后朝那个方向移动，直到它选择停止、到达棋盘的边缘或移动到同一方格来捕获该方格上颜色相反的卒。另外，车不能与其他友方（白色）象进入同一个方格。

返回车能够在一次移动中捕获到的卒的数量。

**示例 1：**

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-19-051421.png)





```
输入：[[".",".",".",".",".",".",".","."],
      [".",".",".","p",".",".",".","."],
      [".",".",".","R",".",".",".","p"],
      [".",".",".",".",".",".",".","."],
      [".",".",".",".",".",".",".","."],
      [".",".",".","p",".",".",".","."],
      [".",".",".",".",".",".",".","."],
      [".",".",".",".",".",".",".","."]]
输出：3
解释：
在本例中，车能够捕获所有的卒。
```

**示例 2：**

![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-19-051426.png)



```
输入：[[".",".",".",".",".",".",".","."],
      [".",".",".","p",".",".",".","."],
      [".",".",".","p",".",".",".","."],
      ["p","p",".","R",".","p","B","."],
      [".",".",".",".",".",".",".","."],
      [".",".",".","B",".",".",".","."],
      [".",".",".","p",".",".",".","."],
      [".",".",".",".",".",".",".","."]]
输出：3
解释： 
车可以捕获位置 b5，d6 和 f5 的卒。
```



**提示：**

-  $ board.length == board[i].length == 8$ 

-  $board[i][j]$ 可以是 `'R'，'.'，'B' 或 'p'` 

- 只有一个格子上存在  $board[i][j] == 'R'$ 



## 2、解题思路

- 找到车(rook)的位置，然后上下左右扫描



```python
class Solution:
    def numRookCaptures(self, board: List[List[str]]) -> int:
        R, C = len(board), len(board[0])

        rook_row = 0
        rook_col = 0

        for r, row in enumerate(board):
            for c, pos in enumerate(row):
                if pos == "R":
                    rook_row = r
                    rook_col = c

        count = 0

        # right
        for i in range(rook_row + 1, R):
            if board[i][rook_col] == "B":
                break
            elif board[i][rook_col] == "p":
                count += 1
                break
        # left
        for i in range(rook_row, -1, -1):
            if board[i][rook_col] == "B":
                break
            elif board[i][rook_col] == "p":
                count += 1
                break
        # up
        for i in range(rook_col + 1, C):
            if board[rook_row][i] == "B":
                break
            elif board[rook_row][i] == "p":
                count += 1
                break
        # down
        for i in range(rook_col - 1, -1, -1):
            if board[rook_row][i] == "B":
                break
            elif board[rook_row][i] == "p":
                count += 1
                break

        return count
```

