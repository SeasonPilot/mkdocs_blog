# LeetCode: 1248. 统计-优美子数组

[TOC]

## 1、题目描述

给你一个整数数组 `nums` 和一个整数 `k`。

如果某个子数组中恰好有 `k` 个奇数数字，我们就认为这个子数组是「优美子数组」。

请返回这个数组中「优美子数组」的数目。

 

**示例 1：**

```
输入：nums = [1,1,2,1,1], k = 3
输出：2
解释：包含 3 个奇数的子数组是 [1,1,2,1] 和 [1,2,1,1] 。
```


**示例 2：**

```
输入：nums = [2,4,6], k = 1
输出：0
解释：数列中不包含任何奇数，所以不存在优美子数组。
```


**示例 3：**

```
输入：nums = [2,2,2,1,2,2,1,2,2,2], k = 2
输出：16
```

**提示：**

-   $1 <= nums.length <= 50000$
-   $1 <= nums[i] <= 10^5$
-   $1 <= k <= nums.length$



## 2、解题思路

-   双指针法
-   使用左右指针，指向一个包含满足条件的最短的子数组，然后左右扩展偶数，用左右扩展的数字相乘，表示当前子数组能够形成的满足条件的数组
-   不断的向右移动一个奇数，重新定位，左右扩展即可



```python
class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        pre_nums = [1 if x & 1 else 0 for x in nums]

        length = len(nums)
        ans = 0
        left = 0
        while left < length and not pre_nums[left]:
            left += 1

        right = left
        count = 1 if left < length else 0
        while count < k and right + 1 < length:
            right += 1
            if pre_nums[right]:
                count += 1
        if count == k:
            start = left - 1
            end = right + 1
            while start >= 0 and not pre_nums[start]:
                start -= 1
            while end < length and not pre_nums[end]:
                end += 1
            ans += (left - start) * (end - right)

        else:
            return 0

        while right < length:
            count -= 1
            left += 1
            while left < length and not pre_nums[left]:
                left += 1
            while count < k and right + 1 < length:
                right += 1
                if pre_nums[right]:
                    count += 1
            if count == k:
                start = left - 1
                end = right + 1
                while start >= 0 and not pre_nums[start]:
                    start -= 1
                while end < length and not pre_nums[end]:
                    end += 1
                ans += (left - start) * (end - right)
            else:
                break
        return ans
```

