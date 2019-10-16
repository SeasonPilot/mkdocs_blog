# LeetCode: 945. 使数组唯一的最小增量

[TOC]

## 1、题目描述

给定整数数组 `A`，每次 `move` 操作将会选择任意 `A[i]`，并将其递增 `1`。

返回使 A 中的每个值都是唯一的最少操作次数。

**示例 1:**

```
输入：[1,2,2]
输出：1
解释：经过一次 move 操作，数组将变为 [1, 2, 3]。
```


**示例 2:**

```
输入：[3,2,1,2,1,7]
输出：6
解释：经过 6 次 move 操作，数组将变为 [3, 4, 1, 2, 5, 7]。
可以看出 5 次或 5 次以下的 move 操作是不能让数组的每个值唯一的。
```


**提示：**

-   `0 <= A.length <= 40000`
-   `0 <= A[i] < 40000`



## 2、解题思路

增量最小，就表示找出比当前值大的数组中不存在的那个值即可



-   先排序
-   设置一个基准值，每次先更新基准值，然后更新当前值的增量



```python
class Solution:
    def minIncrementForUnique(self, A: List[int]) -> int:
        A.sort()
        ans = 0
        base = 0
        for num in A:
            base = max(num, base)
            ans += base - num
            base += 1

        return ans
```

