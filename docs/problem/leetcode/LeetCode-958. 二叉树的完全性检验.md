# LeetCode: 958. 二叉树的完全性检验

[TOC]

## 1、题目描述

给定一个二叉树，确定它是否是一个完全二叉树。

百度百科中对完全二叉树的定义如下：

若设二叉树的深度为 `h`，除第 h 层外，其它各层 (`1～h-1`) 的结点数都达到最大个数，第 `h` 层所有的结点都连续集中在最左边，这就是完全二叉树。（注：第 `h` 层可能包含 `1~ 2h` 个节点。）

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-06-070737.png)

```
输入：[1,2,3,4,5,6]
输出：true
解释：最后一层前的每一层都是满的（即，结点值为 {1} 和 {2,3} 的两层），且最后一层中的所有结点（{4,5,6}）都尽可能地向左。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-06-070745.png)

```
输入：[1,2,3,4,5,null,7]
输出：false
解释：值为 7 的结点没有尽可能靠向左侧。
```

**提示：**

- 树中将会有 1 到 100 个结点。

## 2、解题思路

- 使用层次遍历
- 给节点编号，非最后一排都需要满节点
- 最后一排不能有空节点



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def isCompleteTree(self, root: TreeNode) -> bool:
        temp = [(root, 1)]
        level = 0
        while temp:

            t = []
            for node, index in temp:
                if node.left:
                    t.append((node.left, 2 * index))
                if node.right:
                    t.append((node.right, 2 * index + 1))

            # 左侧验证
            if temp[0][1] != 2 ** level:
                return False
                # 验证没有空节点
            if (temp[-1][1] - temp[0][1] + 1) != len(temp):
                return False
                # 不是最后一排需要满节点
            if t and (temp[-1][1] - temp[0][1] + 1) != 2 ** level:
                return False

            level += 1
            temp = t

        return True
```

