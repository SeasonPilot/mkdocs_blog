# LeetCode: 42. 接雨水

[TOC]

## 1、题目描述

给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。

![trapping-rain-water](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-033419.png)

上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。 感谢 Marcos 贡献此图。

**示例:**

```
输入: [0,1,0,2,1,0,1,3,2,1,2,1]
输出: 6
```



## 2、解题思路

- 找出最大值所在的位置
- 分别从左右向最大值逼近

```python
class Solution:
    def trap(self, height: List[int]) -> int:
        if not height:
            return 0
        res = 0

        max_index = height.index(max(height))

        left = 0
        right = len(height) - 1

        temp = height[left]
        while left < max_index:
            if height[left] < temp:
                res += temp - height[left]
            else:
                temp = height[left]
            left += 1

        temp = height[right]
        while right > max_index:
            if height[right] < temp:
                res += temp - height[right]
            else:
                temp = height[right]
            right -= 1

        return res
```

