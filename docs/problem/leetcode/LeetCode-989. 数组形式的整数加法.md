# LeetCode: 989. 数组形式的整数加法

[TOC]

## 1、题目描述

对于非负整数 X 而言，X 的数组形式是每位数字按从左到右的顺序形成的数组。例如，如果 X = 1231，那么其数组形式为 [1,2,3,1]。

给定非负整数 X 的数组形式 A，返回整数 X+K 的数组形式。

 ```
示例 1：

输入：A = [1,2,0,0], K = 34
输出：[1,2,3,4]
解释：1200 + 34 = 1234
解释 2：

输入：A = [2,7,4], K = 181
输出：[4,5,5]
解释：274 + 181 = 455
示例 3：

输入：A = [2,1,5], K = 806
输出：[1,0,2,1]
解释：215 + 806 = 1021
示例 4：

输入：A = [9,9,9,9,9,9,9,9,9,9], K = 1
输出：[1,0,0,0,0,0,0,0,0,0,0]
解释：9999999999 + 1 = 10000000000
 ```

**提示：**

-  $1 <= A.length <= 10000$ 
-  $0 <= A[i] <= 9$ 
-  $0 <= K <= 10000$ 
- 如果 A.length > 1，那么 A[0] != 0

## 2、解题思路

```python
from itertools import zip_longest

class Solution:
    def addToArrayForm(self, A: List[int], K: int) -> List[int]:
        temp_a = reversed(A)
        temp_k = []
        temp = K
        while temp > 0:
            cur = temp % 10
            temp //= 10
            temp_k.append(cur)

        carry = 0
        res = []
        for a, b in zip_longest(temp_a, temp_k, fillvalue=0):
            res.insert(0, (a + b + carry) % 10)
            carry = (a + b + carry) // 10
        if carry:
            res.insert(0, carry)
        return res
```



```python
class Solution:
    def addToArrayForm(self, A: List[int], K: int) -> List[int]:
        
        res = []

        while K:
            K, m = divmod(K, 10)
            num = A.pop() if A else 0
            x, y = divmod(m + num, 10)
            K += x
            res.insert(0, y)
        return A + res
```

