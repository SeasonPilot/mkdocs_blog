# LeetCode: 1232. 缀点成线

[TOC]

## 1、题目描述

在一个 `XY` 坐标系中有一些点，我们用数组 `coordinates` 来分别记录它们的坐标，其中 `coordinates[i] = [x, y]` 表示横坐标为 `x`、纵坐标为 `y` 的点。

请你来判断，这些点是否在该坐标系中属于同一条直线上，是则返回 <font color="#c7254e" face="Menlo, Monaco, Consolas, Courier New, monospace">true</font>，否则请返回 <font color="#c7254e" face="Menlo, Monaco, Consolas, Courier New, monospace">false</font>。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-20-112730.jpg)

```
输入：coordinates = [[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]]
输出：true
```

**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-20-112737.jpg)

```
输入：coordinates = [[1,1],[2,2],[3,4],[4,5],[5,6],[7,7]]
输出：false
```

**提示：**

-   $2 <= coordinates.length <= 1000$
-   $coordinates[i].length == 2$
-   $-10^4 <= coordinates[i][0], coordinates[i][1] <= 10^4$
-   `coordinates 中不含重复的点`



## 2、解题思路

-   判断任意的节点与前两个节点横纵坐标的比例是否相同，出现不相同的返回`False`



```python
class Solution:
    def checkStraightLine(self, coordinates: List[List[int]]) -> bool:
        x, y = coordinates[0]
        diff_x, diff_y = coordinates[1][0] - x, coordinates[1][1] - y

        for x1, y1 in coordinates[2:]:
            x_diff, y_diff = x1 - x, y1 - y
            if x_diff * diff_y != diff_x * y_diff:
                return False
        return True
```

