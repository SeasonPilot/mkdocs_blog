# LeetCode: 655. 输出二叉树

[TOC]

## 1、题目描述

在一个 `m*n` 的二维字符串数组中输出二叉树，并遵守以下规则：

行数 `m` 应当等于给定二叉树的高度。
列数 `n` 应当总是奇数。
根节点的值（以字符串格式给出）应当放在可放置的第一行正中间。根节点所在的行与列会将剩余空间划分为两部分（左下部分和右下部分）。你应该将左子树输出在左下部分，右子树输出在右下部分。左下和右下部分应当有相同的大小。即使一个子树为空而另一个非空，你不需要为空的子树输出任何东西，但仍需要为另一个子树留出足够的空间。然而，如果两个子树都为空则不需要为它们留出任何空间。
每个未使用的空间应包含一个空的字符串""。
使用相同的规则输出子树。
**示例 1:**

```
输入:
     1
    /
   2
输出:
[["", "1", ""],
 ["2", "", ""]]
```

**示例 2:**

```
输入:
     1
    / \
   2   3
    \
     4
输出:
[["", "", "", "1", "", "", ""],
 ["", "2", "", "", "", "3", ""],
 ["", "", "4", "", "", "", ""]]
```


**示例 3:**

```
输入:
      1
     / \
    2   5
   / 
  3 
 / 
4 
输出:
[["",  "",  "", "",  "", "", "", "1", "",  "",  "",  "",  "", "", ""]
 ["",  "",  "", "2", "", "", "", "",  "",  "",  "",  "5", "", "", ""]
 ["",  "3", "", "",  "", "", "", "",  "",  "",  "",  "",  "", "", ""]
 ["4", "",  "", "",  "", "", "", "",  "",  "",  "",  "",  "", "", ""]]
```



- 注意: 二叉树的高度在范围 [1, 10] 中。

## 2、解题思路

- 首先获取二叉树的深度level
- 每一行的长度即为`2^level -1`
- 然后对每个节点进行赋值
- 这时候采取区间法，也就是当前节点管理的区间范围，该节点放到中间

```
如一共4层，每一层为15个
那么根节点管理 0-15， 所以根节点应该放到 第7个位置，也就是[0,7]
左子节点分管0-6 ，所以左节点位置为[1,3]
右子节点分管8-15，所以有几点位置为[1,11]
以此类推.
```



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def printTree(self, root: TreeNode) -> List[List[str]]:
        
        def get_level(node):
            if not node:
                return 0

            left = get_level(node.left)
            right = get_level(node.right)
            return max(left + 1, right + 1)

        levels = get_level(root)

        res = [["" for _ in range(2 ** levels - 1)] for _ in range(levels)]

        def write_matrix(node, level, start, end):
            if not node:
                return

            current = (start + end) // 2
            res[level][current] = str(node.val)
            write_matrix(node.left, level + 1, start, current - 1)
            write_matrix(node.right, level + 1, current + 1, end)

        res[0][(2 ** levels - 1) // 2] = str(root.val)
        write_matrix(root, 0, 0, 2 ** levels - 2)
        return res
```

