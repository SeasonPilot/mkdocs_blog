# LeetCode: 964. 表示数字的最少运算符

[TOC]

## 1、题目描述

给定一个正整数 `x`，我们将会写出一个形如 `x (op1) x (op2) x (op3) x ...` 的表达式，其中每个运算符 `op1，op2，…` 可以是加、减、乘、除（`+`，`-`，`*`，或是 `/`）之一。例如，对于 `x = 3`，我们可以写出表达式 `3 * 3 / 3 + 3 - 3`，该式的值为 `3` 。

在写这样的表达式时，我们需要遵守下面的惯例：

-   除运算符`（/）`返回有理数。
-   任何地方都没有括号。
-   我们使用通常的操作顺序：乘法和除法发生在加法和减法之前。
-   不允许使用一元否定运算符`（-）`。例如，`“x - x”` 是一个有效的表达式，因为它只使用减法，但是 `“-x + x”` 不是，因为它使用了否定运算符。 

我们希望编写一个能使表达式等于给定的目标值 `target` 且运算符最少的表达式。返回所用运算符的最少数量。

 

**示例 1：**

```
输入：x = 3, target = 19
输出：5
解释：3 * 3 + 3 * 3 + 3 / 3 。表达式包含 5 个运算符。
```


**示例 2：**

```
输入：x = 5, target = 501
输出：8
解释：5 * 5 * 5 * 5 - 5 * 5 * 5 + 5 / 5 。表达式包含 8 个运算符。
```


**示例 3：**

```
输入：x = 100, target = 100000000
输出：3
解释：100 * 100 * 100 * 100 。表达式包含 3 个运算符。
```

**提示：**

-   $2 <= x <= 100$
-   $1 <= target <= 2 * 10^8$




## 2、解题思路

-   如果我们知道了最终式子有几个数字，那么运算符就是数组的数量减一
-   实际上，我们可以将多个数字的乘法，以及两个数字的除法看成基本单元，用来逼近`target`
-   如果是除法，数字增益是2
-   如果是乘法，增益就是指数

因此，除法可以看成是指数为0，增益为2

这时候，我们可以从最低的开始查找，找出没办法除尽的余数，用这个数字来计算当前指数层级的数字增益

取余数的时候有两种方式，一种是取当前层级叠加，另一种是当前层级用来减，加上一个下一层级



由于数字最大是$2 * 10^8$，因此最大的层级不超过28，这里使用32作为缓存



```python
from functools import lru_cache


class Solution:
    def leastOpsExpressTarget(self, x: int, target: int) -> int:
        power_base = list(range(32))
        power_base[0] = 2

        @lru_cache(None)
        def dfs(power, tar):
            if tar == 0:
                return 0
            if tar == 1:
                return power_base[power]
            if power > 30:
                return float('inf')

            next_base, remainder = divmod(tar, x)
            return min(remainder * power_base[power] + dfs(power + 1, next_base),
                       (x - remainder) * power_base[power] + dfs(power + 1, next_base + 1))

        return dfs(0, target) - 1
```

