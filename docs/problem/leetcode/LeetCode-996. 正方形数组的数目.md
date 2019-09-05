# LeetCode: 996. 正方形数组的数目

[TOC]

## 1、题目描述

给定一个非负整数数组 `A`，如果该数组每对相邻元素之和是一个完全平方数，则称这一数组为正方形数组。

返回 A 的正方形排列的数目。两个排列 `A1` 和 `A2` 不同的充要条件是存在某个索引 `i`，使得 `A1[i] != A2[i]`。

 

**示例 1：**

```
输入：[1,17,8]
输出：2
解释：
[1,8,17] 和 [17,8,1] 都是有效的排列。
示例 2：

输入：[2,2,2]
输出：1
```

**提示：**

- `1 <= A.length <= 12`
- `0 <= A[i] <= 1e9`



## 2、解题思路

- 生成去重的全排列
- 生成过程中，不断地判断是否满足平方数的条件



```python
class Solution:
    def numSquarefulPerms(self, A: List[int]) -> int:
        from math import sqrt
        res = 0

        def backtrack(t_nums, tmp):
            nonlocal res
            if not t_nums:
                res += 1
                return
            appear = set()
            for i in range(len(t_nums)):
                if t_nums[i] not in appear:
                    appear.add(t_nums[i])
                    if tmp:
                        num = t_nums[i] + tmp[-1]
                        if int(sqrt(num)) != sqrt(num):
                            continue
                    backtrack(t_nums[:i] + t_nums[i + 1:], tmp + [t_nums[i]])

        backtrack(A, [])
        return res
```

