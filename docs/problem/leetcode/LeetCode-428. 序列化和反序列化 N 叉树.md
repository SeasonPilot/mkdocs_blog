# LeetCode: 428. 序列化和反序列化 N 叉树

[TOC]

## 1、题目描述

序列化是指将一个数据结构转化为位序列的过程，因此可以将其存储在文件中或内存缓冲区中，以便稍后在相同或不同的计算机环境中恢复结构。

设计一个序列化和反序列化 N 叉树的算法。一个 N 叉树是指每个节点都有不超过 N 个孩子节点的有根树。序列化 / 反序列化算法的算法实现没有限制。你只需要保证 N 叉树可以被序列化为一个字符串并且该字符串可以被反序列化成原树结构即可。

例如，你需要序列化下面的 `3-叉` 树。

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-29-150442.png" alt="img" style="zoom:50%;" />



 

为 `[1 [3[5 6] 2 4]]`。你不需要以这种形式完成，你可以自己创造和实现不同的方法。

 

**注意：**

-   `N` 的范围在 `[1, 1000]`
-   不要使用类成员 / 全局变量 / 静态变量来存储状态。你的序列化和反序列化算法应是无状态的。



## 2、解题思路

-   递归
-   使用左右括号作为分界点

```
(1((3((5)(6)))(2)(4)))
(3((5)(6)))
(5)
(6)
(2)
(4)
```

如上，递归分解

```python
"""
# Definition for a Node.
class Node(object):
    def __init__(self, val=None, children=None):
        self.val = val
        self.children = children
"""

class Codec:

    def serialize(self, root: 'Node') -> str:
        """Encodes a tree to a single string.

        :type root: Node
        :rtype: str
        """
        if not root:
            return ""
        current = "(" + str(root.val)
        if root.children:
            current += "("
            for node in root.children:
                current += self.serialize(node)
            current += ")"

        current += ")"
        return current

    def deserialize(self, data: str) -> 'Node':
        """Decodes your encoded data to tree.

        :type data: str
        :rtype: Node
        """
        if not data:
            return None

        left_index = data[1:].index("(") if "(" in data[1:] else -1
        if left_index == -1:
            node = Node(data[1:-1])
            node.children = []
            return node
        else:
            left_index += 2
            length = len(data) - 2
            current = Node(data[1:left_index - 1])
            current.children = []
            while left_index < length:
                pre = left_index
                left_count = 1
                while left_count > 0:
                    left_index += 1
                    if data[left_index] == "(":
                        left_count += 1
                    if data[left_index] == ")":
                        left_count -= 1
                left_index += 1
                current.children.append(self.deserialize(data[pre:left_index]))

            return current


# Your Codec object will be instantiated and called as such:
# codec = Codec()
# codec.deserialize(codec.serialize(root))
```

