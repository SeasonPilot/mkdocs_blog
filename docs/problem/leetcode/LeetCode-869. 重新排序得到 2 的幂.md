# LeetCode: 869. 重新排序得到 2 的幂

[TOC]

## 1、题目描述

给定正整数 `N` ，我们按任何顺序（包括原始顺序）将数字重新排序，注意其前导数字不能为零。

如果我们可以通过上述方式得到 `2` 的幂，返回 `true`；否则，返回 `false`。

 

**示例 1：**

```
输入：1
输出：true
```


**示例 2：**

```
输入：10
输出：false
```


**示例 3：**

```
输入：16
输出：true
```


**示例 4：**

```
输入：24
输出：false
```


**示例 5：**

```
输入：46
输出：true
```

**提示：**

-   `1 <= N <= 10^9`



## 2、解题思路

-   题目中的范围只需要32个数字，直接将这些数字取出来，并且将个位数排序放到集合中
-   将待确认的数字取出个位数并进行排序，查看是否在集合中即可



```python
class Solution:
    def __init__(self):
        self.powers = set()
        for i in range(32):
            self.powers.add(self.get_nums(1 << i))

    def get_nums(self, num):
        temp = list()
        temp.append(num % 10)
        num //= 10
        while num:
            temp.append(num % 10)
            num //= 10
        return "".join([str(x) for x in sorted(temp)])

    def reorderedPowerOf2(self, N: int) -> bool:
        return self.get_nums(N) in self.powers
```

