# LeetCode: 1299. 将每个元素替换为右侧最大元素

[TOC]

## 1、题目描述

给你一个数组 `arr` ，请你将每个元素用它右边最大的元素替换，如果是最后一个元素，用 `-1` 替换。

完成所有替换操作后，请你返回这个数组。

 

**示例：**

```
输入：arr = [17,18,5,4,6,1]
输出：[18,6,6,6,1,-1]
```

**提示：**

-   $1 <= arr.length <= 10^4$
-   $1 <= arr[i] <= 10^5$



## 2、解题思路

-   从右方向左更新，同时保存右方的最大值即可



```python
class Solution:
    def replaceElements(self, arr: List[int]) -> List[int]:
        length = len(arr)
        ans = [0] * length
        pre = -1
        for i in range(length - 1, -1, -1):
            ans[i] = pre
            pre = max(pre, arr[i])
        return ans
```

