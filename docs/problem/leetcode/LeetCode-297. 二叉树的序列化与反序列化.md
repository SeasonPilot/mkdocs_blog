# LeetCode: 297. 二叉树的序列化与反序列化

[TOC]

## 1、题目描述

序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。

请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。

示例: 

```
你可以将以下二叉树：

    1
   / \
  2   3
     / \
    4   5

序列化为 "[1,2,3,null,null,4,5]"
```

提示: 这与 `LeetCode` 目前使用的方式一致，详情请参阅 `LeetCode` 序列化二叉树的格式。你并非必须采取这种方式，你也可以采用其他的方法解决这个问题。

- 说明: 不要使用类的成员 / 全局 / 静态变量来存储状态，你的序列化和反序列化算法应该是无状态的。



## 2、解题思路

- 使用层级标号法

```
使用下面的形式表示一棵树：
		根节点{level}左子树{level}右子树
		
序列化与反序列化都是如此，分割三部分即可
```



```python
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Codec:
    def serialize(self, root):
        """Encodes a tree to a single string.

        :type root: TreeNode
        :rtype: str
        """

        def dfs(node, level):
            mark = "{" + str(level) + "}"

            if not node:
                return mark * 2
            left = dfs(node.left, level + 1)
            right = dfs(node.right, level + 1)

            return str(node.val) + mark + left + mark + right

        return dfs(root, 0)

    def deserialize(self, data):
        """Decodes your encoded data to tree.

        :type data: str
        :rtype: TreeNode
        """

        def dfs(d, level):
            mark = "{" + str(level) + "}"
            current, left, right = d.split(mark)
            if not current:
                return None

            node = TreeNode(int(current))
            node.left = dfs(left, level + 1)
            node.right = dfs(right, level + 1)
            return node

        return dfs(data, 0)

# Your Codec object will be instantiated and called as such:
# codec = Codec()
# codec.deserialize(codec.serialize(root))
```

