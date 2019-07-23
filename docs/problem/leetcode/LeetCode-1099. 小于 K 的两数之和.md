# LeetCode: 1099. 小于 K 的两数之和

[TOC]

## 1、题目描述

给你一个整数数组 A 和一个整数 K，请在该数组中找出两个元素，使它们的和小于 K 但尽可能地接近 K，返回这两个元素的和。

如不存在这样的两个元素，请返回 -1。

 ```
示例 1：

输入：A = [34,23,1,24,75,33,54,8], K = 60
输出：58
解释：
34 和 24 相加得到 58，58 小于 60，满足题意。
示例 2：

输入：A = [10,20,30], K = 15
输出：-1
解释：
我们无法找到和小于 15 的两个元素。
 ```



**提示：**

-  $1 <= A.length <= 100$ 

-  $1 <= A[i] <= 1000$ 

-  $1 <= K <= 2000$ 

## 2、解题思路

- 先排序

- 双指针法，不断逼近中间，更新结果值

```python
class Solution:
    def twoSumLessThanK(self, A: List[int], K: int) -> int:
        A.sort()

        left = 0
        right = len(A) - 1
        res = float('inf')
        while left < right:
            temp = A[left] + A[right]
            if temp < K:
                if abs(temp - K) < abs(res - K):
                    res = temp
                left += 1

            else:
                right -= 1
        if res >= K:
            return -1
            
        return res
```



```python
class Solution:
    def twoSumLessThanK(self, A: List[int], K: int) -> int:
        A.sort()

        left = 0
        right = len(A) - 1
        res = -1
        while left < right:
            temp = A[left] + A[right]
            if temp < K:
                res = max(res, temp)
                left += 1

            else:
                right -= 1

        return res
```

