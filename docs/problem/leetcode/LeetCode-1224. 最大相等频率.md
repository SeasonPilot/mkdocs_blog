# LeetCode: 1224. 最大相等频率

[TOC]

## 1、题目描述

给出一个正整数数组 `nums`，请你帮忙从该数组中找出能满足下面要求的 最长 前缀，并返回其长度：

从前缀中 删除一个 元素后，使得所剩下的每个数字的出现次数相同。
如果删除这个元素后没有剩余元素存在，仍可认为每个数字都具有相同的出现次数（也就是 `0` 次）。

 

**示例 1：**

```
输入：nums = [2,2,1,1,5,3,3,5]
输出：7
解释：对于长度为 7 的子数组 [2,2,1,1,5,3,3]，如果我们从中删去 nums[4]=5，就可以得到 [2,2,1,1,3,3]，里面每个数字都出现了两次。
```

**示例 2：**

```
输入：nums = [1,1,1,2,2,2,3,3,3,4,4,4,5]
输出：13
```


**示例 3：**

```
输入：nums = [1,1,1,2,2,2]
输出：5
```


**示例 4：**

```
输入：nums = [10,2,8,9,3,8,1,5,2,3,7,6]
输出：8
```

**提示：**

-   $2 <= nums.length <= 10^5$
-   $1 <= nums[i] <= 10^5$



## 2、解题思路

-   从前向后遍历，我们通过频率出现的次数进行判定

当频率出现小于等于2的时候，可能出现满足结果的情况，这时候进行判定

有下面几种情况可以更新结果：

1.  如果目前只有一种频率，并且出现次数为1，肯定满足条件，这表示同一个数字出现了多次
2.  如果目前只有一种频率，但是出现了多次，频率为1，这时候也满足条件，表示多个数字都出现了一次
3.  如果目前有两种频率，并且低频率是1，出现了一次，就表示有一个额外的字母，删掉即可
4.  如果目前有两种频率，并且高频恰好比低频多1，并且高频出现次数是1，这时候高频的去掉一个字母，就变成了低频的，满足条件



```python
from collections import defaultdict


class Solution:
    def maxEqualFreq(self, nums: List[int]) -> int:
        count = defaultdict(int)
        freq_count = {}
        ans = 0

        for index, num in enumerate(nums):
            count[num] += 1
            freq = count[num]
            freq_count.setdefault(freq, 0)
            freq_count[freq] += 1
            if freq > 1:
                freq_count[freq - 1] -= 1
                if freq_count[freq - 1] == 0:
                    freq_count.pop(freq - 1)

            # 判定
            if len(freq_count) == 1:
                (x, y) = list(freq_count.items())[0]
                if x == 1 or y == 1:
                    ans = index + 1
            elif len(freq_count) == 2:
                (x, y), (x1, y1) = sorted(freq_count.items())
                if (x == 1 and y == 1) or (x1 == x + 1 and y1 == 1):
                    ans = index + 1

        return ans
```

