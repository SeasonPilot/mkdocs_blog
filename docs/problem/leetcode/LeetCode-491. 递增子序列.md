# LeetCode: 491. 递增子序列

[TOC]

## 1、题目描述

给定一个整型数组, 你的任务是找到所有该数组的递增子序列，递增子序列的长度至少是2。

**示例:**

```
输入: [4, 6, 7, 7]
输出: [[4, 6], [4, 7], [4, 6, 7], [4, 6, 7, 7], [6, 7], [6, 7, 7], [7,7], [4,7,7]]
```



**说明:**

- 给定数组的长度不会超过15。

- 数组中的整数范围是 [-100,100]。

- 给定数组中可能包含重复数字，相等的数字应该被视为递增的一种情况。



## 2、解题思路

- DFS+回溯

  

```python
class Solution:
    def findSubsequences(self, nums: List[int]) -> List[List[int]]:
        if not nums:
            return []
        N = len(nums)
        res = set()

        def dfs(target: list, pos):
            if pos >= N:
                return
            if not target:
                target.append(nums[pos])
                dfs(target, pos + 1)
                target.pop()
                dfs(target, pos + 1)
            else:
                for i in range(pos, N):
                    if nums[i] >= target[-1]:
                        target.append(nums[i])
                        res.add(tuple(target[:]))
                        dfs(target, i + 1)
                        target.pop()

        dfs([], 0)
        return sorted(res)
```

