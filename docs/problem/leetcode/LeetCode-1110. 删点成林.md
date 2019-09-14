# LeetCode: 1110. 删点成林

[TOC]

## 1、题目描述

给出二叉树的根节点 `root`，树上每个节点都有一个不同的值。

如果节点值在 `to_delete` 中出现，我们就把该节点从树上删去，最后得到一个森林（一些不相交的树构成的集合）。

返回森林中的每棵树。你可以按任意顺序组织答案。

 

**示例：**

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-14-071034.png)

```
输入：root = [1,2,3,4,5,6,7], to_delete = [3,5]
输出：[[1,2,null,4],[6],[7]]
```

**提示：**

- `树中的节点数最大为 1000。`
- `每个节点都有一个介于 1 到 1000 之间的值，且各不相同。`
- `to_delete.length <= 1000`
- `to_delete 包含一些从 1 到 1000、各不相同的值。`



## 2、解题思路

- 递归法
- 判断断开的节点：
  - 如果左节点为待删除节点，断开左节点连接
  - 如果右节点为待删除节点，断开右节点连接
- 判断需要添加的节点：
  - 如果当前节点为待删除节点
    - 如果如果左节点不删除，添加左节点
    - 如果如果右节点不删除，添加右节点

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def delNodes(self, root: TreeNode, to_delete: List[int]) -> List[TreeNode]:
        if not root:
            return []
        res = []
        delete_set = set(to_delete)

        if root.val not in delete_set:
            res.append(root)

        def dfs(node):
            if not node:
                return

            left, right = node.left, node.right

            if node.val in delete_set:
                if left and left.val not in delete_set:
                    res.append(left)
                if right and right.val not in delete_set:
                    res.append(right)
            if left and left.val in delete_set:
                node.left = None

            if right and right.val in delete_set:
                node.right = None

            dfs(left)
            dfs(right)

        dfs(root)
        return res
```

