# LeetCode: 1145. 二叉树着色游戏

[TOC]

## 1、题目描述

有两位极客玩家参与了一场「二叉树着色」的游戏。游戏中，给出二叉树的根节点 `root`，树上总共有 `n` 个节点，且 `n` 为奇数，其中每个节点上的值从 `1` 到 `n` 各不相同。

 

游戏从「一号」玩家开始（「一号」玩家为红色，「二号」玩家为蓝色），最开始时，

「一号」玩家从 `[1, n]` 中取一个值 `x（1 <= x <= n）`；

「二号」玩家也从 `[1, n]` 中取一个值 `y（1 <= y <= n）`且 `y != x`。

「一号」玩家给值为 `x` 的节点染上红色，而「二号」玩家给值为 `y` 的节点染上蓝色。

 

之后两位玩家轮流进行操作，每一回合，玩家选择一个他之前涂好颜色的节点，将所选节点一个 未着色 的邻节点（即左右子节点、或父节点）进行染色。

如果当前玩家无法找到这样的节点来染色时，他的回合就会被跳过。

若两个玩家都没有可以染色的节点时，游戏结束。着色节点最多的那位玩家获得胜利 ✌️。

 

现在，假设你是「二号」玩家，根据所给出的输入，假如存在一个 y 值可以确保你赢得这场游戏，则返回 `true`；若无法获胜，就请返回 `false`。

 

**示例：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-07-005824.png)

```
输入：root = [1,2,3,4,5,6,7,8,9,10,11], n = 11, x = 3
输出：True
解释：第二个玩家可以选择值为 2 的节点。
```

**提示：**

- `二叉树的根节点为 root，树上由 n 个节点，节点上的值从 1 到 n 各不相同。`
  `n 为奇数。`
- `1 <= x <= n <= 100`



## 2、解题思路

- 如何判断蓝色节点存在必胜呢？
- 初始的红色状态的节点，如果将这个节点拿掉，整个被分成了3颗子树
- 如果这3个子树的节点数量有超过一半的，那么另一个人选择了这个子树的相连节点就能获得胜利



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def btreeGameWinningMove(self, root: TreeNode, n: int, x: int) -> bool:
        left_red, right_red = 0, 0

        def dfs(node):
            nonlocal left_red, right_red
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            if node.val == x:
                left_red = left
                right_red = right

            return left + right + 1

        dfs(root)
        half = n // 2
        return any([x > half for x in [(n - left_red - right_red - 1), left_red, right_red]])

```



