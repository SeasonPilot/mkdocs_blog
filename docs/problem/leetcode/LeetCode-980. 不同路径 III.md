# LeetCode: 980. 不同路径 III

[TOC]

## 1、题目描述

在二维网格 `grid` 上，有 `4` 种类型的方格：

- 1 表示起始方格。且只有一个起始方格。
- 2 表示结束方格，且只有一个结束方格。
- 0 表示我们可以走过的空方格。
- -1 表示我们无法跨越的障碍。
  返回在四个方向（上、下、左、右）上行走时，从起始方格到结束方格的不同路径的数目，每一个无障碍方格都要通过一次。

 

**示例 1：**

```
输入：[[1,0,0,0],[0,0,0,0],[0,0,2,-1]]
输出：2
解释：我们有以下两条路径：

1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2)
2. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2)
```

**示例 2：**

```
输入：[[1,0,0,0],[0,0,0,0],[0,0,0,2]]
输出：4
解释：我们有以下四条路径： 

1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2),(2,3)
2. (0,0),(0,1),(1,1),(1,0),(2,0),(2,1),(2,2),(1,2),(0,2),(0,3),(1,3),(2,3)
3. (0,0),(1,0),(2,0),(2,1),(2,2),(1,2),(1,1),(0,1),(0,2),(0,3),(1,3),(2,3)
4. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2),(2,3)

```



**示例 3：**

```
输入：[[0,1],[2,0]]
输出：0
解释：
没有一条路能完全穿过每一个空的方格一次。
请注意，起始和结束方格可以位于网格中的任意位置。
```

**提示：**

- `1 <= grid.length * grid[0].length <= 20`




## 2、解题思路

- 回溯法
- 首先需要统计出下面的信息
  - 起始点
  - 终止点
  - 需要经过多少步
  - 保存当前点可以去到哪些点
- 然后记录访问信息



```python
class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        from collections import defaultdict
        row = len(grid)
        col = len(grid[0])

        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        out_degree = defaultdict(set)

        total = 0
        step = 0

        start = 0
        target = 0
        paths = 0
        visited = [False for _ in range(row * col)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for i in range(row):
            for j in range(col):
                base = i * col + j
                if grid[i][j] == 1:
                    start = base
                elif grid[i][j] == 2:
                    target = base
                    total += 1
                elif grid[i][j] == 0:
                    total += 1

                if grid[i][j] in (0, 1):
                    for di, dj in surround:
                        if available(i + di, j + dj):
                            s_base = (i + di) * col + j + dj
                            if grid[i + di][j + dj] in (0, 2):
                                out_degree[base].add(s_base)

        def dfs(node):
            nonlocal step, paths, total
            if node == target:
                if step == total:
                    paths += 1

                return
            for next_node in out_degree[node]:
                if visited[next_node]:
                    continue

                visited[next_node] = True
                step += 1
                dfs(next_node)
                visited[next_node] = False
                step -= 1

        visited[start] = True
        dfs(start)
        return paths
```

