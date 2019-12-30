# LeetCode: 1060. 有序数组中的缺失元素

[TOC]

## 1、题目描述

给出一个有序数组 `A`，数组中的每个数字都是 独一无二的，找出从数组最左边开始的第 `K` 个缺失数字。

 

**示例 1：**

```
输入：A = [4,7,9,10], K = 1
输出：5
解释：
第一个缺失数字为 5 。
```


**示例 2：**

```
输入：A = [4,7,9,10], K = 3
输出：8
解释： 
缺失数字有 [5,6,8,...]，因此第三个缺失数字为 8 。
```


**示例 3：**

```
输入：A = [1,2,4], K = 3
输出：6
解释：
缺失数字有 [3,5,6,7,...]，因此第三个缺失数字为 6 。
```

**提示：**

-   $1 <= A.length <= 50000$
-   $1 <= A[i] <= 1e7$
-   $1 <= K <= 1e8$



## 2、解题思路

-   找出缺失的数字的数量的前缀和
-   使用二分查找定位，找出空缺的索引，然后找出空缺数字



```python
import bisect


class Solution:
    def missingElement(self, nums: List[int], k: int) -> int:
        missing_count = [0]
        for i in range(1, len(nums)):
            missing_count.append(missing_count[-1] + nums[i] - nums[i - 1] - 1)
        index = bisect.bisect_left(missing_count, k)
        return nums[index - 1] + k - missing_count[index - 1]

```

