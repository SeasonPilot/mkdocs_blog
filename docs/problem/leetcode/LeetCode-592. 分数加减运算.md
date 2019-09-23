# LeetCode: 592. 分数加减运算

[TOC]

## 1、题目描述

给定一个表示分数加减运算表达式的字符串，你需要返回一个字符串形式的计算结果。 这个结果应该是不可约分的分数，即最简分数。 如果最终结果是一个整数，例如 `2`，你需要将它转换成分数形式，其分母为 `1`。所以在上述例子中, `2` 应该被转换为 `2/1`。

**示例 1:**

```
输入:"-1/2+1/2"
输出: "0/1"
```


 **示例 2:**

```
输入:"-1/2+1/2+1/3"
输出: "1/3"
```


**示例 3:**

```
输入:"1/3-1/2"
输出: "-1/6"
```


**示例 4:**

```
输入:"5/3+1/3"
输出: "2/1"
```


**说明:**

- `输入和输出字符串只包含 '0' 到 '9' 的数字，以及 '/', '+' 和 '-'。` 
- `输入和输出分数格式均为 ±分子/分母。如果输入的第一个分数或者输出的分数是正数，则 '+' 会被省略掉。`
- `输入只包含合法的最简分数，每个分数的分子与分母的范围是  [1,10]。 如果分母是1，意味着这个分数实际上是一个整数。`
- `输入的分数个数范围是 [1,10]。`
- `最终结果的分子与分母保证是 32 位整数范围内的有效整数。`



## 2、解题思路

- 如果开头是`-`，在前面添加`0/1`
- 将分数和中间计算正负号分开
- 通过最大公约数和最小公倍数，实现分数计算与约分



```python
import math
import re


class Solution:
    def fractionAddition(self, expression: str) -> str:
        if expression.startswith("-"):
            expression = "0/1" + expression

        temp_frac = re.split(r'[+-]', expression)
        temp_sign = list(re.sub('\d+/\d+', "", expression))

        numerator, denominator = map(int, temp_frac[0].split("/"))

        for i in range(1, len(temp_frac)):
            cur_numerator, cur_denominator = map(int, temp_frac[i].split("/"))
            lcm_num = denominator * cur_denominator // math.gcd(denominator, cur_denominator)

            if temp_sign[i - 1] == "+":
                numerator = numerator * (lcm_num // denominator) + cur_numerator * (lcm_num // cur_denominator)
            else:
                numerator = numerator * (lcm_num // denominator) - cur_numerator * (lcm_num // cur_denominator)

            gcd_num = math.gcd(lcm_num, abs(numerator))
            numerator //= gcd_num
            denominator = lcm_num // gcd_num

        return str(numerator) + "/" + str(denominator)
```

- 直接用系统自带的分数类实现



```python
import re
import fractions

class Solution:
    def fractionAddition(self, expression: str) -> str:
   
        if expression.startswith("-"):
            expression = "0/1" + expression

        temp_frac = re.split(r'[+-]', expression)
        temp_sign = list(re.sub('\d+/\d+', "", expression))

        res = fractions.Fraction(*map(int, temp_frac[0].split("/")))
        for i in range(1, len(temp_frac)):
            if temp_sign[i - 1] == "+":
                res += fractions.Fraction(*map(int, temp_frac[i].split("/")))

            else:
                res -= fractions.Fraction(*map(int, temp_frac[i].split("/")))
        return str(res.numerator) + "/" + str(res.denominator)
```

