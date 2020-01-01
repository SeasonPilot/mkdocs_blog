# LeetCode: 1151. 最少交换次数来组合所有的1

[TOC]

## 1、题目描述

给出一个二进制数组 `data`，你需要通过交换位置，将数组中 任何位置 上的 `1` 组合到一起，并返回所有可能中所需 最少的交换次数。

 

**示例 1：**

```
输入：[1,0,1,0,1]
输出：1
解释： 
有三种可能的方法可以把所有的 1 组合在一起：
[1,1,1,0,0]，交换 1 次；
[0,1,1,1,0]，交换 2 次；
[0,0,1,1,1]，交换 1 次。
所以最少的交换次数为 1。
```


**示例 2：**

```
输入：[0,0,0,1,0]
输出：0
解释： 
由于数组中只有一个 1，所以不需要交换。
```


**示例 3：**

```
输入：[1,0,1,0,1,0,0,1,1,0,1]
输出：3
解释：
交换 3 次，一种可行的只用 3 次交换的解决方案是 [0,0,0,0,0,1,1,1,1,1,1]。
```

**提示：**

-   $1 <= data.length <= 10^5$
-   $0 <= data[i] <= 1$



## 2、解题思路

-   找出数组中的一段，这一段长度为数组中`1`的数量，`0`的数量即为交换次数，找出最少的即可



```python
from itertools import accumulate


class Solution:
    def minSwaps(self, data: List[int]) -> int:
        length = len(data)
        acc = [0] + list(accumulate(data))
        ones = acc[-1]
        if ones <= 1:
            return 0
        ans = length
        for i in range(ones, length + 1):
            ans = min(ans, ones - (acc[i] - acc[i - ones]))

        return ans
```

