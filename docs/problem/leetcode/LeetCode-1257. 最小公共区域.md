# LeetCode: 1257. 最小公共区域

[TOC]

## 1、题目描述

给你一些区域列表 `regions` ，每个列表的第一个区域都包含这个列表内所有其他区域。

很自然地，如果区域 `X` 包含区域 `Y` ，那么区域 `X`  比区域 `Y` 大。

给定两个区域 `region1` 和 `region2` ，找到同时包含这两个区域的 最小 区域。

如果区域列表中 `r1` 包含 `r2` 和 `r3` ，那么数据保证 `r2` 不会包含 `r3` 。

数据同样保证最小公共区域一定存在。

 

**示例 1：**

```
输入：
regions = [["Earth","North America","South America"],
["North America","United States","Canada"],
["United States","New York","Boston"],
["Canada","Ontario","Quebec"],
["South America","Brazil"]],
region1 = "Quebec",
region2 = "New York"
输出："North America"
```

**提示：**

-   $2 <= regions.length <= 10^4$
-   $region1 != region2$
-   所有字符串只包含英文字母和空格，且最多只有 `20` 个字母。



## 2、解题思路

-   从下向上查找路径并匹配即可



```python
class Solution:
    def findSmallestRegion(self, regions: List[List[str]], region1: str, region2: str) -> str:
        graph = {}
        for row in regions:
            parent = row[0]
            for x in row[1:]:
                graph[x] = parent

        path1 = set()
        cur = region1
        while cur in graph:
            path1.add(cur)
            cur = graph[cur]
        path1.add(cur)

        cur = region2
        while cur in graph:
            if cur in path1:
                return cur
            cur = graph[cur]
        return cur
```

