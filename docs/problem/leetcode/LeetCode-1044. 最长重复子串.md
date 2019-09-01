# LeetCode: 1044. 最长重复子串

[TOC]

## 1、题目描述

给出一个字符串 `S`，考虑其所有重复子串（`S` 的连续子串，出现两次或多次，可能会有重叠）。

返回任何具有最长可能长度的重复子串。（如果 `S` 不含重复子串，那么答案为 `""`。）

 

**示例 1：**

```
输入："banana"
输出："ana"
```

**示例 2：**

```
输入："abcd"
输出：""
```

**提示：**

- `2 <= S.length <= 10^5`
- `S 由小写英文字母组成。`



## 2、解题思路

- 我们可以按照滑动窗口的形式，从前面向后进行判断，是否会出现当前长度的字符串
- 长度采用二分法进行确认
- 需要注意的就是，由于字符串过长，不能直接使用字符串进行判断是否出现过，这里使用的是取模法



```
将字符串看成是26进制的数字
如果字符串为 abcd
即转换为 
	a * 26^3 + b * 26^2 + c * 26 + d
	
由于数字太大，可以使用一个较大的数取模
只要判断早本次判断中是否出现了这个数字，就表示这个字符串之前出现过

```



```python
class Solution:
    def longestDupSubstring(self, S: str) -> str:
        from functools import reduce
        res = ""
        mod = 2 ** 32
        left = 1
        right = len(S) - 1

        str_to_int = [ord(x) - ord('a') for x in S]

        while left <= right:

            mid = (left + right) // 2
            p = pow(26, mid, mod)
            find = False

            cur = reduce(lambda x, y: (x * 26 + y) % mod, str_to_int[:mid])
            temp = {cur}
            for i in range(1, len(S) - mid + 1):
                cur = (cur * 26 + str_to_int[i + mid - 1] - str_to_int[i - 1] * p) % mod
                if cur in temp:
                    res = S[i:i + mid]
                    find = True
                    break
                else:
                    temp.add(cur)

            if find:
                left = mid + 1
            else:
                right = mid - 1
        return res
```

