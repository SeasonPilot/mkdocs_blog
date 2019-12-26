# LeetCode: 548. 将数组分割成和相等的子数组

[TOC]

## 1、题目描述

给定一个有 `n` 个整数的数组，你需要找到满足以下条件的三元组 `(i, j, k)` ：

-   $0 < i, i + 1 < j, j + 1 < k < n - 1$
-   子数组 `(0, i - 1)，(i + 1, j - 1)，(j + 1, k - 1)，(k + 1, n - 1)` 的和应该相等。

这里我们定义子数组 `(L, R)` 表示原数组从索引为`L`的元素开始至索引为`R`的元素。

 

**示例:**

```
输入: [1,2,1,2,1,2,1]
输出: True
解释:
i = 1, j = 3, k = 5. 
sum(0, i - 1) = sum(0, 0) = 1
sum(i + 1, j - 1) = sum(2, 2) = 1
sum(j + 1, k - 1) = sum(4, 4) = 1
sum(k + 1, n - 1) = sum(6, 6) = 1
```

**注意:**

-   $1 <= n <= 2000。$

-   给定数组中的元素会在 `[-1,000,000, 1,000,000]` 范围内。



## 2、解题思路

-   首先确定中间的分界点，如果左面和右面的差值在元素最大值和最小值差值之上，跳过
-   然后在左右部分进行划分，分成两部分，找出和值相等的



```python
class Solution:
    def splitArray(self, nums: List[int]) -> bool:
        length = len(nums)

        sums = [0]
        max_val, min_val = float('-inf'), float('inf')

        for num in nums:
            max_val = max(max_val, num)
            min_val = min(min_val, num)
            sums.append(sums[-1] + num)
        max_diff = max_val - min_val

        for j in range(3, length - 3):
            if abs(sums[-1] - sums[j + 1] - sums[j]) <= max_diff:
                left = set()
                for i in range(1, j - 1):
                    if sums[i] == sums[j] - sums[i + 1]:
                        left.add(sums[i])
                if not left:
                    continue
                for k in range(j + 2, length - 1):
                    if sums[k] - sums[j + 1] == sums[-1] - sums[k + 1] and (sums[k] - sums[j + 1]) in left:
                        return True
        return False
```

