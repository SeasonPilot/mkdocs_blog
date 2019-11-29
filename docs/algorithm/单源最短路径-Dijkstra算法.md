# 单源最短路径：Dijkstra算法

[TOC]

## 1、算法原理

`Dijkstra`算法是**贪心算法**，基本思路如下：



**基础：**

-   有顶点集合：`V={1,2,3,4,...,n}`
-   带权边集合：`E={(1,2,5),(2,3,10),...(3,n,20)}`
-   起始点：`1`

**步骤：**

-   设计一个集合`S`，初始只有一个元素：起始点，将起始点放入`S`中
-   设计一个数组，`length`，记住起始点到当前节点的最短长度，初始化为正无穷
-   起始点到起始点的距离为`0`

接下来就开始利用贪心算法进行寻找：

1.  首先遍历与集合`S`中所有节点相连接的点，更新起始点到当前这些点的距离
2.  然后找出距离最短的点，并加入到集合`S`中
3.  持续进行第一步，直到所有的点加入到集合`S`为止，算法结束

这样我们就找出了起始点到其他节点的最短路径

>   ==特别注意：==Dijkstra算法不能处理负权边，这是因为Dijkstra算法依据贪心法，每次都是找到了最优线路，如果存在负权边，前面找到的线路就不是最优的，相矛盾

**实例：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-29-084100.png" alt="image-20191129143624493" style="zoom:50%;" />

如上所示，一共有`4`个节点，从`0`节点开始，找出到达其他节点的最短路径

-   第一步：
    -   集合`S={0}`
    -   距离`dis=[0,∞,∞,∞]`
    -   更新与`0`直接相连的节点的距离，也就是1号节点和3号节点分别更新为`5，7`
    -   距离`dis=[0,5,∞,7]`
    -   然后挑出一个距离最小的节点，放入集合`S`中
    -   集合`S={0,1}`

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-29-84105.png" alt="image-20191129144411536" style="zoom:50%;" />

-   第二步：
    -   集合`S={0,1}`
    -   距离`dis=[0,5,∞,7]`
    -   首先使用刚刚加入集合中的节点1，用其距离更新其他相连接的节点的值，也就是`2`号和`3`号节点的值
    -   距离`dis=[0,5,9,7]`
    -   然后挑出一个最小节点，放入集合中
    -   集合`S={0,1,3}`

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-29-085319.png" alt="image-20191129165313408" style="zoom:50%;" />

-   第三步：
    -   集合`S={0,1,3}`
    -   距离`dis=[0,5,9,7]`
    -   使用节点`3`更新预支相连接的节点的距离
    -   距离`dis=[0,5,9,7]`
    -   将距离最小的加入集合中
    -   集合`S={0,1,2,3}`

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-29-084117.png" alt="image-20191129145520106" style="zoom:50%;" />

在集合`S`中已经包含了所有的节点，到此为止已经

如果想要打印从起始点到当前节点的前进路径，还需要保存一个信息，实际上只需要保存每个节点的前驱结点即可

## 2、代码实例



```python
from typing import List
from collections import defaultdict
from collections import namedtuple
import heapq

EdgeNode = namedtuple("EdgeNode", ["weight", "node"])
PreEdgeNode = namedtuple("PreEdgeNode", ["weight", "node", "pre_node"])


class Dijkstra:
    def __init__(self, n: int, edges: List[List[int]], sourse: int):
        """
        使用Dijsktra算法找出单源最短路径

        :param n: 表示有几个节点，节点标号从0开始
        :param edges: n长度的路径列表 每个path由 start, tail, weight组成
        :param sourse: 起始点
        """
        inf = float('inf')
        self.node_num = n
        self.graph = defaultdict(list)
        self.dis = {sourse: 0}
        self.path = [-1] * n
        self.q = []

        for s, t, weight in edges:
            self.graph[s].append(EdgeNode(weight, t))
            if s == sourse:
                heapq.heappush(self.q, PreEdgeNode(weight, t, sourse))
                self.path[t] = s

        self._find_shortest()

    def _find_shortest(self):
        """
        使用dijkstra算法计算最短距离，并更新最短路径的前驱节点
        :return:
        """
        while self.q:
            weight, node, pre_node = heapq.heappop(self.q)
            if node in self.dis:
                continue
            self.path[node] = pre_node
            self.dis[node] = weight
            for next_node_weight, next_node in self.graph[node]:
                if next_node not in self.dis:
                    heapq.heappush(self.q, PreEdgeNode(weight + next_node_weight, next_node, node))

    def get_shortest_dis(self, target: int) -> int:
        """
        返回距离source点的最短距离
        :param target: 目标点
        :return: 如果目标点不在图中，返回-1
        """
        if target >= self.node_num:
            return -1
        return self.dis[target]

    def get_shortest_path(self, target: int) -> List[int]:
        """
        找出到target最短路径,并以列表形式返回
        :param target: 目标节点
        :return: 如果无法到达目标节点，返回[]
        """
        if target >= self.node_num or target not in self.dis:
            return []
        ans = [target]
        while self.path[ans[-1]] != -1:
            ans.append(self.path[ans[-1]])

        return list(reversed(ans))

    def get_shortest_path_str(self, target: int) -> str:
        """
        找出到target最短路径,并以字符串形式返回
        :param target:
        :return:
        """
        separator = "->"
        return separator.join(map(str, self.get_shortest_path(target)))


length = 4
edges = [
    [0, 1, 5],
    [0, 3, 7],
    [1, 2, 4],
    [1, 3, 2],
    [2, 0, 3],
    [2, 1, 3],
    [2, 3, 2],
    [3, 2, 1],
]

s = Dijkstra(length, edges, 0)
print(s.dis)
print(s.path)
print(s.get_shortest_dis(3))
print(s.get_shortest_dis(2))
print(s.get_shortest_path(2))
print(s.get_shortest_path_str(2))

```

**输出：**

```
{0: 0, 1: 5, 3: 7, 2: 8}
[-1, 0, 3, 0]
7
8
[0, 3, 2]
0->3->2
```



## 3、参考链接

-   [wikipedia Dijkstra](https://en.wikipedia.org/wiki/Dijkstra's_algorithm)



