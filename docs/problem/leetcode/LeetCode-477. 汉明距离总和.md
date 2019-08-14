# LeetCode: 477. 汉明距离总和

[TOC]

## 1、题目描述

两个整数的 汉明距离 指的是这两个数字的二进制数对应位不同的数量。

计算一个数组中，任意两个数之间汉明距离的总和。

**示例:**

```
输入: 4, 14, 2

输出: 6

解释: 在二进制表示中，4表示为0100，14表示为1110，2表示为0010。（这样表示是为了体现后四位之间关系）
所以答案为：
HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.
```



**注意:**

- 数组中元素的范围为从 0到 10^9。
- 数组的长度不超过 10^4。



## 2、解题思路

- 计算汉明距离就是两两之间不同的位
- 统计所有数字中第0位中1和0出现的次数想x,y，这一位的汉明距离也就是x*y
- 其它位以此类推



```python
class Solution:
    def totalHammingDistance(self, nums: List[int]) -> int:
        ans = 0

        for i in range(32):
            ones = 0
            for num in nums:
                if num & (1 << i):
                    ones += 1
            ans += ones * (len(nums) - ones)

        return ans
```

