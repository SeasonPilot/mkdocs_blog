# LeetCode: 1291. 顺次数

[TOC]

## 1、题目描述

我们定义「顺次数」为：每一位上的数字都比前一位上的数字大 `1` 的整数。

请你返回由 `[low, high]` 范围内所有顺次数组成的 **有序** 列表（从小到大排序）。

 

**示例 1：**

```
输出：low = 100, high = 300
输出：[123,234]
```

**示例 2：**

```
输出：low = 1000, high = 13000
输出：[1234,2345,3456,4567,5678,6789,12345]
```

 

**提示：**

-   `10 <= low <= high <= 10^9`

## 2、解题思路

-   按照数字的位数顺次生成即可



```python
class Solution:
    def sequentialDigits(self, low: int, high: int) -> List[int]:
        low_length = len(str(low))

        def get_next_num(current):
            cur_length = len(str(current))
            ans = current
            if current % 10 == 9:
                ans = int("".join(map(str, list(range(1, cur_length + 2)))))
            else:
                ans += int('1' * cur_length)
            return ans

        start = int("".join(map(str, range(1, low_length + 1))))
        res = []
        while start < low:
            start = get_next_num(start)

        while start <= high:
            res.append(start)
            start = get_next_num(start)
        return res
```

