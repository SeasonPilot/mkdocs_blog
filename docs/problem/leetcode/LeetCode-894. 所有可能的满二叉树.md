# LeetCode: 894. 所有可能的满二叉树

[TOC]

## 1、题目描述

满二叉树是一类二叉树，其中每个结点恰好有 0 或 2 个子结点。

返回包含 N 个结点的所有可能满二叉树的列表。 答案的每个元素都是一个可能树的根结点。

答案中每个树的每个结点都必须有 `node.val=0`。

你可以按任何顺序返回树的最终列表。

 

**示例：**

```
输入：7
输出：[[0,0,0,null,null,0,0,null,null,0,0],[0,0,0,null,null,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,null,null,null,null,0,0],[0,0,0,0,0,null,null,0,0]]

```

**解释：**

![](https://aliyun-lc-upload.oss-cn-hangzhou.aliyuncs.com/aliyun-lc-upload/uploads/2018/08/24/fivetrees.png) 



**提示：**

- `1 <= N <= 20`

## 2、解题思路

- 如果是偶数，不能组成满二叉树
- 如果是1，直接返回一个节点
- 左右子树节点数量肯定一个是奇数，一个是偶数，从1开始，每一次变化2，递归查找左子树和右子树所有可能变化
- 然后针对每一种左右子树组合，新建一个根节点，放入结果集中

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def allPossibleFBT(self, N: int) -> List[TreeNode]:
        if not N % 2:
            return []

        if N == 1:
            return [TreeNode(0)]

        ans = []
        for i in range(1, N, 2):
            left = self.allPossibleFBT(i)
            right = self.allPossibleFBT(N - 1 - i)

            for left_node in left:
                for right_node in right:
                    head = TreeNode(0)
                    head.left = left_node
                    head.right = right_node
                    ans.append(head)
        return ans
```

