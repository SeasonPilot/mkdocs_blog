# LeetCode: 922. 按奇偶排序数组 II

[TOC]

## 1、题目描述

给定一个非负整数数组 A， A 中一半整数是奇数，一半整数是偶数。

对数组进行排序，以便当 A[i] 为奇数时，i 也是奇数；当 A[i] 为偶数时， i 也是偶数。

你可以返回任何满足上述条件的数组作为答案。

 ```
示例：

输入：[4,2,5,7]
输出：[4,5,2,7]
解释：[4,7,2,5]，[2,5,4,7]，[2,7,4,5] 也会被接受。
 ```



提示：

- 2 <= A.length <= 20000
- A.length % 2 == 0
- 0 <= A[i] <= 1000



## 2、解题思路

- 设置一个结果数组以及奇偶数指针
- 遍历目标数组，分别按照奇偶数进行填充

```python
class Solution:
    def sortArrayByParityII(self, A: List[int]) -> List[int]:
        res = [0] * len(A)
        odd_pos = 1
        even_pos = 0
        for num in A:
            if num & 1:
                res[odd_pos] = num
                odd_pos += 2
            else:
                res[even_pos] = num
                even_pos += 2
        return res

```

