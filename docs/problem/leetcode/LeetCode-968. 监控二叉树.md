# LeetCode: 968. 监控二叉树

[TOC]

## 1、题目描述

给定一个二叉树，我们在树的节点上安装摄像头。

节点上的每个摄影头都可以监视其父对象、自身及其直接子对象。

计算监控树的所有节点所需的最小摄像头数量。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-06-062932.png)

```
输入：[0,0,null,0,0]
输出：1
解释：如图所示，一台摄像头足以监控所有节点。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-06-062943.png)

```
输入：[0,0,null,0,null,0,null,null,0]
输出：2
解释：需要至少两个摄像头来监视树的所有节点。 上图显示了摄像头放置的有效位置之一。
```

**提示：**

- 给定树的节点数的范围是 [1, 1000]。
- 每个节点的值都是 0。



## 2、解题思路

- 使用不同的状态表示当前节点是否被监控
- 如果是叶子节点，就返回1，表示需要监控
- 如果当前节点中左右节点需要监控，那么就放摄像头，返回2
- 如果子节点是2，表示当前节点被子节点监控，返回0，表示重新开始



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def minCameraCover(self, root: TreeNode) -> int:
        """
        状态值：
           0：None
           1：等待监控
           2：有摄像头
        :param root:
        :return:
        """
        res = 0

        def dfs(node):
            nonlocal res
            if not node:
                return 0

            left = dfs(node.left)
            right = dfs(node.right)

            if left == 0 and right == 0:
                return 1
            if left == 1 or right == 1:
                res += 1
                return 2
            if left == 2 or right == 2:
                return 0

        if dfs(root) == 1:
            res += 1
        return res
```

