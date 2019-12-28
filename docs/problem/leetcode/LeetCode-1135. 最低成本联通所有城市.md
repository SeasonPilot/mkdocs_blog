# LeetCode: 1135. 最低成本联通所有城市

[TOC]

## 1、题目描述

想象一下你是个城市基建规划者，地图上有 `N` 座城市，它们按以 `1` 到 `N` 的次序编号。

给你一些可连接的选项 `conections`，其中每个选项 `conections[i] = [city1, city2, cost]` 表示将城市 `city1` 和城市 `city2` 连接所要的成本。（连接是双向的，也就是说城市 `city1` 和城市 `city2` 相连也同样意味着城市 `city2` 和城市 `city1` 相连）。

返回使得每对城市间都存在将它们连接在一起的连通路径（可能长度为 `1` 的）最小成本。该最小成本应该是所用全部连接代价的综合。如果根据已知条件无法完成该项任务，则请你返回 `-1`。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-28-063943.png)

```
输入：N = 3, conections = [[1,2,5],[1,3,6],[2,3,1]]
输出：6
解释：
选出任意 2 条边都可以连接所有城市，我们从中选取成本最小的 2 条。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-28-063954.png)

```
输入：N = 4, conections = [[1,2,3],[3,4,4]]
输出：-1
解释： 
即使连通所有的边，也无法连接所有城市。
```

**提示：**

-   `1 <= N <= 10000`
-   `1 <= conections.length <= 10000`
-   `1 <= conections[i][0], conections[i][1] <= N`
-   `0 <= conections[i][2] <= 10^5`
-   `conections[i][0] != conections[i][1]`



## 2、解题思路

-   最小生成树
-   使用并查集实现`Kruskal`算法



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
    def minimumCost(self, N: int, connections: List[List[int]]) -> int:
        d = DFU(N)
        total_cost = 0
        for x, y, cost in sorted(connections, key=lambda x: x[2]):
            if d.find(x - 1) != d.find(y - 1):
                total_cost += cost
                d.union(x - 1, y - 1)
        if d.count() == 1:
            return total_cost
        return -1

```

