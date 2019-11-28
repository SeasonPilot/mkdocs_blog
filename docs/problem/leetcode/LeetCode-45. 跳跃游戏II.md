# LeetCode: 45. 跳跃游戏 II

[TOC]

## 1、题目描述

给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

你的目标是使用最少的跳跃次数到达数组的最后一个位置。

**示例:**

```
输入: [2,3,1,1,4]
输出: 2
解释: 跳到最后一个位置的最小跳跃数是 2。
     从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
```


**说明:**

-   假设你总是可以到达数组的最后一个位置。



## 2、解题思路

-   贪心法
-   每次找出当前可走的步数中，能够到达最远距离的位置，走到这个位置继续判断



```python
class Solution:
    def jump(self, nums: List[int]) -> int:
        
        length = len(nums)
        cur = 0
        next_max = 0
        steps = 0

        while cur != length - 1:
            if cur + nums[cur] >= length - 1:
                steps += 1
                break
            for i in range(1, nums[cur] + 1):
                if cur + i + nums[cur + i] > next_max + nums[next_max]:
                    next_max = cur + i
            cur = next_max
            next_max = 0
            steps += 1
        return steps
```

