# LeetCode: 431. 将N叉树编码为二叉树

[TOC]

## 1、题目描述

设计一个算法，可以将 `N` 叉树编码为二叉树，并能将该二叉树解码为原 `N` 叉树。一个 `N` 叉树是指每个节点都有不超过 `N` 个孩子节点的有根树。类似地，一个二叉树是指每个节点都有不超过 `2` 个孩子节点的有根树。你的编码 / 解码的算法的实现没有限制，你只需要保证一个 `N` 叉树可以编码为二叉树且该二叉树可以解码回原始 `N` 叉树即可。

例如，你可以将下面的 `3-叉 树`以该种方式编码：

 ![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-29-142642.png)



 

```
注意，上面的方法仅仅是一个例子，可能可行也可能不可行。你没有必要遵循这种形式转化，你可以自己创造和实现不同的方法。
```

**注意：**

-   N 的范围在 `[1, 1000]`
-   不要使用类成员 / 全局变量 / 静态变量来存储状态。你的编码和解码算法应是无状态的。



## 2、解题思路

-   递归法
-   将子节点使用左子节点的右节点进行串联

```
如果当前节点有三个子节点，那么，转换完成如下所示
```

```
          ┌────────┐          
          │        │          
          │        │          
       ┌──┴───┬────┴─┐        
       │      │      │        
       │      │      │        
┌────◀─┤   ┌──┼───┐  └┬─▶────┐
│      │   │  ▼   │   │      │
│      │   │      │   │      │
└──────┘   └──────┘   └──────┘

转换后：
          ┌────────┐          
          │        │          
          │        │          
       ┌──┴────────┘          
       │                      
       │                      
┌────◀─┤                      
│      │                      
│      ├─┐                    
└──────┘ │                    
         │ ┌──────┐           
         └─▶      │           
           │      │─┐         
           └──────┘ │         
                    │         
                    │ ┌──────┐
                    └─▶      │
                      │      │
                      └──────┘
```



```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children
"""
"""
# Definition for a binary tree node.
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
"""


class Codec:

    # Encodes an n-ary tree to a binary tree.
    def encode(self, root: 'Node') -> TreeNode:
        if not root:
            return root

        current = TreeNode(root.val)
        if root.children:
            current.left = self.encode(root.children[0])
            right_node = current.left
            for node in root.children[1:]:
                right_node.right = self.encode(node)
                right_node = right_node.right

        return current

    # Decodes your binary tree to an n-ary tree.
    def decode(self, data: TreeNode) -> 'Node':
        if not data:
            return data
        node = Node(data.val)
        node.children = []
        if not data.left:
            return node
        child = data.left
        while child:
            node.children.append(self.decode(child))
            child = child.right
        return node

# Your Codec object will be instantiated and called as such:
# codec = Codec()
# codec.decode(codec.encode(root))
```

