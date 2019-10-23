# LeetCode: 1054. 距离相等的条形码

[TOC]

## 1、题目描述

在一个仓库里，有一排条形码，其中第 `i` 个条形码为 `barcodes[i]`。

请你重新排列这些条形码，使其中两个相邻的条形码 不能 相等。 你可以返回任何满足该要求的答案，此题保证存在答案。

 

**示例 1：**

```
输入：[1,1,1,2,2,2]
输出：[2,1,2,1,2,1]
```


**示例 2：**

```
输入：[1,1,1,1,2,2,3,3]
输出：[1,3,1,3,2,1,2,1]
```

**提示：**

-   $1 <= barcodes.length <= 10000$
-   $1 <= barcodes[i] <= 10000$



## 2、解题思路

-   统计所有的数字频率，每一次找出与其前一个字符不同，但频率最高的字符放入结果集中



```python
from collections import Counter
import heapq


class Solution:
    def rearrangeBarcodes(self, barcodes: List[int]) -> List[int]:
        count = [[-c, key] for key, c in Counter(barcodes).items()]

        heapq.heapify(count)

        ans = []
        pre = []
        while count:
            cur = heapq.heappop(count)
            ans.append(cur[1])
            cur[0] += 1
            if pre:
                heapq.heappush(count, pre)
            if cur[0] < 0:
                pre = cur
            else:
                pre = []
        if pre:
            ans.append(pre[1])
        return ans
```

