# LeetCode: 667. 优美的排列 II

[TOC]

## 1、题目描述

给定两个整数 `n` 和 `k`，你需要实现一个数组，这个数组包含从 `1` 到 `n` 的 `n` 个不同整数，同时满足以下条件：

① 如果这个数组是 `[a1, a2, a3, ... , an]` ，那么数组 `[|a1 - a2|, |a2 - a3|, |a3 - a4|, ... , |an-1 - an|]` 中应该有且仅有 `k` 个不同整数；

② 如果存在多种答案，你只需实现并返回其中任意一种.

**示例 1:**

```
输入: n = 3, k = 1
输出: [1, 2, 3]
解释: [1, 2, 3] 包含 3 个范围在 1-3 的不同整数， 并且 [1, 1] 中有且仅有 1 个不同整数 : 1
```

**示例 2:**

```
输入: n = 3, k = 2
输出: [1, 3, 2]
解释: [1, 3, 2] 包含 3 个范围在 1-3 的不同整数， 并且 [2, 1] 中有且仅有 2 个不同整数: 1 和 2
```

**提示:**

-  `n 和 k 满足条件 1 <= k < n <= 104.`



## 2、解题思路

- n个数字能够产生的间隔一共是n-1中，分别为`1到n-1`
- 因此，首先从大到小生成k-1个，然后剩余的按照顺序，使用最小的间隔1，最终所有间隔即为k个

```python
class Solution:
    def constructArray(self, n: int, k: int) -> List[int]:
        left, right = 1, n
        res = []

        flag = True
        for i in range(k - 1):
            if flag:
                res.append(left)
                left += 1
            else:
                res.append(right)
                right -= 1
            flag = not flag

        if not flag:
            res.extend(reversed(range(left, right + 1)))
        else:
            res.extend(range(left, right + 1))
        return res
```

