# LeetCode: 1051. 高度检查器

[TOC]

## 1、题目描述

学校在拍年度纪念照时，一般要求学生按照 非递减 的高度顺序排列。

请你返回至少有多少个学生没有站在正确位置数量。该人数指的是：能让所有学生以 非递减 高度排列的必要移动人数。

 

**示例：**

```
输入：[1,1,4,2,1,3]
输出：3
解释：
高度为 4、3 和最后一个 1 的学生，没有站在正确的位置。
```



**提示：**

-  $1 <= heights.length <= 100$ 

-  $1 <= heights[i] <= 100$ 



## 2、解题思路

- 高度排序
- 判断排好序的与未排序的数组有多少位置不同

```python
class Solution:
    def heightChecker(self, heights: List[int]) -> int:
        return sum([0 if x == y else 1 for x, y in zip(sorted(heights), heights)])
```

