# LeetCode: 803. 打砖块

[TOC]

## 1、题目描述

我们有一组包含`1`和`0`的网格；其中`1`表示砖块。 当且仅当一块砖直接连接到网格的顶部，或者它至少有一块相邻（4 个方向之一）砖块不会掉落时，它才不会落下。

我们会依次消除一些砖块。每当我们消除 `(i, j)` 位置时， 对应位置的砖块（若存在）会消失，然后其他的砖块可能因为这个消除而落下。

返回一个数组表示每次消除操作对应落下的砖块数目。

**示例 1：**

```
输入：
grid = [[1,0,0,0],[1,1,1,0]]
hits = [[1,0]]
输出: [2]
解释: 
如果我们消除(1, 0)位置的砖块, 在(1, 1) 和(1, 2) 的砖块会落下。所以我们应该返回2。
```

**示例 2：**

```
输入：
grid = [[1,0,0,0],[1,1,0,0]]
hits = [[1,1],[1,0]]
输出：[0,0]
解释：
当我们消除(1, 0)的砖块时，(1, 1)的砖块已经由于上一步消除而消失了。所以每次消除操作不会造成砖块落下。注意(1, 0)砖块不会记作落下的砖块。
```

**注意:**

- `网格的行数和列数的范围是[1, 200]。`
- `消除的数字不会超过网格的区域。`
- `可以保证每次的消除都不相同，并且位于网格的内部。`
- `一个消除的位置可能没有砖块，如果这样的话，就不会有砖块落下。`



## 2、解题思路

- 并查集

首先需要理解下题意

> 如果砖块直接或间接连接到上面边沿，那么如果去掉的砖块破坏了这种关系，失去连接的砖块就会掉落
>
> 如果一个砖块直接没有连接到上边沿，敲击不会掉落砖块



- 首先将所有的敲击砖块使用`-1`标识
- 然后将所有的砖块连接起来，如果一个砖块在上边沿，那么就将所有的砖块连接到同一个集合中（并查集的长度比网多一个，用来做上边沿集合）
- 并查集设计一个数组，记录集合中元素的数量
- 按照敲击砖块 的反顺序，如果这个元素是`-1`，那么将元素还原，并且将该元素与周边的`1`合并，如果该元素是上边沿，需要加入到总集合中
- 通过判断总集合的元素数量变化，就表示这个砖块的敲击掉落了几个元素



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))
        self.size = [1] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            xp, yp = (xp, yp) if xp < yp else (yp, xp)
            self.size[yp] += self.size[xp]
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def hitBricks(self, grid: [[int]], hits: [[int]]) -> [int]:
        row = len(grid)
        col = len(grid[0])

        d = DFU(row * col + 1)
        ans = [0] * len(hits)

        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for x, y in hits:
            if grid[x][y] == 1:
                grid[x][y] = -1

        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for i in range(row):
            for j in range(col):
                if grid[i][j] == 1:
                    base = i * col + j
                    if i == 0:
                        d.union(row * col, base)

                    if available(i + 1, j) and grid[i + 1][j] == 1:
                        d.union((i + 1) * col + j, base)
                    if available(i, j + 1) and grid[i][j + 1] == 1:
                        d.union(i * col + j + 1, base)
        for index, (x, y) in enumerate(reversed(hits)):
            if grid[x][y] == -1:
                grid[x][y] = 1
                base = row * col
                cur_base = x * col + y
                pre = d.size[base]

                for dx, dy in surround:
                    if available(x + dx, y + dy) and grid[x + dx][y + dy] == 1:
                        d.union((x + dx) * col + y + dy, cur_base)
                if x == 0:
                    d.union(cur_base, base)
                after = d.size[base]
                if d.find(cur_base) == d.find(base):
                    ans[-(index + 1)] = after - pre - 1

        return ans
```

