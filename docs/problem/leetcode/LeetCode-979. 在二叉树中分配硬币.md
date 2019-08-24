# LeetCode: 979. 在二叉树中分配硬币

[TOC]

## 1、题目描述

给定一个有 N 个结点的二叉树的根结点 root，树中的每个结点上都对应有 node.val 枚硬币，并且总共有 N 枚硬币。

在一次移动中，我们可以选择两个相邻的结点，然后将一枚硬币从其中一个结点移动到另一个结点。(移动可以是从父结点到子结点，或者从子结点移动到父结点。)。

返回使每个结点上只有一枚硬币所需的移动次数。

 

**示例 1：**

![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2019/01/19/tree1.png)

```
输入：[3,0,0]
输出：2
解释：从树的根结点开始，我们将一枚硬币移到它的左子结点上，一枚硬币移到它的右子结点上。

```

**示例 2：**

![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2019/01/19/tree2.png)

```
输入：[0,3,0]
输出：3
解释：从根结点的左子结点开始，我们将两枚硬币移到根结点上 [移动两次]。然后，我们把一枚硬币从根结点移到右子结点上。
```

**示例 3：**

![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2019/01/19/tree3.png)

```
输入：[1,0,2]
输出：2
```

**示例 4：**

![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2019/01/19/tree4.png)

```
输入：[1,0,0,null,3]
输出：4
```

**提示：**

-  $1<= N <= 100$ 

-  $0 <= node.val <= N$ 

## 2、解题思路

- 判断需要移动的数量，那么就是判断每一个节点需要向其他节点分配的硬币数
- 默认需要一个硬币
  - 那么如果该节点有1个硬币，需要分配的就为0
  - 如果有0个硬币，需要分配的是-1
  - 如果有多余1个硬币，那么就是n-1
- 我们从最底层的节点开始计算，什么时候会产生移动呢
  - 就是当前节点需要分配的硬币数量不为0的时候
  - 然后向上层所要或者是发送，这时候产生了移动
  - 对一个节点来说，移动数量就是左节点分配数加上右节点分配数量
  - 当前节点还会向上层传递，表示当前节点需要分配的数量 `node.val + left + right`
  - 直接加减也会将通过该节点直接能够传递硬币的情况消除掉，而不需要向上传递



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def distributeCoins(self, root: TreeNode) -> int:
        ans = 0

        def dfs(node):
            nonlocal ans
            if not node:
                return 0

            left, right = dfs(node.left), dfs(node.right)

            ans += abs(left) + abs(right)
            return node.val + left + right - 1

        dfs(root)
        return ans
```

