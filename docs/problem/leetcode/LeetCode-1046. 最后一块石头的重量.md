# LeetCode: 1046. 最后一块石头的重量

[TOC]

## 1、题目描述

有一堆石头，每块石头的重量都是正整数。

每一回合，从中选出两块最重的石头，然后将它们一起粉碎。假设石头的重量分别为 `x` 和 `y`，且 `x <= y` 。那么粉碎的可能结果如下：

如果 `x == y` ，那么两块石头都会被完全粉碎；
如果 `x != y` ，那么重量为 x 的石头将会完全粉碎，而重量为 `y` 的石头新重量为 `y-x` 。
最后，最多只会剩下一块石头。返回此石头的重量。如果没有石头剩下，就返回 `0` 。

 

**提示：**

-  $1 <= stones.length <= 30$ 

-  $1 <= stones[i] <= 1000$ 

## 2、解题思路

- 排序
- 每次取最大的进行判断
- 使用二分插入新产生的值



```python
import bisect


class Solution:
    def lastStoneWeight(self, stones: [int]) -> int:
        stones.sort()

        while len(stones) > 1:
            m = stones.pop()
            n = stones.pop()
            if m != n:
                bisect.insort(stones,m-n)
        if stones:
            return stones[0]
        return 0

```

