# LeetCode: 370. 区间加法

[TOC]

## 1、题目描述

假设你有一个长度为 `n` 的数组，初始情况下所有的数字均为 `0`，你将会被给出 `k` 个更新的操作。

其中，每个操作会被表示为一个三元组：`[startIndex, endIndex, inc]`，你需要将子数组 `A[startIndex ... endIndex]`（包括 `startIndex` 和 `endIndex`）增加 `inc`。

请你返回 `k` 次操作后的数组。

**示例:**

```
输入: length = 5, updates = [[1,3,2],[2,4,3],[0,2,-2]]
输出: [-2,0,3,5,3]
解释:

初始状态:
[0,0,0,0,0]

进行了操作 [1,3,2] 后的状态:
[0,2,2,2,0]

进行了操作 [2,4,3] 后的状态:
[0,2,5,5,3]

进行了操作 [0,2,-2] 后的状态:
[-2,0,3,5,3]


```



## 2、解题思路

-   将区间更新看成是上下车
-   更新上车和下车点的人数，最终求当前时间点车上面的人数即可



```python
class Solution:
    def getModifiedArray(self, length: int, updates: List[List[int]]) -> List[int]:
        ans = [0] * (length + 1)
        for start, end, val in updates:
            ans[start] += val
            ans[end + 1] -= val

        for i in range(1, length + 1):
            ans[i] += ans[i - 1]

        return ans[:length]
```

