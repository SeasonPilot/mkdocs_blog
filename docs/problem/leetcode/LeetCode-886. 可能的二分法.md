# LeetCode: 886. 可能的二分法

[TOC]

## 1、题目描述

给定一组 `N` 人（编号为 `1, 2, ..., N`）， 我们想把每个人分进任意大小的两组。

每个人都可能不喜欢其他人，那么他们不应该属于同一组。

形式上，如果 `dislikes[i] = [a, b]`，表示不允许将编号为 `a` 和 `b` 的人归入同一组。

当可以用这种方法将每个人分进两组时，返回 `true`；否则返回 `false`。

 

**示例 1：**

```
输入：N = 4, dislikes = [[1,2],[1,3],[2,4]]
输出：true
解释：group1 [1,4], group2 [2,3]
```


**示例 2：**

```
输入：N = 3, dislikes = [[1,2],[1,3],[2,3]]
输出：false
```


**示例 3：**

```
输入：N = 5, dislikes = [[1,2],[2,3],[3,4],[4,5],[1,5]]
输出：false
```

**提示：**

-   $1 <= N <= 2000$
-   $0 <= dislikes.length <= 10000$
-   $1 <= dislikes[i][j] <= N$
-   $dislikes[i][0] < dislikes[i][1]$
-   `对于 dislikes[i] == dislikes[j] 不存在 i != j` 



## 2、解题思路

-   使用并查集
-   将某个人讨厌的和被讨厌的人放到同一个集合中
-   最后判断是否存在讨厌的人是否在同一个集合中



```python
from collections import defaultdict


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
    def possibleBipartition(self, N: int, dislikes: List[List[int]]) -> bool:

        if N == 1:
            return True

        mapping_not_like = defaultdict(set)
        d = DFU(N)
        for x, y in dislikes:
            mapping_not_like[x].add(y)
            mapping_not_like[y].add(x)

        for key, current in mapping_not_like.items():
            t = current.pop()

            for n in current:
                d.union(t - 1, n - 1)

        for x, y in dislikes:
            if d.find(x - 1) == d.find(y - 1):
                return False

        return True

```

