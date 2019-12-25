# LeetCode: 531. 孤独像素I

[TOC]

## 1、题目描述

给定一幅黑白像素组成的图像, 计算黑色孤独像素的数量。

图像由一个由`‘B’`和`‘W’`组成二维字符数组表示, `‘B’`和`‘W’`分别代表黑色像素和白色像素。

黑色孤独像素指的是在同一行和同一列不存在其他黑色像素的黑色像素。

**示例:**

```
输入: 
[['W', 'W', 'B'],
 ['W', 'B', 'W'],
 ['B', 'W', 'W']]

输出: 3
解析: 全部三个'B'都是黑色孤独像素。
```

**注意:**

-   输入二维数组行和列的范围是 `[1,500]`。



## 2、解题思路

-   首先统计每行每列的`B`元素个数
-   然后判断当前点对应的行列是不是只有一个`B`元素



```python
class Solution:
    def findLonelyPixel(self, picture: List[List[str]]) -> int:
        ans = 0
        row, col = len(picture), len(picture[0])
        row_count = [0] * row
        col_count = [0] * col
        for i in range(row):
            for j in range(col):
                if picture[i][j] == "B":
                    row_count[i] += 1
                    col_count[j] += 1
        for i in range(row):
            for j in range(col):
                if picture[i][j] == "B" and row_count[i] == 1 and col_count[j] == 1:
                    ans += 1
        return ans
```

