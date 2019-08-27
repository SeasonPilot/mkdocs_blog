# LeetCode: 947. 移除最多的同行或同列石头

[TOC]

## 1、题目描述

在二维平面上，我们将石头放置在一些整数坐标点上。每个坐标点上最多只能有一块石头。

现在，`move` 操作将会移除与网格上的某一块石头共享一列或一行的一块石头。

我们最多能执行多少次 `move` 操作？

 

**示例 1：**

```
输入：stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]
输出：5
```


**示例 2：**

```
输入：stones = [[0,0],[0,2],[1,1],[2,0],[2,2]]
输出：3
```


**示例 3：**

```
输入：stones = [[0,0]]
输出：0
```

**提示：**

- `1 <= stones.length <= 1000`
- `0 <= stones[i][j] < 10000`




## 2、解题思路

- 并查集
- 判断同一列或同一行是否出现过，出现则进行合并



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def removeStones(self, stones: [[int]]) -> int:
        d = DFU(len(stones))
        mapping_x = {}
        mapping_y = {}

        for index, (x, y) in enumerate(stones):
            if x in mapping_x:
                d.union(index, mapping_x[x])
            if y in mapping_y:
                d.union(index, mapping_y[y])
            target = d.find(index)
            mapping_x[x] = target
            mapping_y[y] = target

        return len(stones) - d.count()

```

