# LeetCode: 915. 分割数组

[TOC]

## 1、题目描述

给定一个数组 `A`，将其划分为两个不相交（没有公共元素）的连续子数组 `left` 和 `right`， 使得：

-   `left` 中的每个元素都小于或等于 `right` 中的每个元素。
-   `left` 和 `right` 都是非空的。
-   `left` 要尽可能小。

在完成这样的分组后返回 `left` 的长度。可以保证存在这样的划分方法。

 

**示例 1：**

```
输入：[5,0,3,8,6]
输出：3
解释：left = [5,0,3]，right = [8,6]
```


**示例 2：**

```
输入：[1,1,1,0,6,12]
输出：4
解释：left = [1,1,1,0]，right = [6,12]
```

**提示：**

-   `2 <= A.length <= 30000`
-   `0 <= A[i] <= 10^6`
-   `可以保证至少有一种方法能够按题目所描述的那样对 A 进行划分。`



## 2、解题思路

-   找出最终排序中，左侧数组的索引能够与排序数组索引覆盖的部分



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
        res = 0
        index += 1
        while index > 0:
            res += self.buff[index]
            index -= index & (-index)

        return res


class Solution:
    def partitionDisjoint(self, A: List[int]) -> int:

        bit = BinaryIndexTree(len(A))
        ans = 0
        for index, (num, before_index) in enumerate(list(sorted((num, i) for i, num in enumerate(A)))):
            bit.update(before_index, 1)
            if bit.getSum(index) == index + 1:
                ans = index + 1
                break
        return ans
```



-   直接根据性质，不断地更新左侧的数组的最大值与分界点

如果当前数值小于左侧数组的最大值，那么左侧的最大值就需要更新，并且左侧的分界点更新到当前位置



```python
class Solution:
    def partitionDisjoint(self, A: List[int]) -> int:
        left_max_val = A[0]
        total_max_val = A[0]
        left_pos = 0

        for i in range(len(A)):
            if A[i] < left_max_val:
                left_max_val = total_max_val
                left_pos = i
            elif A[i] > total_max_val:
                total_max_val = A[i]
        return left_pos + 1
```

