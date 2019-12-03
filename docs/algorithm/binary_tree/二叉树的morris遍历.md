# 算法：二叉树morris遍历

[TOC]

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-03-051746.png" alt="image-20191203131742924" style="zoom:50%;" />

## 1、前序遍历

```python
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


def mirris_preorder(root: TreeNode):
    p = root
    while p:
        if not p.left:
            print(p.val)
            p = p.right
        else:
            temp = p.left
            # 找到左子树的最右子节点
            while temp.right and temp.right != p:
                temp = temp.right

            if not temp.right:
                print(p.val)
                temp.right = p
                p = p.left
            else:

                temp.right = None
                p = p.right


r = TreeNode(5)
t = r.left = TreeNode(2)
t.left = TreeNode(1)
t.right = TreeNode(3)
t = r.right = TreeNode(7)
t.left = TreeNode(6)
t.right = TreeNode(8)

mirris_preorder(r)

```



## 2、中序遍历

```python
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


def mirris_inorder(root: TreeNode):
    p = root
    while p:
        if not p.left:
            print(p.val)
            p = p.right
        else:
            temp = p.left
            # 找到左子树的最右子节点
            while temp.right and temp.right != p:
                temp = temp.right

            if not temp.right:
                temp.right = p
                p = p.left
            else:
                print(p.val)
                temp.right = None
                p = p.right


r = TreeNode(5)
t = r.left = TreeNode(2)
t.left = TreeNode(1)
t.right = TreeNode(3)
t = r.right = TreeNode(7)
t.left = TreeNode(6)
t.right = TreeNode(8)

mirris_inorder(r)

```



## 3、后序遍历

```python
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


def mirris_postorder(root: TreeNode):
    tmp = TreeNode(0)
    tmp.left = root
    p = tmp
    while p:
        if not p.left:
            # print(p.val)
            p = p.right
        else:
            temp = p.left
            # 找到左子树的最右子节点
            while temp.right and temp.right != p:
                temp = temp.right

            if not temp.right:
                temp.right = p
                p = p.left
            else:
                print_reverse(p.left, temp)
                temp.right = None
                p = p.right


def reverse_node(from_node, to_node):
    if from_node == to_node:
        return
    x, y = from_node, from_node.right
    while x != to_node:
        z = y.right
        y.right = x
        x, y = y, z


def print_reverse(from_node, to_node):
    reverse_node(from_node, to_node)
    p = to_node
    while True:
        print(p.val)
        if p == from_node:
            break
        p = p.right
    reverse_node(to_node, from_node)


r = TreeNode(5)
t = r.left = TreeNode(2)
t.left = TreeNode(1)
t.right = TreeNode(3)
t = r.right = TreeNode(7)
t.left = TreeNode(6)
t.right = TreeNode(8)

mirris_postorder(r)

```

