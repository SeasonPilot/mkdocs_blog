# LeetCode: 29.两数相除

[TOC]



## 1、题目描述

给定两个整数，被除数 `dividend` 和除数 `divisor`。将两数相除，要求不使用乘法、除法和 mod 运算符。

返回被除数 `dividend` 除以除数 `divisor` 得到的商。

**示例 1:**

```
输入: dividend = 10, divisor = 3
输出: 3
```

**示例 2:**

```
输入: dividend = 7, divisor = -3
输出: -2
```

**说明:**

- 被除数和除数均为 32 位有符号整数。
- 除数不为 0。
- 假设我们的环境只能存储 32 位有符号整数，其数值范围是 [−231,  231 − 1]。本题中，如果除法结果溢出，则返回 231 − 1。



## 2、解题思路

​	首先，如果当前数大于除数，我们就循环判断，为了加快进度，使用移位操作，如果大于其二倍，被除数左移一位，每一次左移一位，直到大于除数停止，这时候，我们减去这个值，然后继续判断，直到最后





```python
class Solution:
    def divide(self, dividend, divisor):
        """
        :type dividend: int
        :type divisor: int
        :rtype: int
        """
        num1 = abs(dividend)
        num2 = abs(divisor)

        res = 0

        while num1 >= num2:
            temp = num2
            count = 1
            while (temp << 1) < num1:
                temp = temp << 1
                count = count << 1
            res += count
            num1 -= temp
        if (dividend > 0) ^ (divisor > 0):
            return -res
        if res >= 2 ** 31:
            return 2 ** 31-1
        return res
```



上面有一些步骤使用没考虑到实际的边界条件，

```python
class Solution(object):
    def divide(self, dividend, divisor):
        """
        :type dividend: int
        :type divisor: int
        :rtype: int
        """
        if dividend == ~(1 << 31) + 1 and divisor == -1:
            return (1 << 31) - 1

        if divisor == ~(1 << 31) + 1:
            if dividend == ~(1 << 31) + 1:
                return 1
            else:
                return 0

        sign = (dividend > 0) ^ (divisor > 0)

        nums = 0
        temp_num = 0

        temp_dividend = dividend
        pre_divisor = ~divisor + 1 if divisor < 0 else divisor
        temp_divisor = pre_divisor
        abs_divisor = pre_divisor
        if temp_dividend == ~(1 << 31) + 1:
            temp_dividend += pre_divisor
            nums = 1

        temp_dividend = ~temp_dividend + 1 if temp_dividend < 0 else temp_dividend

        while temp_dividend >= abs_divisor:
            temp_num = 0
            temp_divisor = abs(divisor)
            for i in range(32):
                temp = temp_divisor << i
                if temp_dividend >= temp:
                    temp_num = 1 << i
                    pre_divisor = temp
                else:
                    nums += temp_num
                    temp_dividend -= pre_divisor
                    break
            if temp_dividend >= pre_divisor:
                nums += temp_num
                temp_dividend -= pre_divisor

        if sign:
            return nums
        else:
            return (~nums) + 1
        
```

