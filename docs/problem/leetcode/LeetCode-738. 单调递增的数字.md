# LeetCode: 738. 单调递增的数字

[TOC]

## 1、题目描述

给定一个非负整数 `N`，找出小于或等于 `N` 的最大的整数，同时这个整数需要满足其各个位数上的数字是单调递增。

（当且仅当每个相邻位数上的数字 `x` 和 `y` 满足 `x <= y` 时，我们称这个整数是单调递增的。）

**示例 1:**

```
输入: N = 10
输出: 9
```

**示例 2:**

```
输入: N = 1234
输出: 1234
```

**示例 3:**

```
输入: N = 332
输出: 299
说明: N 是在 [0, 10^9] 范围内的一个整数。
```



## 2、解题思路

-   从后向前寻找，如果前面的数字大于当前数字，当前位置向后的都变为9，前面数字减一
-   需要记录数字变为9的位置



```python
class Solution:
    def monotoneIncreasingDigits(self, N: int) -> int:
        nums = list(map(int, str(N)))
        length = len(nums)
        pos = len(nums)

        for i in range(length - 1, 0, -1):
            if nums[i - 1] > nums[i]:
                nums[i - 1] -= 1
                pos = i

        ans = int("".join(map(str, nums[:pos])) + "9" * (length - pos))
        return ans
```

