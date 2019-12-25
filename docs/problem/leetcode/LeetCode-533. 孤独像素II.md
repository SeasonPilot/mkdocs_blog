# LeetCode: 533. 孤独像素II

[TOC]

## 1、题目描述

给定一幅由黑色像素和白色像素组成的图像， 与一个正整数`N`, 找到位于某行 `R` 和某列 `C` 中且符合下列规则的黑色像素的数量:

1.  行`R` 和列`C`都恰好包括`N`个黑色像素。
2.  列`C`中所有黑色像素所在的行必须和行`R`完全相同。

图像由一个由`‘B’`和`‘W’`组成二维字符数组表示, `‘B’`和`‘W’`分别代表黑色像素和白色像素。

**示例:**

```
输入:                                            
[['W', 'B', 'W', 'B', 'B', 'W'],    
 ['W', 'B', 'W', 'B', 'B', 'W'],    
 ['W', 'B', 'W', 'B', 'B', 'W'],    
 ['W', 'W', 'B', 'W', 'B', 'W']] 

N = 3
输出: 6
解析: 所有粗体的'B'都是我们所求的像素(第1列和第3列的所有'B').
        0    1    2    3    4    5         列号                                          
0    [['W', 'B', 'W', 'B', 'B', 'W'],    
1     ['W', 'B', 'W', 'B', 'B', 'W'],    
2     ['W', 'B', 'W', 'B', 'B', 'W'],    
3     ['W', 'W', 'B', 'W', 'B', 'W']]    
行号

以R = 0行和C = 1列的'B'为例:
规则 1，R = 0行和C = 1列都恰好有N = 3个黑色像素. 
规则 2，在C = 1列的黑色像素分别位于0，1和2行。它们都和R = 0行完全相同。


```

 

**注意:**

-   输入二维数组行和列的范围是 `[1,200]`。



## 2、解题思路

-   首先统计出列中的`B`数量等于`N`并且`B`对应的行完全一致的列，进行标记，同时统计出每一行的`B`的数量
-   然后在满足条件的列中查找，是否存在恰好`B`的数量等于`N`并且该行等于此列中`B`元素对应的行





```python
class Solution:
    def findBlackPixel(self, picture: List[List[str]], N: int) -> int:
        row, col = len(picture), len(picture[0])
        row_count = [0] * row
        col_count = [0] * col
        col_pos = [-1] * col
        ans = 0

        for j in range(col):
            current = 0
            pre = []
            for i in range(row):
                if picture[i][j] == "B":
                    if col_pos[j] == -1:
                        col_pos[j] = i
                    current += 1
                    row_count[i] += 1
                    if not pre:
                        pre = picture[i]
                    if current >= 0:
                        if picture[i] != pre:
                            current = -500
            if current == N:
                col_count[j] = N


        for j in range(col):
            if col_count[j] == N:
                for i in range(row):
                    if row_count[i] == N and picture[i] == picture[col_pos[j]]:
                        ans += N
                        break
        return ans
```

