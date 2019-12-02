# 单源最短路径：SPFA算法

`SPFA(Shortest Path Faster Algorithm)` 算法是 `Bellman-Ford`算法的队列优化算法的别称，通常用于求含负权边的单源最短路径，以及判负权环。`SPFA` 最坏情况下复杂度和朴素 `Bellman-Ford` 相同，为 `O(VE)`。

-   `SPFA算法`原理与前面异曲同工，从起始点开始对相连的节点进行松弛操作，如果能够进行松弛操作，就将这个点加入队列中，直到队列为空，就找到了最短路径
-   如果存在负权环，那么负权环的影响导致松弛操作能够一直下去，而我们知道，起始点到其他节点的最短路径最多经过`n-1`条边，因此每个节点会最多被松弛`n-1`次，也就是入队`n`次，如果能够入队`n+1`次，就表示这里面存在负权环，导致能够一直进行松弛操作



**算法步骤：**

-   初始化`dis`数组
-   初始化`path`数组，记录最短路径
-   初始化数组`visited`，记录节点入队列的次数
-   初始化`graph`，记录节点的下一个节点
-   初始化队列`q`
-   `dis[source]`初始化为`0`
-   其他初始化为`+∞`
-   只要队列不为空，一直对入队列的节点进行
-   反复对`m`条边进行松弛操作，总共进行`n-1`次，并且同时更新`path`数组，更新`visited`数组。
-   判断节点的入队数量是否超过节点数，超过则表示存在负权回路，无最短路径。否则`dis`数组中的值即为从源点出发的最短路径。



**实例：**

-   无负权

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-29-084100.png" alt="image-20191129143624493" style="zoom:50%;" />

-   有负权，不存在负权环

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-30-005635.png" alt="image-20191130085630116" style="zoom:50%;" />







-   存在负权环

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-30-005655.png" alt="image-20191130085651457" style="zoom:50%;" />

右下角节点`1,2,3`组成了负权环，权值`2,3,-11`



代码：

```python
from typing import List

from collections import deque
from collections import defaultdict
from collections import namedtuple

EdgeNode = namedtuple("EdgeNode", ["weight", "node"])


class SPFA:
    def __init__(self, n: int, edges: List[List[int]], source: int):
        """
        使用SPFA算法找出单源最短路径 (shortest path faster algorithm)

        :param n: 表示有几个节点，节点标号从0开始
        :param edges: n长度的路径列表 每个path由 start, tail, weight组成
        :param sourse: 起始点
        """
        inf = float('inf')
        self.node_num = n
        self.dis = [inf] * n
        self.path = [-1] * n
        self.visited = [0] * n
        self.graph = defaultdict(list)
        self.negative_ring_flag = False
        self.q = deque([source, ])

        self.dis[source] = 0
        for s, t, weight in edges:
            self.graph[s].append(EdgeNode(weight, t))

        self._find_shortest()

    def _find_shortest(self):
        while self.q:
            node = self.q.pop()
            self.visited[node] += 1
            if self.visited[node] > self.node_num:
                self.negative_ring_flag = True
                break
            for next_node_weight, next_node in self.graph[node]:
                if self.dis[node] + next_node_weight < self.dis[next_node]:
                    self.dis[next_node] = self.dis[node] + next_node_weight
                    self.q.append(next_node)
                    self.path[next_node] = node

    def get_shortest_dis(self, target: int) -> int:
        """
        返回距离source点的最短距离
        :param target: 目标点
        :return: 如果目标点不在图中，返回-1
        """
        if target >= self.node_num or self.negative_ring_flag:
            return -1
        return self.dis[target]

    def get_shortest_path(self, target: int) -> List[int]:
        """
        找出到target最短路径,并以列表形式返回
        :param target: 目标节点
        :return: 如果无法到达目标节点，返回[]
        """
        if self.negative_ring_flag or target >= self.node_num or self.dis[target] == float('inf'):
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
print("=" * 20)
print("无负权图：")

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

d = SPFA(length, edges, 0)
print("距离：", d.dis)
print("前向节点：", d.path)
print(d.get_shortest_dis(3))
print(d.get_shortest_dis(2))
print(d.get_shortest_path(2))
print(d.get_shortest_path_str(2))

print("=" * 20)
print("负权图：")

edges1 = [
    [0, 1, 5],
    [0, 3, 7],
    [1, 2, -2],
    [1, 3, 2],
    [2, 0, 3],
    [2, 1, 3],
    [2, 3, 2],
    [3, 2, -1],
]
d1 = SPFA(length, edges1, 0)
print("距离：", d1.dis)
print("前向节点：", d1.path)
print(d1.get_shortest_dis(3))
print(d1.get_shortest_dis(2))
print(d1.get_shortest_path(2))
print(d1.get_shortest_path_str(2))

print("=" * 20)
print("有负权环图：")
edges2 = [
    [0, 1, 5],
    [0, 3, 7],
    [1, 2, -2],
    [1, 3, 2],
    [2, 0, 3],
    [2, 1, 3],
    [2, 3, 2],
    [3, 2, -11],
]
d2 = SPFA(length, edges2, 0)
print("距离：", d2.dis)
print("前向节点：", d2.path)
print(d2.get_shortest_dis(3))
print(d2.get_shortest_dis(2))
print(d2.get_shortest_path(2))
print(d2.get_shortest_path_str(2))

```

输出：

```
====================
无负权图：
距离： [0, 5, 8, 7]
前向节点： [-1, 0, 3, 0]
7
8
[0, 3, 2]
0->3->2
====================
负权图：
距离： [0, 5, 3, 5]
前向节点： [-1, 0, 1, 2]
5
3
[0, 1, 2]
0->1->2
====================
有负权环图：
距离： [-28, -28, -31, -29]
前向节点： [2, 2, 3, 2]
-1
-1
[]
```