# LeetCode: 1017. 负二进制转换

[TOC]

## 1、题目描述

给出数字 `N`，返回由若干 `"0"` 和 `"1"`组成的字符串，该字符串为 `N` 的负二进制（`base -2`）表示。

除非字符串就是 `"0"`，否则返回的字符串中不能含有前导零。

 

**示例 1：**

```
输入：2
输出："110"
解释：(-2) ^ 2 + (-2) ^ 1 = 2
```


**示例 2：**

```
输入：3
输出："111"
解释：(-2) ^ 2 + (-2) ^ 1 + (-2) ^ 0 = 3
```


**示例 3：**

```
输入：4
输出："100"
解释：(-2) ^ 2 = 4
```

**提示：**

- `0 <= N <= 10^9`



## 2、解题思路

- 与整数转换思路相同，不过是向上取整
- 需要注意一下余数
- 下面代码针对2-16进制有效

```python
class Solution:
    def baseNeg2(self, N: int) -> str:
        def num_to_n_scale(n, x):
            """

            :param n: 待转换10进制数
            :param x: 转换为x进制，x < 0
            :return: 返回x进制的字符串
            """
            import math
            buff = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 'A', 'B', 'C', 'D', 'E', 'F']
            b = []
            x = int(x)

            while True:
                abs_x = abs(x)
                s = math.ceil(n / x)  # 商
                y = (abs_x - abs(n % x)) % abs_x  # 余数
                b.append(buff[y])
                if s == 0:
                    break
                n = s
            return "".join(reversed(b))

        return num_to_n_scale(N, -2)
```

