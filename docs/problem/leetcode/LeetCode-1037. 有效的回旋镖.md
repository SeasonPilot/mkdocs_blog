# LeetCode: 1037. 有效的回旋镖

[TOC]

## 1、题目描述

回旋镖定义为一组三个点，这些点各不相同且不在一条直线上。

给出平面上三个点组成的列表，判断这些点是否可以构成回旋镖。

 ```
示例 1：
输入：[[1,1],[2,3],[3,2]]
输出：true

示例 2：
输入：[[1,1],[2,2],[3,3]]
输出：false
 ```



**提示：**

-  $points.length == 3$ 

-  $points[i].length == 2$ 

-  $0 <= points[i][j] <= 100$ 



## 2、解题思路

- 判断是否有相同的点
- 利用斜率判断是否在一条直线上

```python
class Solution:
    def isBoomerang(self, points: List[List[int]]) -> bool:
        if points[0] in points[1:] or points[2] in points[:2]:
            return False

        points.sort()

        temp1 = [y - x for x, y in zip(points[0], points[1])]
        temp2 = [y - x for x, y in zip(points[1], points[2])]
        if temp1[1] == temp2[1] == 0 or temp1[0]*temp2[1] == temp1[1]*temp2[0] :
            return False
        return True
```

