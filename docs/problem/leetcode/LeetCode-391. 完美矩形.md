# LeetCode: 391. 完美矩形

[TOC]

## 1、题目描述

我们有 `N` 个与坐标轴对齐的矩形, 其中 `N > 0`, 判断它们是否能精确地覆盖一个矩形区域。

每个矩形用左下角的点和右上角的点的坐标来表示。例如， 一个单位正方形可以表示为 `[1,1,2,2]`。 ( 左下角的点的坐标为 `(1, 1)` 以及右上角的点的坐标为 `(2, 2)` )。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-13-024547.gif)

**示例 1:**

```
rectangles = [
  [1,1,3,3],
  [3,1,4,2],
  [3,2,4,4],
  [1,3,2,4],
  [2,3,3,4]
]

返回 true。5个矩形一起可以精确地覆盖一个矩形区域。
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-13-024600.gif)

**示例 2:**

```
rectangles = [
  [1,1,2,3],
  [1,3,2,4],
  [3,1,4,2],
  [3,2,4,4]
]

返回 false。两个矩形之间有间隔，无法覆盖成一个矩形。
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-13-024608.gif)

**示例 3:**

```
rectangles = [
  [1,1,3,3],
  [3,1,4,2],
  [1,3,2,4],
  [3,2,4,4]
]

返回 false。图形顶端留有间隔，无法覆盖成一个矩形。
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-13-024614.gif)

**示例 4:**

```
rectangles = [
  [1,1,3,3],
  [3,1,4,2],
  [1,3,2,4],
  [2,2,4,4]
]

返回 false。因为中间有相交区域，虽然形成了矩形，但不是精确覆盖。


```



## 2、解题思路

每一个矩形都有4个节点，我们将相邻的成对的节点去掉，最后应该仅留下四周的四个节点，判断面积和节点是否满足条件即可



```python
class Solution:
    def isRectangleCover(self, rectangles: List[List[int]]) -> bool:
        area = 0
        point_set = set()

        for x, y, x1, y1 in rectangles:
            area += (x1 - x) * (y1 - y)
            point_set.add((x, y)) if (x, y) not in point_set else point_set.remove((x, y))
            point_set.add((x1, y1)) if (x1, y1) not in point_set else point_set.remove((x1, y1))
            point_set.add((x, y1)) if (x, y1) not in point_set else point_set.remove((x, y1))
            point_set.add((x1, y)) if (x1, y) not in point_set else point_set.remove((x1, y))
        if len(point_set) != 4:
            return False

        p1, p2, p3, p4 = sorted(point_set)
        if p1[0] == p2[0] and p1[1] == p3[1] and p2[1] == p4[1] and p3[0] == p4[0]:
            return (p4[1] - p1[1]) * (p4[0] - p1[0]) == area

        return False
```

