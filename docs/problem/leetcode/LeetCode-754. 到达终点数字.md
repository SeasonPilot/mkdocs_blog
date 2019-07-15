# LeetCode: 754. 到达终点数字

[TOC]

## 1、题目描述

在一根无限长的数轴上，你站在0的位置。终点在target的位置。

每次你可以选择向左或向右移动。第 n 次移动（从 1 开始），可以走 n 步。

返回到达终点需要的最小移动次数。

示例 1:

```
输入: target = 3
输出: 2
解释:
第一次移动，从 0 到 1 。
第二次移动，从 1 到 3 。

```



示例 2:

```
输入: target = 2
输出: 3
解释:
第一次移动，从 0 到 1 。
第二次移动，从 1 到 -1 。
第三次移动，从 -1 到 2 。
```



注意:

- target是在  $[-10^9, 10^9]$  范围中的非零整数。



## 2、解题思路



正常情况，我们使用下面进行计算
$$
1+2+3+...+n = target + 2*x
$$
这里为什么是 $2*x$ 呢？我们最终得到的结果，奇偶性要和目标值保持一致，target上面加上一个偶数，保证了奇偶性

接下来，以目标值100为例，进行解释

最接近100的加和为 从1到14，和为105

然后，我们需要消除5的影响，我们发现5并不是偶数，因此还需要在加上一个数字，15，得到120

这里需要消除20这个数字的影响

只需要在前面找出能够消除20的影响的数字即可，将这些组合向反方向移动即可

例如

- -1，-2，-3， -4，-10
- -3，-4，-13

具体的组合有很多种

```python
class Solution:
    def reachNumber(self, target: int) -> int:
        from math import sqrt

        target = abs(target)
        num = sqrt(2 * target + 0.25) - 0.5
        if num == int(num):
            return int(num)

        num = int(num) + 1

        difference = num * (num + 1) // 2 - target
        if difference % 2 == 0:
            return num
        elif (difference + num + 1) % 2 == 0:
            return num + 1
        else:
            return num + 2
```

