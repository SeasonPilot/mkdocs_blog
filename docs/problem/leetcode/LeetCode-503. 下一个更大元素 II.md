# LeetCode: 503. 下一个更大元素 II

[TOC]

## 1、题目描述

给定一个循环数组（最后一个元素的下一个元素是数组的第一个元素），输出每个元素的下一个更大元素。数字 x 的下一个更大的元素是按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出 -1。

**示例 1:**

```
输入: [1,2,1]
输出: [2,-1,2]
解释: 第一个 1 的下一个更大的数是 2；
数字 2 找不到下一个更大的数； 
第二个 1 的下一个最大的数需要循环搜索，结果也是 2。
```



**注意:**

-  输入数组的长度不会超过 10000。

## 2、解题思路

- 循环数组，如果将数组复制一份，那么每个元素更大的值就是从右面开始寻找
- 使用取余操作，模拟数组操作
- 设计一个栈，将比当前元素大的元素入栈，小的元素就出栈

```python
class Solution:
    def nextGreaterElements(self, nums: List[int]) -> List[int]:
        stack = []

        N = len(nums)
        res = [-1] * N

        for i in range(2 * N - 1, -1, -1):
            while stack and stack[-1] <= nums[i % N]:
                stack.pop()

            res[i % N] = -1 if not stack else stack[-1]
            stack.append(nums[i % N])

        return res
```

