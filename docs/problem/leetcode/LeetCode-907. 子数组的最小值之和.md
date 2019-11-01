# LeetCode: 907. 子数组的最小值之和

[TOC]

## 1、题目描述

给定一个整数数组 `A`，找到 `min(B)` 的总和，其中 `B` 的范围为 `A` 的每个（连续）子数组。

由于答案可能很大，因此返回答案模 $10^9 + 7$。

 

**示例：**

```
输入：[3,1,2,4]
输出：17
解释：
子数组为 [3]，[1]，[2]，[4]，[3,1]，[1,2]，[2,4]，[3,1,2]，[1,2,4]，[3,1,2,4]。 
最小值为 3，1，2，4，1，1，2，1，1，1，和为 17。
```

**提示：**

-   $1 <= A <= 30000$
-   $1 <= A[i] <= 30000$



## 2、解题思路

-   使用单调栈

-   找出当前元素为结尾的子数组中有多少以当前元素为最小值，向左更新



```python
class Solution:
    def sumSubarrayMins(self, A: List[int]) -> int:
        mod_num = 1000000007
        stack = []
        temp_ans = []
        ans = 0
        for index, num in enumerate(A):
            while stack and A[stack[-1]] > num:
                stack.pop()
            if stack:
                temp_ans.append(num * (index - stack[-1]) + temp_ans[stack[-1]])
            else:
                temp_ans.append(num * (index + 1))
            ans = (ans + temp_ans[-1]) % mod_num
            stack.append(index)
        return ans


```

