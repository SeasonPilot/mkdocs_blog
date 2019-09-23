# LeetCode: 84. 柱状图中最大的矩形

[TOC]

## 1、题目描述

给定 `n` 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 `1` 。

求在该柱状图中，能够勾勒出来的矩形的最大面积。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-08-064648.png)

以上是柱状图的示例，其中每个柱子的宽度为 `1`，给定的高度为 `[2,1,5,6,2,3]`。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-08-064620.png)



图中阴影部分为所能勾勒出的最大矩形面积，其面积为 `10` 个单位。

 

**示例:**

```
输入: [2,1,5,6,2,3]
输出: 10
```



## 2、解题思路

- 题目的关键点在于寻找每一个高度的左右边界

如果直接针对每一个点查找，肯定是超时的

- 维护一个单调递增的栈
- 如果当前元素小于栈中前面的元素，表示前面的这个元素已经遇到了右面的边界，将这个元素出栈，并更新结果值
- 继续判断，直到没有大于当前元素的为止
- 需要注意的是，出栈的时候的左边界，并不是当前元素，而是前面的元素加1，因为当前元素已经将所有大于当前元素的出栈了，前面有一段空白区，也是大于当前元素的

这里有个小技巧，可以使用哨兵，在高度的前后各加一个0，这样从头到尾一遍就能得到答案，不需要额外处理边界情况

```python
class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        heights = [0] + heights + [0]

        stack = [0]
        res = 0

        for i in range(1, len(heights)):
            while heights[i] < heights[stack[-1]]:
                temp = stack.pop()
                res = max(res, (i - stack[-1] - 1) * heights[temp])
            stack.append(i)

        return res
```

