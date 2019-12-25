# LeetCode: 469. 凸多边形

[TOC]

## 1、题目描述

给定一个按顺序连接的多边形的顶点，判断该多边形是否为凸多边形。（凸多边形的定义）

**注：**

1.  顶点个数至少为 `3` 个且不超过 `10,000`。
2.  坐标范围为 `-10,000` 到 `10,000`。
3.  你可以假定给定的点形成的多边形均为简单多边形（简单多边形的定义）。换句话说，保证每个顶点处恰好是两条边的汇合点，并且这些边 互不相交 。

**示例 1：**

```
[[0,0],[0,1],[1,1],[1,0]]

输出： True
```

解释：

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-015002.png)

**示例 2：**

```
[[0,0],[0,10],[10,10],[10,0],[5,5]]

输出： False
```

解释：

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-015007.png)

## 2、解题思路

-   判定顺逆时针法

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-014906.png" alt="image-20191225091915170" style="zoom:50%;" />

如上所示，三个点，从A到B到C，判断是顺时针还是逆时针

```
A   (0,0)
B   (4,-2)
C   (6,-6)
```

通过B点和C点对A点坐标的相对距离来判断

-   $x_{ba}$表示B点x坐标减去A点x坐标
-   $y_{ba}$B点y坐标减去A点y坐标



如上图所示的虚线，如果C点在AB的延长线上，那么C点坐标相对于B点坐标横纵坐标的增长率是一样的，如果顺时针的话，也就是纵坐标增长的更快，逆时针的话，横坐标增长更快

因此有如下判断：

-   **若为顺时针：**

$$
\frac{x_{ca}}{x_{ba}} < \frac{y_{ca}}{y_{ba}}\\
x_{ca}*y_{ba} > x_{ba}*y_{ca}\\
x_{ba}*y_{ca} - x_{ca}*y_{ba} <0
$$



因此，如上所示，判定是小于0还是大于零，就能判断是否是顺时针

-   多边形的旋转方向要么都是顺时针，要么都是逆时针，判断是否发生了改变即可



```python
class Solution:
    def isConvex(self, points: List[List[int]]) -> bool:
        length = len(points)
        pre_status = 0
        for i in range(length):
            diff_x1 = points[(i + 1) % length][0] - points[i][0]
            diff_x2 = points[(i + 2) % length][0] - points[i][0]
            diff_y1 = points[(i + 1) % length][1] - points[i][1]
            diff_y2 = points[(i + 2) % length][1] - points[i][1]
            cur_status = diff_x1 * diff_y2 - diff_x2 * diff_y1
            if cur_status:
                if pre_status * cur_status < 0:
                    return False
                else:
                    pre_status = cur_status
        return True
```

