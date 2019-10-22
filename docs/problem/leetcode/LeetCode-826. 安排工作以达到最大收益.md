# LeetCode: 826. 安排工作以达到最大收益

[TOC]

## 1、题目描述

有一些工作：`difficulty[i]` 表示第`i`个工作的难度，`profit[i]`表示第`i`个工作的收益。

现在我们有一些工人。`worker[i]`是第`i`个工人的能力，即该工人只能完成难度小于等于`worker[i]`的工作。

每一个工人都最多只能安排一个工作，但是一个工作可以完成多次。

举个例子，如果`3`个工人都尝试完成一份报酬为1的同样工作，那么总收益为 `$3`。如果一个工人不能完成任何工作，他的收益为 `$0` 。

我们能得到的最大收益是多少？

示例：

```
输入: difficulty = [2,4,6,8,10], profit = [10,20,30,40,50], worker = [4,5,6,7]
输出: 100 
解释: 工人被分配的工作难度是 [4,4,6,6] ，分别获得 [20,20,30,30] 的收益。
```

**提示:**

-   $1 <= difficulty.length = profit.length <= 10000$
-   $1 <= worker.length <= 10000$
-   $difficulty[i], profit[i], worker[i]$  的范围是 $[1, 10^5]$



## 2、解题思路

-   基本思路为当前工人每次做难度不大于他所从事的难度的，并且是最高收益的工作
-   首先和并相同的难度对应的收益，只保留最高收益
-   然后对工人排序，不断的更新当前难度最高收益即可



```python

from collections import defaultdict


class Solution:
    def maxProfitAssignment(self, difficulty: List[int], profit: List[int], worker: List[int]) -> int:
        worker.sort()
        ans = 0

        mapping = defaultdict(int)
        for d, p in zip(difficulty, profit):
            mapping[d] = max(mapping[d], p)
        diff_prof = list(mapping.items())
        diff_prof.sort()
        pre_max = 0
        pos = 0

        for w in worker:

            while pos < len(diff_prof) and diff_prof[pos][0] <= w:
                pre_max = max(pre_max, diff_prof[pos][1])
                pos += 1
            ans += pre_max
        return ans
```

