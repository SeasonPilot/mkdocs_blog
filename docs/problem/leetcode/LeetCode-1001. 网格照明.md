# LeetCode: 1001. 网格照明

[TOC]

## 1、题目描述

在 `N x N` 的网格上，每个单元格 `(x, y)` 上都有一盏灯，其中 `0 <= x < N 且 0 <= y < N` 。

最初，一定数量的灯是亮着的。`lamps[i]` 告诉我们亮着的第 i 盏灯的位置。每盏灯都照亮其所在 `x` 轴、`y` 轴和两条对角线上的每个正方形（类似于国际象棋中的皇后）。

对于第 `i` 次查询 `queries[i] = (x, y)`，如果单元格 `(x, y)` 是被照亮的，则查询结果为 `1`，否则为 `0` 。

在每个查询 `(x, y)` 之后 [按照查询的顺序]，我们关闭位于单元格 `(x, y)` 上或其相邻 `8` 个方向上（与单元格 `(x, y)` 共享一个角或边）的任何灯。

返回答案数组 `answer`。每个值 `answer[i]` 应等于第 `i` 次查询 `queries[i]` 的结果。

 

**示例：**

```
输入：N = 5, lamps = [[0,0],[4,4]], queries = [[1,1],[1,0]]
输出：[1,0]
解释： 
在执行第一次查询之前，我们位于 [0, 0] 和 [4, 4] 灯是亮着的。
表示哪些单元格亮起的网格如下所示，其中 [0, 0] 位于左上角：
1 1 1 1 1
1 1 0 0 1
1 0 1 0 1
1 0 0 1 1
1 1 1 1 1
然后，由于单元格 [1, 1] 亮着，第一次查询返回 1。在此查询后，位于 [0，0] 处的灯将关闭，网格现在如下所示：
1 0 0 0 1
0 1 0 0 1
0 0 1 0 1
0 0 0 1 1
1 1 1 1 1
在执行第二次查询之前，我们只有 [4, 4] 处的灯亮着。现在，[1, 0] 处的查询返回 0，因为该单元格不再亮着。
```

**提示：**

- `1 <= N <= 10^9`
- `0 <= lamps.length <= 20000`
- `0 <= queries.length <= 20000`
- `lamps[i].length == queries[i].length == 2`



## 2、解题思路

- 本题目关键点在于横纵坐标与对角线的判定

行与列很好判断

> 说明：左上到右下为对角线，右上到左下为反对角线



**对角线判断说明**

对角线一共是`2*n-1`条，对每一个点进行编号，`base = row * n +col` ， 由于在同一个对角线上面的点，就是下一行多1的那个点，因此直接`%(n+1)`就能判断

不过左下角的那一半无法通过这个形式判断，会与右上角重复，但是左下角的所有的点坐标都是列小于行，根据这个进行判别

```
temp_di = (xd * N + yd) % (N + 1) + (0 if yd >= xd else N)
```

这样就得到当前这个点所在的对角线的编号了

**反对角线判断说明**

反对角线很简单，只需要将横纵坐标加起来即可，相等的就在同一条反对角线上面

```
temp_bdi = xd + yd
```



- 一开始将一开始亮的灯的横纵与对角线标号对应的引用值加1
- 等到判定的时候，将该点周围的9个点（包括自身），判断是否亮灯，亮的话，就将对应的引用值减一即可



```python
class Solution:
    def gridIllumination(self, N: int, lamps: List[List[int]], queries: List[List[int]]) -> List[int]:
        from collections import defaultdict
        res = []
        row = defaultdict(int)
        col = defaultdict(int)
        diagonal = defaultdict(int)
        back_diagonal = defaultdict(int)

        # 坐标
        surround = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < N and 0 <= n < N

        lamps_set = set()

        for x, y in lamps:
            row[x] += 1
            col[y] += 1
            # 对角线
            di = (x * N + y) % (N + 1) + (0 if y >= x else N)
            diagonal[di] += 1
            # 反对角线
            bdi = x + y
            back_diagonal[bdi] += 1

            lamps_set.add((x, y))

        for x, y in queries:
            di = (x * N + y) % (N + 1) + (0 if y >= x else N)
            bdi = x + y
            if row[x] > 0 or col[y] > 0 or diagonal[di] > 0 or back_diagonal[bdi] > 0:
                res.append(1)
            else:
                res.append(0)

            for dx, dy in surround:
                xd, yd = x + dx, y + dy
                if available(xd, yd):
                    if (xd, yd) in lamps_set:
                        lamps_set.remove((xd, yd))
                        temp_di = (xd * N + yd) % (N + 1) + (0 if yd >= xd else N)
                        temp_bdi = xd + yd

                        row[xd] -= 1
                        col[yd] -= 1
                        diagonal[temp_di] -= 1
                        back_diagonal[temp_bdi] -= 1
        return res
```

