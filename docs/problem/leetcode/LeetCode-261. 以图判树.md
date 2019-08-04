# LeetCode: 261. 以图判树

[TOC]

## 1、题目描述

给定从 0 到 n-1 标号的 n 个结点，和一个无向边列表（每条边以结点对来表示），请编写一个函数用来判断这些边是否能够形成一个合法有效的树结构。

```
示例 1：

输入: n = 5, 边列表 edges = [[0,1], [0,2], [0,3], [1,4]]
输出: true
示例 2:

输入: n = 5, 边列表 edges = [[0,1], [1,2], [2,3], [1,3], [1,4]]
输出: false
```



- 注意：你可以假定边列表 edges 中不会出现重复的边。由于所有的边是无向边，边 [0,1] 和边 [1,0] 是相同的，因此不会同时出现在边列表 edges 中。



## 2、解题思路

- 使用并查集
- 题目中判定为树，
  - 不能为森林
  - 不能存在环路

使用并查集，如果存在环路，返回False，如果是森林，返回False



```python
class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        parent = [x for x in range(n)]
        total = n

        def search(x):
            while parent[x] != x:
                x = parent[x]
            return x

        def merge(x, y):
            a = search(x)
            b = search(y)
            if a != b:
                parent[a] = b

        for x, y in edges:
            if search(x) != search(y):
                merge(x, y)
                total -= 1
            else:
                return False
        return total == 1
```

