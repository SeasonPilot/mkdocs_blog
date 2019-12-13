# LeetCode: 1012. 至少有1位重复的数字

[TOC]

## 1、题目描述

给定正整数 `N`，返回小于等于 `N` 且具有至少 `1` 位重复数字的正整数。

 

**示例 1：**

```
输入：20
输出：1
解释：具有至少 1 位重复数字的正数（<= 20）只有 11 。
```


**示例 2：**

```
输入：100
输出：10
解释：具有至少 1 位重复数字的正数（<= 100）有 11，22，33，44，55，66，77，88，99 和 100 。
```


**示例 3：**

```
输入：1000
输出：262
```

**提示：**

-   $1 <= N <= 10^9$



## 2、解题思路

-   使用排列找出所有不重复的数字

**例：**

```
2345
*     不重复的1位数
**    不重复的2位数
***   不重复的3位数
1*** - 2***   带前缀的不重复3位数
20** - 23**   带前缀的不重复2位数
230* - 234*   带前缀的不重复1位数
2340 - 2345   带前缀的不重复0位数

将上面的情况统计出来即可得到所有的不重复的数字
```



```python
import math
from functools import lru_cache


class Solution:
    def numDupDigitsAtMostN(self, N: int) -> int:
        num_str = str(N)
        length = len(num_str)
        if length <= 1:
            return 0

        @lru_cache(None)
        def perm(n, m):
            return math.factorial(n) // math.factorial(n - m)

        no_duplication = 0

        for i in range(1, length):
            no_duplication += 9 * perm(9, i - 1)

        for i in range(length):
            prefix = num_str[:i]
            if len(prefix) != len(set(prefix)):
                break
            start = 0 if i else 1
            end = int(num_str[i]) if i < length - 1 else int(num_str[i]) + 1

            cur_prefix_length = len(prefix) + 1

            for num in range(start, end):
                if str(num) not in prefix:
                    no_duplication += perm(10 - cur_prefix_length, length - cur_prefix_length)
        return N - no_duplication
```

