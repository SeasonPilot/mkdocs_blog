# LeetCode: 1274. 矩形内船只的数目

[TOC]

## 1、题目描述

(此题是 交互式问题 )

在用笛卡尔坐标系表示的二维海平面上，有一些船。每一艘船都在一个整数点上，且每一个整数点最多只有 `1` 艘船。

有一个函数 `Sea.hasShips(topRight, bottomLeft)` ，输入参数为右上角和左下角两个点的坐标，当且仅当这两个点所表示的矩形区域（包含边界）内至少有一艘船时，这个函数才返回 `true` ，否则返回 `false` 。

给你矩形的右上角 `topRight` 和左下角 `bottomLeft` 的坐标，请你返回此矩形内船只的数目。题目保证矩形内 至多只有 `10` 艘船。

调用函数 `hasShips` 超过`400`次 的提交将被判为 错误答案`（Wrong Answer）` 。同时，任何尝试绕过评测系统的行为都将被取消比赛资格。

 

**示例：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-02-051222.png" alt="img" style="zoom:50%;" />

```
输入：
ships = [[1,1],[2,2],[3,3],[5,5]], topRight = [4,4], bottomLeft = [0,0]
输出：3
解释：在 [0,0] 到 [4,4] 的范围内总共有 3 艘船。
```

**提示：**

-   `ships` 数组只用于评测系统内部初始化。你无法得知 `ships` 的信息，所以只能通过调用 `hasShips` 接口来求解。
-   $0 <= bottomLeft[0] <= topRight[0] <= 1000$
-   $0 <= bottomLeft[1] <= topRight[1] <= 1000$



## 2、解题思路

-   分治法
-   首先进行横坐标区间的切分，当横坐标切分到相等之后，进行纵坐标切分
-   最后只有一个点的时候不切分，直接计算是否存在即可



```python
# """
# This is Sea's API interface.
# You should not implement it, or speculate about its implementation
# """
#class Sea(object):
#    def hasShips(self, topRight: 'Point', bottomLeft: 'Point') -> bool:
#
#class Point(object):
#	def __init__(self, x: int, y: int):
#		self.x = x
#		self.y = y

class Solution(object):
    def countShips(self, sea: 'Sea', topRight: 'Point', bottomLeft: 'Point') -> int:
        if topRight.x == bottomLeft.x and topRight.y == bottomLeft.y:
            return 1 if sea.hasShips(topRight, bottomLeft) else 0

        ans = 0
        if topRight.x > bottomLeft.x:
            scope = topRight.x - bottomLeft.x
            mid_x = bottomLeft.x + scope // 2
            mid_left = Point(mid_x, topRight.y)
            mid_right = Point(mid_x + 1, bottomLeft.y)
            if sea.hasShips(mid_left, bottomLeft):
                ans += self.countShips(sea, mid_left, bottomLeft)
            if sea.hasShips(topRight, mid_right):
                ans += self.countShips(sea, topRight, mid_right)
            return ans

        scope = topRight.y - bottomLeft.y
        mid_bottom = Point(bottomLeft.x, bottomLeft.y + scope // 2)
        mid_up = Point(bottomLeft.x, bottomLeft.y + scope // 2 + 1)

        if sea.hasShips(mid_bottom, bottomLeft):
            ans += self.countShips(sea, mid_bottom, bottomLeft)
        if sea.hasShips(topRight, mid_up):
            ans += self.countShips(sea, topRight, mid_up)
        return ans
```



下面增加了简单的模拟代码，可以直接运行，实际中接口是需要优化的

```python
# """
# This is Sea's API interface.
# You should not implement it, or speculate about its implementation
# """
class Point(object):
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y


class Sea(object):
    def __init__(self, p):
        self.count = 0
        self.points = set([tuple(x) for x in p])

    def hasShips(self, topRight: Point, bottomLeft: Point) -> bool:
        self.count += 1
        for x in range(bottomLeft.x, topRight.x + 1):
            for y in range(bottomLeft.y, topRight.y + 1):
                if (x, y) in self.points:
                    return True
        return False


class Solution(object):
    def countShips(self, sea: Sea, topRight: Point, bottomLeft: Point) -> int:
        if topRight.x == bottomLeft.x and topRight.y == bottomLeft.y:
            return 1 if sea.hasShips(topRight, bottomLeft) else 0

        ans = 0
        if topRight.x > bottomLeft.x:
            scope = topRight.x - bottomLeft.x
            mid_x = bottomLeft.x + scope // 2
            mid_left = Point(mid_x, topRight.y)
            mid_right = Point(mid_x + 1, bottomLeft.y)
            if sea.hasShips(mid_left, bottomLeft):
                ans += self.countShips(sea, mid_left, bottomLeft)
            if sea.hasShips(topRight, mid_right):
                ans += self.countShips(sea, topRight, mid_right)
            return ans

        scope = topRight.y - bottomLeft.y
        mid_bottom = Point(bottomLeft.x, bottomLeft.y + scope // 2)
        mid_up = Point(bottomLeft.x, bottomLeft.y + scope // 2 + 1)

        if sea.hasShips(mid_bottom, bottomLeft):
            ans += self.countShips(sea, mid_bottom, bottomLeft)
        if sea.hasShips(topRight, mid_up):
            ans += self.countShips(sea, topRight, mid_up)
        return ans


points = [[1, 1], [2, 2], [3, 3], [5, 5]]
s = Sea(points)

solution = Solution()
print(solution.countShips(s, Point(100, 100), Point(0, 0)))
print(s.count)

```

