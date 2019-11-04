# LeetCode: 773. 滑动谜题

[TOC]

## 1、题目描述

在一个 `2 x 3` 的板上`（board）`有 `5` 块砖瓦，用数字 `1~5` 来表示, 以及一块空缺用 `0` 来表示.

一次移动定义为选择 `0` 与一个相邻的数字（上下左右）进行交换.

最终当板 `board` 的结果是 `[[1,2,3],[4,5,0]]` 谜板被解开。

给出一个谜板的初始状态，返回最少可以通过多少次移动解开谜板，如果不能解开谜板，则返回 `-1` 。

**示例：**

```
输入：board = [[1,2,3],[4,0,5]]
输出：1
解释：交换 0 和 5 ，1 步完成
输入：board = [[1,2,3],[5,4,0]]
输出：-1
解释：没有办法完成谜板
输入：board = [[4,1,2],[5,0,3]]
输出：5
解释：
最少完成谜板的最少移动次数是 5 ，
一种移动路径:
尚未移动: [[4,1,2],[5,0,3]]
移动 1 次: [[4,1,2],[0,5,3]]
移动 2 次: [[0,1,2],[4,5,3]]
移动 3 次: [[1,0,2],[4,5,3]]
移动 4 次: [[1,2,0],[4,5,3]]
移动 5 次: [[1,2,3],[4,5,0]]
输入：board = [[3,2,4],[1,5,0]]
输出：14
```


**提示：**

-   `board 是一个如上所述的 2 x 3 的数组.`
-   `board[i][j] 是一个 [0, 1, 2, 3, 4, 5] 的排列.`



## 2、解题思路

-   广度优先搜索

```
首先定义状态的转换

0 1 2 
3 4 5

一共6个数字，如果变成一个字符串的话，0对应的能够和哪些位置进行互换呢
0: [1, 3],
1: [0, 2, 4],
2: [1, 5],
3: [0, 4],
4: [1, 3, 5],
5: [2, 4],

如上，0对应的就是旁边的1号和3号位置
```

定义了状态转换以后就能够使用广度优先搜索直接判断了



```python
class Solution:
    def slidingPuzzle(self, board: List[List[int]]) -> int:
        mapping_next = {
            0: [1, 3],
            1: [0, 2, 4],
            2: [1, 5],
            3: [0, 4],
            4: [1, 3, 5],
            5: [2, 4],
        }

        def get_next_state(current: str):
            temp = list(current)
            zero_index = current.index("0")
            for i in mapping_next[zero_index]:
                temp[zero_index], temp[i] = temp[i], temp[zero_index]
                yield "".join(temp)
                temp[zero_index], temp[i] = temp[i], temp[zero_index]

        visited = {"123450"}
        target = "".join(map(str, [item for sublist in board for item in sublist]))
        d = ["123450"]
        step = 0
        while d:
            next_d = []
            for state in d:
                if state == target:
                    return step
                for next_state in get_next_state(state):
                    if next_state not in visited:
                        visited.add(next_state)
                        next_d.append(next_state)
            step += 1
            d = next_d
        return -1
```

