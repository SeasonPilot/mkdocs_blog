# LeetCode: 556. 下一个更大元素 III

[TOC]

## 1、题目描述

给定一个`32`位正整数 `n`，你需要找到最小的`32`位整数，其与 `n` 中存在的位数完全相同，并且其值大于`n`。如果不存在这样的`32`位整数，则返回`-1`。

**示例 1:**

```
输入: 12
输出: 21
```

**示例 2:**

```
输入: 21
输出: -1
```



## 2、解题思路

- 一种思路就是寻找下一个排列
- 这里使用了另一个思路，不过需要特别注意的就是边界，是32位，因此最大为`2 ** 31 -1`
- 从字符串的右方开始寻找第一个不是数字递减趋势的位置，然后从后面位置中找出一个比这个数字大的一个数字，然后对其他数字进行排序，连接起来即可

```
例如：
124321

首先从右面开始查找，找出第一个不是递减的数字，2
[2,4,3,2,1]
然后从中找出比2大的数字3，重新排列为
[3,1,2,2,4]
然后将剩余数字放到首部
[1,3,1,2,2,4]
```



```python
class Solution:
    def nextGreaterElement(self, n: int) -> int:
        import bisect

        s_n = list(str(n))

        max_num = 2 ** 31 -1

        if s_n == sorted(s_n, reverse=True):
            return -1

        length = len(s_n)
        res = ["-1"]
        for i in range(length - 2, -1, -1):
            temp = s_n[i:]
            if temp != sorted(temp, reverse=True):
                sort_temp = sorted(temp)
                next_first_num = sort_temp[bisect.bisect_right(sort_temp, s_n[i])]
                sort_temp.remove(next_first_num)
                res = s_n[:i] + [next_first_num] + sort_temp
                break
        ans = int("".join(res))

        return ans if ans < max_num else -1
```

