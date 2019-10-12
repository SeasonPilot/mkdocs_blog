# LeetCode: 1052. 爱生气的书店老板

[TOC]

## 1、题目描述

今天，书店老板有一家店打算试营业 `customers.length` 分钟。每分钟都有一些顾客`（customers[i]）`会进入书店，所有这些顾客都会在那一分钟结束后离开。

在某些时候，书店老板会生气。 如果书店老板在第 `i` 分钟生气，那么 `grumpy[i] = 1`，否则 `grumpy[i] = 0`。 当书店老板生气时，那一分钟的顾客就会不满意，不生气则他们是满意的。

书店老板知道一个秘密技巧，能抑制自己的情绪，可以让自己连续 `X` 分钟不生气，但却只能使用一次。

请你返回这一天营业下来，最多有多少客户能够感到满意的数量。


示例：

```
输入：customers = [1,0,1,2,1,1,7,5], grumpy = [0,1,0,1,0,1,0,1], X = 3
输出：16
解释：
书店老板在最后 3 分钟保持冷静。
感到满意的最大客户数量 = 1 + 1 + 1 + 1 + 7 + 5 = 16.
```

**提示：**

-   `1 <= X <= customers.length == grumpy.length <= 20000`
-   `0 <= customers[i] <= 1000`
-   `0 <= grumpy[i] <= 1`



## 2、解题思路

-   滑动窗口
-   首先将客户本来就满意的统计出来
-   将本来不满意的的前缀和计算出来

-   从当前位置开始进行滑窗计算，滑窗大小为`X`，将滑窗对应的不满意客户数变为满意，更新结果



```python
class Solution:
    def maxSatisfied(self, customers: List[int], grumpy: List[int], X: int) -> int:
        satisfy = 0
        not_satisfy = 0

        length = len(grumpy)

        sum_not_satisfy = [0]
        for customer, ungry in zip(customers, grumpy):
            if ungry:
                not_satisfy += customer
                sum_not_satisfy.append(sum_not_satisfy[-1] + customer)
            else:
                satisfy += customer
                sum_not_satisfy.append(sum_not_satisfy[-1])

        ans = satisfy

        pos = 0

        while pos < (length - X + 1):
            ans = max(ans, satisfy + sum_not_satisfy[pos + X] - sum_not_satisfy[pos])
            pos += 1

        return ans
```

