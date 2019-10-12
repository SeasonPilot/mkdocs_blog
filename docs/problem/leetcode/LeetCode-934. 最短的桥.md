# LeetCode: 934. 最短的桥

[TOC]

## 1、题目描述

在给定的二维二进制数组 `A` 中，存在两座岛。（岛是由四面相连的 `1` 形成的一个最大组。）

现在，我们可以将 `0` 变为 `1`，以使两座岛连接起来，变成一座岛。

返回必须翻转的 `0` 的最小数目。（可以保证答案至少是 `1`。）

 

**示例 1：**

```
输入：[[0,1],[1,0]]
输出：1
```


**示例 2：**

```
输入：[[0,1,0],[0,0,0],[0,0,1]]
输出：2
```


**示例 3：**

```
输入：[[1,1,1,1,1],[1,0,0,0,1],[1,0,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
输出：1
```

**提示：**

-   `1 <= A.length = A[0].length <= 100`
-   `A[i][j] == 0 或 A[i][j] == 1`



## 2、解题思路

-   DFS标记其中一个岛屿
-   在这个岛屿的基础上，使用BFS找出距离另一个岛屿最近的距离



```python
class Solution:
    def shortestBridge(self, A: List[List[int]]) -> int:
        row, col = len(A), len(A[0])

        visited = [[0 for _ in range(col)] for _ in range(row)]

        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        def get_surround(x, y):
            for dx, dy in surround:
                x1, y1 = x + dx, y + dy
                if available(x1, y1):
                    yield x1, y1

        temp = []

        def dfs(x, y):
            visited[x][y] = 1
            temp.append([x, y])
            for x1, y1 in get_surround(x, y):
                if A[x1][y1] and not visited[x1][y1]:
                    dfs(x1, y1)

        temp_x, temp_y = 0, 0
        while A[temp_x][temp_y] == 0:
            carry = (temp_y + 1) // col
            temp_y = (temp_y + 1) % col
            temp_x = (temp_x + carry) % row

        dfs(temp_x, temp_y)

        step = 0
        flag = False
        ans = 0
        while not flag and temp:
            new_temp = []
            for xt, yt in temp:
                if flag:
                    break
                for nx, ny in get_surround(xt, yt):
                    if not visited[nx][ny]:
                        visited[nx][ny] = 1
                        if A[nx][ny] == 1:
                            ans = step
                            flag = True
                            break
                        new_temp.append([nx, ny])

            temp = new_temp
            step += 1

        return ans
```

