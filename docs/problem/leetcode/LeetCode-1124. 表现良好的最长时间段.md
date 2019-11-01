# LeetCode: 1124. 表现良好的最长时间段

[TOC]

## 1、题目描述

给你一份工作时间表 `hours`，上面记录着某一位员工每天的工作小时数。

我们认为当员工一天中的工作小时数大于 `8` 小时的时候，那么这一天就是「劳累的一天」。

所谓「表现良好的时间段」，意味在这段时间内，「劳累的天数」是严格 大于「不劳累的天数」。

请你返回「表现良好时间段」的最大长度。

 

**示例 1：**

```
输入：hours = [9,9,6,0,6,6,9]
输出：3
解释：最长的表现良好时间段是 [9,9,6]。
```

**提示：**

-   $1 <= hours.length <= 10000$
-   $0 <= hours[i] <= 16$



## 2、解题思路

-   使用单调栈
-   将大于8的标记为1，小于8的标记为-1，首先求出前缀和，只要找到任意的两点，后面的点的值大于前面的点，更新结果
-   使用单调栈，将最小值放入栈中
-   从后向前进行更新，本题与962题相似



```python
from itertools import accumulate


class Solution:
    def longestWPI(self, hours: List[int]) -> int:
        temp = [1 if x > 8 else -1 for x in hours]
        pre_sum = [0] + list(accumulate(temp))
        stack = []
        ans = 0

        for index, num in enumerate(pre_sum):
            while not stack or num < pre_sum[stack[-1]]:
                stack.append(index)

        for i in range(len(pre_sum) - 1, 0, -1):
            while stack and pre_sum[i] > pre_sum[stack[-1]]:
                ans = max(ans, i - stack.pop())
        return ans
```

