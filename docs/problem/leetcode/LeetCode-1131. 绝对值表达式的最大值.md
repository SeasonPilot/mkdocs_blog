# LeetCode: 1131. 绝对值表达式的最大值

[TOC]

## 1、题目描述

给你两个长度相等的整数数组，返回下面表达式的最大值：

`|arr1[i] - arr1[j]| + |arr2[i] - arr2[j]| + |i - j|`

其中下标 `i，j` 满足 `0 <= i, j < arr1.length`。

 

**示例 1：**

```
输入：arr1 = [1,2,3,4], arr2 = [-1,4,5,6]
输出：13
```


**示例 2：**

```
输入：arr1 = [1,-2,-5,0,10], arr2 = [0,-2,-1,-7,-4]
输出：20
```

**提示：**

-   $2 <= arr1.length == arr2.length <= 40000$
-   $-10^6 <= arr1[i], arr2[i] <= 10^6$



## 2、解题思路

-   看成是曼哈顿距离，第一个数组看成是x，第二个数组看成是y
-   在平面上面，可能出现的情况有4种：
    -   右上-左下
    -   左下-右上
    -   左上-右下
    -   右下-左上
-   遍历一遍即可



```python
class Solution:
    def maxAbsValExpr(self, arr1: List[int], arr2: List[int]) -> int:
        directions = [(1, 1), (-1, -1), (1, -1), (-1, 1)]
        length = len(arr1)
        ans = float('-inf')
        for dx, dy in directions:
            max_value = float('-inf')
            min_value = float('inf')

            for i in range(length):
                max_value = max(max_value, arr1[i] * dx + arr2[i] * dy + i)
                min_value = min(min_value, arr1[i] * dx + arr2[i] * dy + i)

            ans = max(ans, max_value - min_value)

        return ans
```

