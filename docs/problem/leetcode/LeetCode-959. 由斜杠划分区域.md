# LeetCode: 959. 由斜杠划分区域

[TOC]

## 1、题目描述

在由 `1 x 1` 方格组成的 `N x N` 网格 `grid` 中，每个 `1 x 1` 方块由 `/、\` 或空格构成。这些字符会将方块划分为一些共边的区域。

（请注意，反斜杠字符是转义的，因此 `\` 用 `"\\"` 表示。）。

返回区域的数目。

 

**示例 1：**

```
输入：
[
  " /",
  "/ "
]
输出：2

```

解释：2x2 网格如下：

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-084248.png)



**示例 2：**

```
输入：
[
  " /",
  "  "
]
输出：1
```

解释：2x2 网格如下：

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-084256.png)

**示例 3：**

```
输入：
[
  "\\/",
  "/\\"
]
输出：4
```

解释：`（回想一下，因为 \ 字符是转义的，所以 "\\/" 表示 \/，而 "/\\" 表示 /\。）`
2x2 网格如下：

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-084302.png)

**示例 4：**

```
输入：
[
  "/\\",
  "\\/"
]
输出：5
```

解释：（回想一下，因为 \ 字符是转义的，所以 "/\\" 表示 /\，而 "\\/" 表示 \/。）
2x2 网格如下：

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-084307.png)

**示例 5：**

```
输入：
[
  "//",
  "/ "
]
输出：3
```

解释：2x2 网格如下：

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-084313.png)

**提示：**

- `1 <= grid.length == grid[0].length <= 30`

- `grid[i][j] 是 '/'、'\'、或 ' '。`

## 2、解题思路

- 这道题可以使用并查集来做，关键点在于如何表示一个方块

这里采用的是每一个正方形的边的中点作为一个数据点

```
           .─.          
  ┌───────(   )──────┐  
  │        `─'       │  
  │                  │  
 .┴.                .┴. 
(   )              (   )
 `┬'                `┬' 
  │                  │  
  │                  │  
  │        .─.       │  
  └───────(   )──────┘  
           `─'          
如上，单个方块采用这种形式存放
```

```
           .─.                .─.                .─.          
  ┌───────(   )──────┬───────(   )──────┬───────(   )──────┐  
  │        `─'       │        `─'       │        `─'       │  
  │                  │                  │                  │  
 .┴.                .┴.                .┴.                .┴. 
(   )              (   )              (   )              (   )
 `┬'                `┬'                `┬'                `┬' 
  │                  │                  │                  │  
  │                  │                  │                  │  
  │        .─.       │        .─.       │        .─.       │  
  ├───────(   )──────┼───────(   )──────┼───────(   )──────┤  
  │        `─'       │        `─'       │        `─'       │  
  │                  │                  │                  │  
 .┴.                .┴.                .┴.                .┴. 
(   )              (   )              (   )              (   )
 `┬'                `┬'                `┬'                `┬' 
  │                  │                  │                  │  
  │                  │                  │                  │  
  │        .─.       │        .─.       │        .─.       │  
  ├───────(   )──────┼───────(   )──────┼───────(   )──────┤  
  │        `─'       │        `─'       │        `─'       │  
  │                  │                  │                  │  
 .┴.                .┴.                .┴.                .┴. 
(   )              (   )              (   )              (   )
 `┬'                `┬'                `┬'                `┬' 
  │                  │                  │                  │  
  │                  │                  │                  │  
  │        .─.       │        .─.       │        .─.       │  
  └───────(   )──────┴───────(   )──────┴───────(   )──────┘  
           `─'                `─'                `─'          

多个正方形之间有交叉的点
```

所有点的数量为 `2 * length *(length+1)`

使用如下的规则：

- ` `  :空格
  - 将四个点都连起来
- `/`斜杠
  - 将上方和左面的连起来
  - 将右面和下面的连起来
- `\`反斜杠
  - 将上方和右面的连起来
  - 将左面和下面的连起来

例如：

```
第一行是： 
反斜杠 空格 斜杠
```

```
           .─.                .─.                .─.          
  ┌───────(   )──────┬───────(   )──────┬───────(   )──────┐  
  │        `─'▪▪     │      ▪▪`─'▪▪▪    │     ▪▪▪`─'       │  
  │            ▪▪▪   │    ▪▪▪      ▪▪▪▪ │   ▪▪▪            │  
 .┴.             ▪▪ .┴. ▪▪▪           ▪.┴.▪▪▪             .┴. 
(   )              (   )▪             (   )              (   )
 `┬'▪▪              `┬'▪▪▪          ▪▪▪`┬'              ▪▪`┬' 
  │  ▪▪▪             │   ▪▪       ▪▪▪   │             ▪▪▪  │  
  │    ▪▪▪           │    ▪▪     ▪▪     │            ▪▪    │  
  │      ▪▪.─.       │     ▪▪ .─.▪      │        .─.▪▪     │  
  ├───────(   )──────┼───────(   )──────┼───────(   )──────┤  
  │        `─'       │        `─'       │        `─'       │  
  │                  │                  │                  │  
 .┴.                .┴.                .┴.                .┴. 
(   )              (   )              (   )              (   )
 `┬'                `┬'                `┬'                `┬' 
  │                  │                  │                  │  
  │                  │                  │                  │  
  │        .─.       │        .─.       │        .─.       │  
  ├───────(   )──────┼───────(   )──────┼───────(   )──────┤  
  │        `─'       │        `─'       │        `─'       │  
  │                  │                  │                  │  
 .┴.                .┴.                .┴.                .┴. 
(   )              (   )              (   )              (   )
 `┬'                `┬'                `┬'                `┬' 
  │                  │                  │                  │  
  │                  │                  │                  │  
  │        .─.       │        .─.       │        .─.       │  
  └───────(   )──────┴───────(   )──────┴───────(   )──────┘  
           `─'                `─'                `─'          
```

- 然后借助并查集就能判断有多少集合是单独存在的，就表示有多少区域分割



并查集中的数据长度一共是`2 * length *(length+1)`

- 前面一半，存储的是水平的行
- 后面一般存储的是列

如果针对第`i,j`个方块，需要这样得到对应的上下左右的点：

```python
row_start = 0
col_start = length * (length + 1)

top = i * length + j + row_start
bottom = (i + 1) * length + j + row_start
left = j * length + i + col_start
right = (j + 1) * length + i + col_start
```



**代码如下：**

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
    def regionsBySlashes(self, grid: [str]) -> int:
        length = len(grid)
        d = DFU(2 * length * (length + 1))
        row_start = 0
        col_start = length * (length + 1)

        for i, row in enumerate(grid):
            for j, val in enumerate(row):

                top = i * length + j + row_start
                bottom = (i + 1) * length + j + row_start
                left = j * length + i + col_start
                right = (j + 1) * length + i + col_start
                if val == "/":
                    d.union(top, left)
                    d.union(right, bottom)
                elif val == "\\":
                    d.union(top, right)
                    d.union(left, bottom)
                else:
                    d.union(top, left)
                    d.union(left, bottom)
                    d.union(bottom, right)
        return d.count()
```

