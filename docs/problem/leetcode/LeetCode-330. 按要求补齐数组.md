# LeetCode: 330. 按要求补齐数组

[TOC]

## 1、题目描述

给定一个已排序的正整数数组 `nums`，和一个正整数 `n` 。从 `[1, n]` 区间内选取任意个数字补充到 `nums` 中，使得 `[1, n]` 区间内的任何数字都可以用 `nums` 中某几个数字的和来表示。请输出满足上述要求的最少需要补充的数字个数。

**示例 1:**

```
输入: nums = [1,3], n = 6
输出: 1 
解释:
根据 nums 里现有的组合 [1], [3], [1,3]，可以得出 1, 3, 4。
现在如果我们将 2 添加到 nums 中， 组合变为: [1], [2], [3], [1,3], [2,3], [1,2,3]。
其和可以表示数字 1, 2, 3, 4, 5, 6，能够覆盖 [1, 6] 区间里所有的数。
所以我们最少需要添加一个数字。
```


**示例 2:**

```
输入: nums = [1,5,10], n = 20
输出: 2
解释: 我们需要添加 [2, 4]。
```


**示例 3:**

```
输入: nums = [1,2,2], n = 5
输出: 0
```



## 2、解题思路

-   贪心法

尽量利用数组中的元素去覆盖更多的范围，如果不能覆盖，就增加范围之外的一个数字，扩大覆盖范围

-   设置一个变量`current_coverage`表示当前的数字能够表示的范围，我们希望能够尽量利用数组中的数字，使得覆盖范围大于等于`n`



```
初始值：
    current_coverage = 0    覆盖0
    
然后开始判断，数组中提供的元素是否小于等于 current_coverage+1？
如果是，表示覆盖范围可以向前扩展
如果不是，那么数字current_coverage+1 不能被覆盖，这时候就需要新增这个数字，同时向后扩展覆盖范围，直到范围大于等于n截止
```



```python
class Solution:
    def minPatches(self, nums: List[int], n: int) -> int:
        ans = 0
        current_coverage = 0
        length = len(nums)
        pos = 0
        while current_coverage < n:
            if pos < length:
                if nums[pos] <= current_coverage + 1:
                    current_coverage += nums[pos]
                    pos += 1
                else:
                    ans += 1
                    current_coverage += current_coverage + 1
            else:
                ans += 1
                current_coverage += current_coverage + 1

        return ans
```

