# LeetCode: 930. 和相同的二元子数组

[TOC]

## 1、题目描述

在由若干 `0` 和 `1`  组成的数组 `A` 中，有多少个和为 `S` 的非空子数组。

 

**示例：**

```
输入：A = [1,0,1,0,1], S = 2
输出：4
解释：
如下面黑体所示，有 4 个满足题目要求的子数组：
[1,0,1,0,1]
[1,0,1,0,1]
[1,0,1,0,1]
[1,0,1,0,1]
```

**提示：**

-   $A.length <= 30000$
-   $0 <= S <= A.length$
-   `A[i] 为 0 或 1`



## 2、解题思路

-   双指针法
-   如果`S`为`0`，将数组分组，连续的`0`的长度构成的子数组为`length * (length + 1) // 2`
-   如果`S`不为0，双指针找到和为`S`并且左右指向的都为1

```
然后左右扩展0的长度
ans += (left - start) * (end - right)
```



```python
from itertools import groupby


class Solution:
    def numSubarraysWithSum(self, A: List[int], S: int) -> int:
        length = len(A)
        ans = 0
        if S == 0:
            for key, l in groupby(A):
                if key == 0:
                    length = len(list(l))
                    ans += length * (length + 1) // 2
        else:
            if sum(A) < S:
                return 0

            left = 0
            while A[left] == 0:
                left += 1
            right = left
            cur_sum = 1
            while cur_sum < S:
                right += 1
                cur_sum += A[right]
            start = left - 1
            end = right + 1
            while start >= 0 and A[start] == 0:
                start -= 1
            while end < length and A[end] == 0:
                end += 1

            ans += (left - start) * (end - right)
            while cur_sum == S:
                cur_sum -= 1
                left += 1

                while left <length and A[left] == 0:
                    left += 1

                while cur_sum < S and right < length - 1:
                    right += 1
                    cur_sum += A[right]
                if cur_sum == S:
                    start = left - 1
                    end = right + 1
                    while start >= 0 and A[start] == 0:
                        start -= 1
                    while end < length and A[end] == 0:
                        end += 1
                    ans += (left - start) * (end - right)
                else:
                    break

        return ans
```

