# 多源最短路径：Floyd算法

`floyd算法`(也称`Floyd-Warshall`)用来求解任意一个节点到其他节点的最短路径，依据的依然是松弛操作

假设有n个节点，需要两个矩阵来保存两点间的最短路径长度，一个用来保存路径信息



**算法步骤：**

-   初始化`dis`数组，用来节点之间的最短路径，节点到自身的距离为`0`
-   初始化`path`数组，用来保存最短路径经过哪些节点
-   所有的边进行初始化
-   从第一个节点开始，对所有可能的节点组合进行松弛操作



<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-02-121408.png" alt="image-20191202172331947" style="zoom:50%;" />



>   ==注意：==
>
>   -   绿色的表示**原点**
>   -   蓝色的表示**目标点**



**算法图解：**

-   第一步：

首先进行初始化，根据上面的图，将`dis`数组和`path`分别初始化，如下

![image-20191202172805473](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-02-121400.png)

-   第二步：

对于每一个顶点`v`，以及任意可能的顶点对`(i,j)`, 满足条件 `i != j, v != i, v != j`

如果`dis[i][j] > dis[i][v] + dis[v][j]`, 则更新`dis[i][j]`为`dis[i][v] + dis[v][j]`，并同时更新`path[i][j]` 为`v`

经过更新后，所得到的二维数组如下：

![image-20191202195759045](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-02-121414.png)



**代码实例：**

```python
from typing import List


class Floyd:
    def __init__(self, n: int, edges: List[List[int]]):
        """
        使用Floyd算法找出最短路径

        :param n: 表示有几个节点，节点标号从0开始
        :param edges: n长度的路径列表 每个path由 start, tail, weight组成
        """
        inf = float('inf')
        self.node_num = n
        self.dis = [[inf for _ in range(n)] for _ in range(n)]
        self.path = [[-1 for _ in range(n)] for _ in range(n)]

        for s, t, weight in edges:
            self.dis[s][t] = weight
        for i in range(n):
            self.dis[i][i] = 0

        self._find_shortest()

    def _find_shortest(self):

        for v in range(self.node_num):
            for i in range(self.node_num):
                for j in range(self.node_num):
                    if v != i and v != j and i != j:
                        if self.dis[i][j] > self.dis[i][v] + self.dis[v][j]:
                            self.dis[i][j] = self.dis[i][v] + self.dis[v][j]
                            self.path[i][j] = v

    def get_shortest_dis(self, source: int, target: int) -> int:
        """
        返回原点source 到 目标点 target的最短距离
        :param source: 原点
        :param target: 目标点
        :return: 如果目标点不在图中或距离无穷大，返回-1
        """
        if source >= self.node_num or target >= self.node_num or self.dis[source][target] == float('inf'):
            return -1
        return self.dis[source][target]

    def get_shortest_path(self, source: int, target: int) -> List[int]:
        """
        找出原点source到target最短路径,并以列表形式返回
        :param source: 原点
        :param target: 目标节点
        :return: 如果无法到达目标节点，返回[]
        """
        if source >= self.node_num or target >= self.node_num or self.dis[source][target] == float('inf'):
            return []
        ans = []
        while self.path[source][target] != -1:
            ans.append(target)
            target = self.path[source][target]
        ans.extend([target, source])
        return list(reversed(ans))

    def get_shortest_path_str(self, source: int, target: int, sep="->") -> str:
        """
        找出到target最短路径,并以字符串形式返回
        :param source: 原点
        :param target: 目标点
        :param sep: 默认的分隔符
        :return: 以字符串
        """
        return sep.join(map(str, self.get_shortest_path(source, target)))


length = 4
print("=" * 20)

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

d = Floyd(length, edges)
print("距离：", d.dis)
print("前向节点：", d.path)
print(d.get_shortest_dis(0, 0))
print(d.get_shortest_path_str(0, 0))
print(d.get_shortest_dis(0, 1))
print(d.get_shortest_path_str(0, 1))
print(d.get_shortest_dis(0, 2))
print(d.get_shortest_path_str(0, 2))
print(d.get_shortest_dis(0, 3))
print(d.get_shortest_path_str(0, 3))

```

**输出：**

```
====================
距离： [[0, 5, 8, 7], [6, 0, 3, 2], [3, 3, 0, 2], [4, 4, 1, 0]]
前向节点： [[-1, -1, 3, -1], [3, -1, 3, -1], [-1, -1, -1, -1], [2, 2, -1, -1]]
0
0->0
5
0->1
8
0->3->2
7
0->3

```