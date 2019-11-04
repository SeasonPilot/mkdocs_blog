# LeetCode: 954. 二倍数对数组

[TOC]

## 1、题目描述

给定一个长度为偶数的整数数组 `A`，只有对 A 进行重组后可以满足 “对于每个 `0 <= i < len(A) / 2`，都有 `A[2 * i + 1] = 2 * A[2 * i]”` 时，返回 `true`；否则，返回 `false`。

 

**示例 1：**

```
输入：[3,1,3,6]
输出：false
```


**示例 2：**

```
输入：[2,1,2,6]
输出：false
```


**示例 3：**

```
输入：[4,-2,2,-4]
输出：true
解释：我们可以用 [-2,-4] 和 [2,4] 这两组组成 [-2,-4,2,4] 或是 [2,4,-2,-4]
```


**示例 4：**

```
输入：[1,2,4,16,8,4]
输出：false
```

**提示：**

-   $0 <= A.length <= 30000$
-   `A.length 为偶数`
-   $-100000 <= A[i] <= 100000$



## 2、解题思路

-   统计各个数字出现的频率
-   使用绝对值进行排序，`0`需要特殊处理，因为`0`的`2`倍还是`0`
-   每一个元素，都尝试将2倍的的元素的数量进行配对



```python
from collections import Counter


class Solution:
    def canReorderDoubled(self, A: List[int]) -> bool:
        count = Counter(A)

        for i in sorted(count.keys(),key=abs):
            if i == 0:
                if count[i] % 2:
                    return False
                else:
                    count[i] = 0
            elif count[i] > 0:
                if count[2 * i] >= count[i]:
                    count[2 * i] -= count[i]
                    count[i] = 0

        return not any(count.values())
```

