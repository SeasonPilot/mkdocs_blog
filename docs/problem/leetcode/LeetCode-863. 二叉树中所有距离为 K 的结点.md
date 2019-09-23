# LeetCode: 863. 二叉树中所有距离为 K 的结点

[TOC]

## 1、题目描述

给定一个二叉树（具有根结点 `root`）， 一个目标结点 `target` ，和一个整数值 `K` 。

返回到目标结点 `target` 距离为 K 的所有结点的值的列表。 答案可以以任何顺序返回。

 

**示例 1：**

```
输入：root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, K = 2

输出：[7,4,1]

解释：
所求结点为与目标结点（值为 5）距离为 2 的结点，
值分别为 7，4，以及 1
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-06-121436.png)

```
注意，输入的 "root" 和 "target" 实际上是树上的结点。
上面的输入仅仅是对这些对象进行了序列化描述。
```

**提示：**

- `给定的树是非空的，且最多有 K 个结点。`
- `树上的每个结点都具有唯一的值 0 <= node.val <= 500 。`
- `目标结点 target 是树上的结点。`
- `0 <= K <= 1000.`



## 2、解题思路

- 先使用DFS转成图，然后使用BFS



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def distanceK(self, root, target, K):
        """
        :type root: TreeNode
        :type target: TreeNode
        :type K: int
        :rtype: List[int]
        """
        
        
        from collections import defaultdict

        if K == 0:
            return [target.val]

        graph = defaultdict(set)

        def dfs(node):
            if not node:
                return
            for n in (node.left, node.right):
                if n:
                    graph[node.val].add(n.val)
                    graph[n.val].add(node.val)
                    dfs(n)

        def bfs(node, steps):

            temp = {node}
            step = 0
            visited = set()
            while temp and step < steps:
                t = set()
                visited.update(temp)
                for n in temp:
                    t.update(graph[n]-visited)
                
                step += 1
                print(temp)
                temp = t

            return list(temp)
        dfs(root)

        return bfs(target.val, K)
```

