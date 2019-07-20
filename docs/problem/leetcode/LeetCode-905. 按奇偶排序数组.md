# LeetCode: 905. 按奇偶排序数组

[TOC]

## 1、题目描述

给定一个非负整数数组 A，返回一个数组，在该数组中， A 的所有偶数元素之后跟着所有奇数元素。

你可以返回满足此条件的任何数组作为答案。

 

示例：

```
输入：[3,1,2,4]
输出：[2,4,3,1]
输出 [4,2,3,1]，[2,4,1,3] 和 [4,2,1,3] 也会被接受。
```

提示：

```
1 <= A.length <= 5000
0 <= A[i] <= 5000
```



## 2、解题思路



```python
from collections import deque


class Solution:
    def sortArrayByParity(self, A: List[int]) -> List[int]:
        buff = deque(maxlen=5100)
        for i in A:
            if not (i & 1):
                buff.appendleft(i)
            else:
                buff.append(i)
        return [x for x in buff]

```

```python
class Solution:
    def sortArrayByParity(self, A: List[int]) -> List[int]:
        odd = []
        even = []
        for i in A:
            if not (i & 1):
                even.append(i)
            else:
                odd.append(i)
        return even + odd
        
```

