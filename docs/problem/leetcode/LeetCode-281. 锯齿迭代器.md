# LeetCode: 281. 锯齿迭代器

[TOC]

## 1、题目描述

给出两个一维的向量，请你实现一个迭代器，交替返回它们中间的元素。

**示例:**

```
输入:
v1 = [1,2]
v2 = [3,4,5,6] 

输出: [1,3,2,4,5,6]

解析: 通过连续调用 next 函数直到 hasNext 函数返回 false，
     next 函数返回值的次序应依次为: [1,3,2,4,5,6]。
```

**拓展**：假如给你 k 个一维向量呢？你的代码在这种情况下的扩展性又会如何呢?

**拓展声明：**
 “锯齿” 顺序对于 `k > 2` 的情况定义可能会有些歧义。所以，假如你觉得 “锯齿” 这个表述不妥，也可以认为这是一种 “循环”。例如：

```
输入:
[1,2,3]
[4,5,6,7]
[8,9]

输出: [1,4,8,2,5,9,3,6,7].


```



## 2、解题思路

-   设置多个索引值，每次取出一个即可



```python
class ZigzagIterator:
    def __init__(self, v1: List[int], v2: List[int]):
        self.length = len(v1) + len(v2)
        self.count = 0
        self.current = -1
        self.pos = [0] * 2
        self.items = [v1, v2]
        self.item_length = 2

    def next(self) -> int:
        temp = 0
        while self.count < self.length:
            self.current = (self.current + 1) % self.item_length
            if self.pos[self.current] < len(self.items[self.current]):
                temp = self.items[self.current][self.pos[self.current]]
                self.pos[self.current] += 1
                self.count += 1
                break
        return temp

    def hasNext(self) -> bool:
        return self.count < self.length


# Your ZigzagIterator object will be instantiated and called as such:
# i, v = ZigzagIterator(v1, v2), []
# while i.hasNext(): v.append(i.next())
```

