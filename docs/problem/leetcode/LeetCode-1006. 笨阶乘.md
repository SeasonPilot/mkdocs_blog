# LeetCode: 1006. 笨阶乘

[TOC]

## 1、题目描述

通常，正整数 n 的阶乘是所有小于或等于 n 的正整数的乘积。例如，`factorial(10) = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1`。

相反，我们设计了一个笨阶乘 `clumsy`：在整数的递减序列中，我们以一个固定顺序的操作符序列来依次替换原有的乘法操作符：乘法(*)，除法(/)，加法(+)和减法(-)。

例如，`clumsy(10) = 10 * 9 / 8 + 7 - 6 * 5 / 4 + 3 - 2 * 1`。然而，这些运算仍然使用通常的算术运算顺序：我们在任何加、减步骤之前执行所有的乘法和除法步骤，并且按从左到右处理乘法和除法步骤。

另外，我们使用的除法是地板除法`（floor division）`，所以 `10 * 9 / 8` 等于 `11`。这保证结果是一个整数。

实现上面定义的笨函数：给定一个整数 `N`，它返回 `N` 的笨阶乘。

 

**示例 1：**

```
输入：4
输出：7
解释：7 = 4 * 3 / 2 + 1
```


**示例 2：**

```
输入：10
输出：12
解释：12 = 10 * 9 / 8 + 7 - 6 * 5 / 4 + 3 - 2 * 1
```

**提示：**

- `1 <= N <= 10000`
- `-2^31 <= answer <= 2^31 - 1  （答案保证符合 32 位整数。）`



## 2、解题思路

- 直接判断即可，每4个看成一部分
- 除了第一部分，其他的都是同样的模式，前面乘除部分减去，后面加上一个数



```python
class Solution:
    def clumsy(self, N: int) -> int:
        temp = [0, 1, 2, 6, 7]
        if N <= 4:
            return temp[N]
        res = N * (N - 1) // (N - 2) + N - 3
        N -= 4
        while N > 0:
            if N >= 4:
                res = res - N * (N - 1) // (N - 2) + N - 3
                N -= 4
            else:
                res -= temp[N]
                break

        return res
```



- 找规律法

通过观察可以发现，除了`4*3/2=6`这个以外，其他组合得到值都是最大的数加一，

```
7*6/5 = 8
100*99/98 = 101
```

因此，根据这个规律，可以直接得到乘除部分结果

```python
class Solution:
    def clumsy(self, N: int) -> int:
        temp = [0, 1, 2, 6, 7]
        if N <= 4:
            return temp[N]
        res = N + 1 + N - 3
        N -= 4
        while N > 0:
            if N > 4:
                res -= 4
                N -= 4
            elif N == 4:
                res -= 5
                break
            else:
                res -= temp[N]
                break
        return res
```

优化计算：

```python
class Solution:
    def clumsy(self, N: int) -> int:
        temp = [0, 1, 2, 6, 7]
        if N <= 4:
            return temp[N]
        res = N + 1 + N - 3
        N -= 4

        four_times = N // 4
        remainder = N % 4

        if remainder:
            return res + -4 * four_times - temp[remainder]
        else:
            return res + -4 * (four_times - 1) - 5
```

