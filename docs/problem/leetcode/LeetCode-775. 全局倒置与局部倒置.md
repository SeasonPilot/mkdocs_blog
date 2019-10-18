# LeetCode: 775. 全局倒置与局部倒置

[TOC]

## 1、题目描述

数组 `A` 是 `[0, 1, ..., N - 1]` 的一种排列，`N` 是数组 `A` 的长度。全局倒置指的是 `i,j` 满足 `0 <= i < j < N` 并且 `A[i] > A[j]` ，局部倒置指的是 `i` 满足 `0 <= i < N` 并且 `A[i] > A[i+1]` 。

当数组 `A` 中全局倒置的数量等于局部倒置的数量时，返回 `true` 。

 

**示例 1:**

```
输入: A = [1,0,2]
输出: true
解释: 有 1 个全局倒置，和 1 个局部倒置。
```


**示例 2:**

```
输入: A = [1,2,0]
输出: false
解释: 有 2 个全局倒置，和 1 个局部倒置。
```


**注意:**

-   `A` 是 `[0, 1, ..., A.length - 1]` 的一种排列
-   `A` 的长度在 `[1, 5000]`之间
-   这个问题的时间限制已经减少了。



## 2、解题思路

-   逆序对判断

全局倒置就等于求解逆序对的数量

局部倒置就是相邻元素的倒置

如果想让全局倒置等于局部倒置，只能是数组中相邻元素进行交换，判断这个规则即可

```python
class Solution:
    def isIdealPermutation(self, A: List[int]) -> bool:
        length = len(A)
        index = 0
        while index < length:
            if index != A[index]:
                if index != A[index + 1] or A[index] != index + 1:
                    return False
                else:
                    index += 2
            else:
                index += 1
        return True
```

-   使用树状数组求解

```
下面代码在python2中通过，python3中超时
```

```python
class BinaryIndexTree:
    def __init__(self, num):
        """
        :type nums: List[int]
        """

        self.buff = [0] * (num + 1)

    def update(self, i, val):
        """
        :type i: int
        :type val: int
        :rtype: void
        """
        index = i + 1
        while index < len(self.buff):
            self.buff[index] += val
            index += index & (-index)

    def getSum(self, index):
        index += 1
        res = 0
        while index > 0:
            res += self.buff[index]
            index -= index & (-index)
        return res


class Solution:
    def isIdealPermutation(self, A):
        bit = BinaryIndexTree(len(A))

        total = 0
        neighbor = 0

        bit.update(A[0], 1)

        for index in range(1, len(A)):
            if A[index] < A[index - 1]:
                neighbor += 1
            bit.update(A[index], 1)
            total += index + 1 - bit.getSum(A[index])

        return total == neighbor


```

