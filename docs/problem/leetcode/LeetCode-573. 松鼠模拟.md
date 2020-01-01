# LeetCode: 573. 松鼠模拟

[TOC]

## 1、题目描述

现在有一棵树，一只松鼠和一些坚果。位置由二维网格的单元格表示。你的目标是找到松鼠收集所有坚果的最小路程，且坚果是一颗接一颗地被放在树下。松鼠一次最多只能携带一颗坚果，松鼠可以向上，向下，向左和向右四个方向移动到相邻的单元格。移动次数表示路程。

**输入 1:**

```
输入: 
高度 : 5
宽度 : 7
树的位置 : [2,2]
松鼠 : [4,4]
坚果 : [[3,0], [2,5]]
输出: 12
```


**解释:**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2020-01-01-064528.png" alt="img" style="zoom:50%;" />

**注意:**

-   所有给定的位置不会重叠。
-   松鼠一次最多只能携带一颗坚果。
-   给定的坚果位置没有顺序。
-   高度和宽度是正整数。 `3 <= 高度 * 宽度 <= 10,000`。
-   给定的网格至少包含一颗坚果，唯一的一棵树和一只松鼠。



## 2、解题思路

-   松鼠从初始位置先到一个坚果的位置，然后回到树
-   剩余的坚果都是从树上去，然后回到树上，就是`2`倍的曼哈顿距离
-   只需要找到第一步，也就是松鼠先去拿的坚果，然后回到树上这一步所有的距离对整体的步数减少效果最明显的一个即可



```python
class Solution:
    def minDistance(self, height: int, width: int, tree: List[int], squirrel: List[int], nuts: List[List[int]]) -> int:
        length = len(nuts)
        tree_length = abs(tree[0] - nuts[0][0]) + abs(tree[1] - nuts[0][1])
        squirrel_length = abs(squirrel[0] - nuts[0][0]) + abs(squirrel[1] - nuts[0][1])
        save_path = [tree_length - squirrel_length, tree_length, squirrel_length]
        ans = tree_length + squirrel_length
        for i in range(1, length):
            cur_tree_length = abs(tree[0] - nuts[i][0]) + abs(tree[1] - nuts[i][1])
            cur_squirrel_length = abs(squirrel[0] - nuts[i][0]) + abs(squirrel[1] - nuts[i][1])
            if cur_tree_length - cur_squirrel_length > save_path[0]:
                ans -= save_path[2]
                ans += save_path[1]
                ans += cur_tree_length + cur_squirrel_length
                save_path = [cur_tree_length - cur_squirrel_length, cur_tree_length, cur_squirrel_length]
            else:
                ans += cur_tree_length * 2
        return ans
```

