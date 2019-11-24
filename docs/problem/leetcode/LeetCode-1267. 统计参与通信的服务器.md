# LeetCode: 1267. 统计参与通信的服务器

[TOC]

## 1、题目描述

这里有一幅服务器分布图，服务器的位置标识在 `m * n` 的整数矩阵网格 `grid` 中，`1` 表示单元格上有服务器，`0` 表示没有。

如果两台服务器位于同一行或者同一列，我们就认为它们之间可以进行通信。

请你统计并返回能够与至少一台其他服务器进行通信的服务器的数量。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-24-063825.jpg)



```
输入：grid = [[1,0],[0,1]]
输出：0
解释：没有一台服务器能与其他服务器进行通信。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-24-063831.jpg)

```
输入：grid = [[1,0],[1,1]]
输出：3
解释：所有这些服务器都至少可以与一台别的服务器进行通信。
```


**示例 3：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-24-063841.jpg)

```
输入：grid = [[1,1,0,0],[0,0,1,0],[0,0,1,0],[0,0,0,1]]
输出：4
解释：第一行的两台服务器互相通信，第三列的两台服务器互相通信，但右下角的服务器无法与其他服务器通信。
```

**提示：**

-   `m == grid.length`
-   `n == grid[i].length`
-   `1 <= m <= 250`
-   `1 <= n <= 250`
-   `grid[i][j] == 0 or 1`



## 2、解题思路

题目的本意就是统计有那些行和列只有一个元素

-   使用并查集
-   将每个元素与这一行第一个`1`还有这一列第一个`1`放到同一个集合中



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
            if self.size[xp] > self.size[yp]:
                self.size[xp] += self.size[yp]
                self.data[yp] = xp
            else:
                self.size[yp] += self.size[xp]
                self.data[xp] = yp

    def get_size(self, x):
        return self.size[x]

    def count_nums_more_than_one(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i and self.size[index] > 1:
                res += self.size[index]
        return res

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def countServers(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])

        d = DFU(row * col)
        row_first = [-1] * row
        col_first = [-1] * col

        for x in range(row):
            for y in range(col):
                cur = x * col + y
                if grid[x][y]:
                    if row_first[x] == -1:
                        row_first[x] = cur
                    if col_first[y] == -1:
                        col_first[y] = cur

        for x in range(row):
            for y in range(col):
                cur = x * col + y
                if grid[x][y]:
                    if row_first[x] != -1:
                        d.union(cur, row_first[x])
                    if col_first[y] != -1:
                        d.union(cur, col_first[y])

        return d.count_nums_more_than_one()

```



-   实际上也可以直接利用当前行与当前列的和进行判断



```python

class Solution:
    def countServers(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])
        row_sum = [sum(r) for r in grid]
        col_sum = [sum([grid[i][j] for i in range(row)]) for j in range(col)]

        appear_once = 0
        for i in range(row):
            for j in range(col):
                if grid[i][j] and row_sum[i] == 1 and col_sum[j] == 1:
                    appear_once += 1
        return sum(row_sum) - appear_once
```

