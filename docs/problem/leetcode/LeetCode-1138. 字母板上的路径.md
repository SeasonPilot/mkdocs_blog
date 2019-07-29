# LeetCode: 1138. 字母板上的路径

[TOC]

## 1、题目描述

我们从一块字母板上的位置 `(0, 0)` 出发，该坐标对应的字符为 `board[0][0]`。

在本题里，字母板为`board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"]`.

我们可以按下面的指令规则行动：

- 如果方格存在，`'U'` 意味着将我们的位置上移一行；
- 如果方格存在，`'D'` 意味着将我们的位置下移一行；
- 如果方格存在，`'L'` 意味着将我们的位置左移一列；
- 如果方格存在，`'R'` 意味着将我们的位置右移一列；
- `'!'` 会把在我们当前位置 `(r, c)` 的字符 `board[r][c]` 添加到答案中。

返回指令序列，用最小的行动次数让答案和目标 `target` 相同。你可以返回任何达成目标的路径。

 

**示例 1：**

```
输入：target = "leet"
输出："DDR!UURRR!!DDD!"
```

**示例 2：**

```
输入：target = "code"
输出："RR!DDRR!UUL!R!"
```

 

**提示：**

- `1 <= target.length <= 100`
- `target` 仅含有小写英文字母。



## 2、解题思路



- 先通过字典，建立相关的字母表到索引位置的映射
- 比较当前所在位置与字母的位置是否相同，相同则添加"!"
- 比较横纵坐标，进行上下左右移动
- "z"需要特殊处理
- 如果不是"z"，先左右移动，然后上下移动
- 如果是"z"，先上下移动，然后左右移动



```python
class Solution:
    def alphabetBoardPath(self, target: str) -> str:
        res = ""
        UP, DOWN, LEFT, RIGHT, SELECT = "U", "D", "L", "R", "!"
        board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"]
        dict_map = {}
        for r, row in enumerate(board):
            for c, char in enumerate(row):
                dict_map[char] = (r, c)

        x = 0
        y = 0
        for char in target:
            m, n = dict_map[char]

            if m == x and n == y:
                res += SELECT
            else:
                if char != "z":
                    if m >= x:
                        res += DOWN * (m - x)
                    else:
                        res += UP * (x - m)

                    if n >= y:
                        res += RIGHT * (n - y)
                    else:
                        res += LEFT * (y - n)
                else:

                    if n >= y:
                        res += RIGHT * (n - y)
                    else:
                        res += LEFT * (y - n)

                    if m >= x:
                        res += DOWN * (m - x)
                    else:
                        res += UP * (x - m)

                res += SELECT
            x, y = m, n
        return res
```

