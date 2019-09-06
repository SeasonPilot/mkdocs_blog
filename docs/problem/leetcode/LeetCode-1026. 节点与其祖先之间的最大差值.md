# LeetCode: 1026. 节点与其祖先之间的最大差值

[TOC]

## 1、题目描述

给定二叉树的根节点 `root`，找出存在于不同节点 `A` 和 `B` 之间的最大值 V，其中 `V = |A.val - B.val|`，且 `A` 是 `B` 的祖先。

（如果 `A` 的任何子节点之一为 `B`，或者 `A` 的任何子节点是 `B` 的祖先，那么我们认为 `A` 是 `B` 的祖先）

 

**示例：**

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-06-021920.jpg)

```
输入：[8,3,10,1,6,null,14,null,null,4,7,13]
输出：7
解释： 
我们有大量的节点与其祖先的差值，其中一些如下：
|8 - 3| = 5
|3 - 7| = 4
|8 - 1| = 7
|10 - 13| = 3
在所有可能的差值中，最大值 7 由 |8 - 1| = 7 得出。
```

**提示：**

- `树中的节点数在 2 到 5000 之间。`
- `每个节点的值介于 0 到 100000 之间。`

## 2、解题思路

- 递归法
- 从下级向上传递3个值，分别是

```
最大差值   最大节点值  最小节点值
```

不断地更新这三个值，向上传递



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def maxAncestorDiff(self, root: TreeNode) -> int:
        res = 0

        def dfs(node: TreeNode):
            if not node.left and not node.right:
                return  0, node.val, node.val

            if not node.left:
                rm, r1, r2 = dfs(node.right)
                cur = max([abs(node.val - x) for x in [r1, r2]] + [rm])
                temp = [r1, r2, node.val]
                return cur, max(temp), min(temp)
            elif not node.right:
                lm, l1, l2 = dfs(node.left)
                cur = max([abs(node.val - x) for x in [l1, l2]] + [lm])
                temp = [l1, l2, node.val]
                return cur, max(temp), min(temp)
            else:

                lm, l1, l2 = dfs(node.left)
                rm, r1, r2 = dfs(node.right)
                cur = max([abs(node.val - x) for x in [l1, l2, r1, r2]] + [lm, rm])
                temp = [l1, l2, r1, r2, node.val]
                return cur, max(temp), min(temp)

        res, _, _ = dfs(root)
        return res
```

