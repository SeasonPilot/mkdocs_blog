# LeetCode: 1014. 最佳观光组合

[TOC]

## 1、题目描述

给定正整数数组 `A`，`A[i]` 表示第 i 个观光景点的评分，并且两个景点 `i` 和 `j` 之间的距离为 `j - i`。

一对景点`（i < j）`组成的观光组合的得分为`（A[i] + A[j] + i - j）`：景点的评分之和减去它们两者之间的距离。

返回一对观光景点能取得的最高分。

 

**示例：**

```
输入：[8,1,5,2,6]
输出：11
解释：i = 0, j = 2, A[i] + A[j] + i - j = 8 + 5 + 0 - 2 = 11
```

**提示：**

-   `2 <= A.length <= 50000`
-   `1 <= A[i] <= 1000`



## 2、解题思路

-   保存当前前方最大的增益值，每次只需要和前面的那个值进行比较即可
-   更新前面节点与最大增益节点谁的增益更大，更大则更新节点

```
因为节点越往后，前面节点的增益依次被递减，因此最大增益节点一直向后判断即可
```



```python
class Solution:
    def maxScoreSightseeingPair(self, A: List[int]) -> int:
        ans = 0
        pre_max = [A[0], 0]

        for i in range(1, len(A)):
            if A[i - 1] + i - pre_max[1] - pre_max[0] > 0:
                pre_max = [A[i - 1], i - 1]
            ans = max(ans, A[i] + pre_max[0] - i + pre_max[1])

        return ans
```

