# LeetCode: 962. 最大宽度坡

[TOC]

## 1、题目描述

给定一个整数数组 `A`，坡是元组 `(i, j)`，其中  `i < j` 且 `A[i] <= A[j]`。这样的坡的宽度为 `j - i`。

找出 `A` 中的坡的最大宽度，如果不存在，返回 `0` 。

 

**示例 1：**

```
输入：[6,0,8,2,1,5]
输出：4
解释：
最大宽度的坡为 (i, j) = (1, 5): A[1] = 0 且 A[5] = 5.
```


**示例 2：**

```
输入：[9,8,1,0,1,9,4,0,4,1]
输出：7
解释：
最大宽度的坡为 (i, j) = (2, 9): A[2] = 1 且 A[9] = 1.
```

**提示：**

-   $2 <= A.length <= 50000$
-   $0 <= A[i] <= 50000$



## 2、解题思路

-   使用栈来模拟
-   每个元素都有可能形成坡，只要右方有大于等于当前元素的即可
-   首先将坡底找出来，从左侧开始找递减序列，放入栈中
-   然后依次寻找坡顶，从右侧开始查找，如果当前元素与栈中坡底能够形成坡，更新结果，并将坡底弹出

```
由于是从右向左查找，这个坡底形成的坡在当前元素下已经是最大的坡了，因此弹出，继续判断
```



```python
class Solution:
    def maxWidthRamp(self, A: List[int]) -> int:
        length = len(A)

        ans = 0
        stack = []

        for index, num in enumerate(A):
            if (not stack) or num < A[stack[-1]]:
                stack.append(index)

        for i in range(length - 1, 0, -1):
            while stack and A[i] >= A[stack[-1]]:
                ans = max(ans, i - stack.pop())

        return ans
```

