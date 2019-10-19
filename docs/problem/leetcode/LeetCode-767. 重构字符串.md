# LeetCode: 767. 重构字符串

[TOC]

## 1、题目描述

给定一个字符串`S`，检查是否能重新排布其中的字母，使得两相邻的字符不同。

若可行，输出任意可行的结果。若不可行，返回空字符串。

**示例 1:**

```
输入: S = "aab"
输出: "aba"
```

**示例 2:**

```
输入: S = "aaab"
输出: ""
```

**注意:**

-   `S 只包含小写字母并且长度在[1, 500]区间内。`



## 2、解题思路

-   贪心法
-   每次都找数量最多的元素放入结果集中，放入以后当前元素需要暂存，下一次重新寻找最多的元素
-   使用堆来维护数量关系



```python
from collections import Counter
import heapq


class Solution:
    def reorganizeString(self, S: str) -> str:
        ans = []
        heap = [[-ch_count, ch] for ch, ch_count in Counter(S).items()]
        heapq.heapify(heap)
        temp = []

        while heap:
            current = heapq.heappop(heap)
            ans.append(current[1])
            current[0] += 1
            if temp:
                heapq.heappush(heap, temp)
            if current[0] < 0:
                temp = current
            else:
                temp = []

        return "".join(ans) if len(ans) == len(S) else ""
```

