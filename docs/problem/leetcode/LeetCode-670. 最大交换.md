# LeetCode: 670. 最大交换

[TOC]

## 1、题目描述

给定一个非负整数，你至多可以交换一次数字中的任意两位。返回你能得到的最大值。

**示例 1 :**

```
输入: 2736
输出: 7236
解释: 交换数字2和数字7。
```


**示例 2 :**

```
输入: 9973
输出: 9973
解释: 不需要交换。
```


**注意:**

-   给定数字的范围是 `[0, 108]`



## 2、解题思路

-   首先将所有字符进行逆序排序，然后从前面向后找，找到当前字符与逆序不同的数字，表示后面肯定有比当前数字大的
-   然后在后面找出最大的，并且位置最靠后的数字即可

```
例如：
299
逆序排序为：
992
第一个数字就不相同，因此，需要交换的就是这个位置
然后找到第2个9，交换，得到992
```



```python
class Solution:
    def maximumSwap(self, num: int) -> int:
        num_str = list(str(num))
        sorted_num = list(sorted(num_str, reverse=True))
        length = len(num_str)
        pos = length
        for index, (n1, n2) in enumerate(zip(num_str, sorted_num)):
            if n1 != n2:
                pos = index
                break

        next_pos = pos + 1

        if pos < length:
            for i in range(next_pos + 1, length):
                if num_str[i] >= num_str[next_pos]:
                    next_pos = i
            num_str[pos], num_str[next_pos] = num_str[next_pos], num_str[pos]
        return int("".join(num_str))
```

