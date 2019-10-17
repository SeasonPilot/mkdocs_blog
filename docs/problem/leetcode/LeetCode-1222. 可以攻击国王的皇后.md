# LeetCode: 1222. 可以攻击国王的皇后

[TOC]

## 1、题目描述

在一个 `8x8` 的棋盘上，放置着若干「黑皇后」和一个「白国王」。

「黑皇后」在棋盘上的位置分布用整数坐标数组 `queens` 表示，「白国王」的坐标用数组 `king` 表示。

「黑皇后」的行棋规定是：横、直、斜都可以走，步数不受限制，但是，不能越子行棋。

请你返回可以直接攻击到「白国王」的所有「黑皇后」的坐标（任意顺序）。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-17-071851.jpg)

```
输入：queens = [[0,1],[1,0],[4,0],[0,4],[3,3],[2,4]], king = [0,0]
输出：[[0,1],[1,0],[3,3]]
解释： 
[0,1] 的皇后可以攻击到国王，因为他们在同一行上。 
[1,0] 的皇后可以攻击到国王，因为他们在同一列上。 
[3,3] 的皇后可以攻击到国王，因为他们在同一条对角线上。 
[0,4] 的皇后无法攻击到国王，因为她被位于 [0,1] 的皇后挡住了。 
[4,0] 的皇后无法攻击到国王，因为她被位于 [1,0] 的皇后挡住了。 
[2,4] 的皇后无法攻击到国王，因为她和国王不在同一行/列/对角线上。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-17-071900.jpg)

```
输入：queens = [[0,0],[1,1],[2,2],[3,4],[3,5],[4,4],[4,5]], king = [3,3]
输出：[[2,2],[3,4],[4,4]]
```

**示例 3：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-17-071909.jpg)

```
输入：queens = [[5,6],[7,7],[2,1],[0,7],[1,6],[5,1],[3,7],[0,3],[4,0],[1,2],[6,3],[5,0],[0,4],[2,2],[1,1],[6,4],[5,4],[0,0],[2,6],[4,5],[5,2],[1,4],[7,5],[2,3],[0,5],[4,2],[1,0],[2,7],[0,1],[4,6],[6,1],[0,6],[4,3],[1,7]], king = [3,4]
输出：[[2,3],[1,4],[1,6],[3,7],[4,3],[5,4],[4,5]]
```

**提示：**

-   `1 <= queens.length <= 63`
-   `queens[0].length == 2`
-   `0 <= queens[i][j] < 8`
-   `king.length == 2`
-   `0 <= king[0], king[1] < 8`
-   `一个棋盘格上最多只能放置一枚棋子。`



## 2、解题思路

-   从国王开始出发，最多有8个方向可以攻击到国王，找到8条路径上面是否存在皇后，存在的话，找出第一个



```python
class Solution:
    def queensAttacktheKing(self, queens: List[List[int]], king: List[int]) -> List[List[int]]:
        row, col = 8, 8
        ans = []

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        ans = [[] for _ in range(8)]
        k_x, k_y = king
        # 上面3个方向

        for i in range(1, k_x + 1):
            if not ans[0] and available(k_x - i, k_y - i):
                if [k_x - i, k_y - i] in queens:
                    ans[0] = [k_x - i, k_y - i]
            if not ans[1] and available(k_x - i, k_y):
                if [k_x - i, k_y] in queens:
                    ans[1] = [k_x - i, k_y]
            if not ans[2] and available(k_x - i, k_y + i):
                if [k_x - i, k_y + i] in queens:
                    ans[2] = [k_x - i, k_y + i]
        # 下面三个方向
        for i in range(1, row - k_x):
            if not ans[4] and available(k_x + i, k_y + i):
                if [k_x + i, k_y + i] in queens:
                    ans[4] = [k_x + i, k_y + i]
            if not ans[5] and available(k_x + i, k_y):
                if [k_x + i, k_y] in queens:
                    ans[5] = [k_x + i, k_y]
            if not ans[6] and available(k_x + i, k_y - i):
                if [k_x + i, k_y - i] in queens:
                    ans[6] = [k_x + i, k_y - i]

        for y in range(k_y + 1, col):
            if [k_x, y] in queens:
                ans[3] = [k_x, y]
                break
        for y in range(k_y - 1, -1, -1):
            if [k_x, y] in queens:
                ans[7] = [k_x, y]
                break

        return [x for x in ans if x]

```

