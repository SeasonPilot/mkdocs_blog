# 单源最短路径：Bellman-Ford算法

在`Dijkstra`算法中，我们没办法处理负权边的情况，负权边有一种特殊情况，也就是负权环，也就是说，只要存在一条路径经过这个负权环，每一次都会降低权重，这种情况是不允许的，因此，需要检测负权环的存在。

`Bellman-Ford`算法不仅能够更新源节点到任意节点的最短路径，并且可以检测负权环是否存在，检测原理为：

-   如果有n个节点，那么源节点到任意节点的最短路径最多的情况会经过所有的节点，也就是经过`n-1`条边，因此，每一条边上面的节点最多被松弛`n-1`次，就能得到最短路径
-   如果继续进行一轮判断，发现还能够松弛操作，这时候就表明当前图存在负权环



**算法步骤：**

-   初始化`dis`数组
-   初始化`path`数组，记录最短路径
-   `dis[source]`初始化为`0`
-   其他初始化为`+∞`
-   反复对`m`条边进行松弛操作，总共进行`n-1`次，并且同时更新`path`数组。
-   判断是否还会进行松弛操作（`dis`数组是否还会变化），如果仍然可以进行松弛，表示存在负权回路，无最短路径。否则`dis`数组中的值即为从源点出发的最短路径。
  

**实例：**

-   无负权

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-29-084100.png" alt="image-20191129143624493" style="zoom:50%;" />

-   有负权，不存在负权环

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-30-005635.png" alt="image-20191130085630116" style="zoom:50%;" />







-   存在负权环

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-30-005655.png" alt="image-20191130085651457" style="zoom:50%;" />

右下角节点`1,2,3`组成了负权环，权值`2,3,-11`



**代码：**

```python
from typing import List


class BellManFord:
    def __init__(self, n: int, edges: List[List[int]], source: int):
        """
        使用Bellman-Ford算法找出单源最短路径

        :param n: 表示有几个节点，节点标号从0开始
        :param edges: n长度的路径列表 每个path由 start, tail, weight组成
        :param sourse: 起始点
        """
        inf = float('inf')
        self.node_num = n
        self.dis = [inf] * n
        self.path = [-1] * n
        self.dis[source] = 0
        self.negative_ring_flag = True

        for _ in range(n - 1):
            if not self.negative_ring_flag:
                break
            self.negative_ring_flag = False
            for pre_node, next_node, weight in edges:
                if self.dis[pre_node] + weight < self.dis[next_node]:
                    self.negative_ring_flag = True
                    self.dis[next_node] = self.dis[pre_node] + weight
                    self.path[next_node] = pre_node

        # update negative ring flag
        if self.negative_ring_flag:
            self.negative_ring_flag = False
            for pre_node, next_node, weight in edges:
                if self.dis[pre_node] + weight < self.dis[next_node]:
                    self.negative_ring_flag = True
                    break

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

d = BellManFord(length, edges, 0)
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
d1 = BellManFord(length, edges1, 0)
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
d2 = BellManFord(length, edges2, 0)
print("距离：", d2.dis)
print("前向节点：", d2.path)
print(d2.get_shortest_dis(3))
print(d2.get_shortest_dis(2))
print(d2.get_shortest_path(2))
print(d2.get_shortest_path_str(2))

```

代码中分别对三种图进行了输出

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
距离： [-12, -12, -24, -13]
前向节点： [2, 2, 3, 2]
-1
-1
[]
```

我们看到，前两种都能得到正确的结果，第三种由于负权环的存在，无法得到准确结果