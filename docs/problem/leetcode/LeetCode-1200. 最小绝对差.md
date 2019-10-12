# LeetCode: 1200. 最小绝对差

[TOC]

## 1、题目描述

给你个整数数组 `arr`，其中每个元素都 不相同。

请你找到所有具有最小绝对差的元素对，并且按升序的顺序返回。

 

**示例 1：**

```
输入：arr = [4,2,1,3]
输出：[[1,2],[2,3],[3,4]]
```


**示例 2：**

```
输入：arr = [1,3,6,10,15]
输出：[[1,3]]
```


**示例 3：**

```
输入：arr = [3,8,-10,23,19,-4,-14,27]
输出：[[-14,-10],[19,23],[23,27]]
```

**提示：**

-   `2 <= arr.length <= 10^5`
-   `-10^6 <= arr[i] <= 10^6`



## 2、解题思路

-   先排序
-   从前向后更新最小间隔，并将等于最小间隔的放入结果集中
-   如果当前间隔小于最小间隔，清空结果集，并将当前元素对放入结果集



```python
class Solution:
    def minimumAbsDifference(self, arr: List[int]) -> List[List[int]]:
        ans = []
        min_difference = float("inf")

        arr.sort()

        for i in range(1, len(arr)):
            cur_diff = arr[i] - arr[i - 1]
            pair = [arr[i - 1], arr[i]]
            if cur_diff == min_difference:
                ans.append(pair)
            elif cur_diff < min_difference:
                ans.clear()
                ans.append(pair)
                min_difference = cur_diff
        return ans
```

