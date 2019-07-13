# LeetCode: 716. 最大栈

[TOC]

## 1、题目描述

设计一个最大栈，支持 push、pop、top、peekMax 和 popMax 操作。



1. push(x) -- 将元素 x 压入栈中。
2. pop() -- 移除栈顶元素并返回这个值。
3.       top() -- 返回栈顶元素。
4.       peekMax() -- 返回栈中最大元素。
5.    popMax() -- 返回栈中最大的元素，并将其删除。如果有多个最大元素，只要删除最靠近栈顶的那个。



样例 1:

```
MaxStack stack = new MaxStack();
stack.push(5); 
stack.push(1);
stack.push(5);
stack.top(); -> 5
stack.popMax(); -> 5
stack.top(); -> 1
stack.peekMax(); -> 5
stack.pop(); -> 1
stack.top(); -> 5

```

**注释:**

1. -1e7 <= x <= 1e7
2. 操作次数不会超过 10000。
3. 当栈为空的时候不会出现后四个操作。

## 2、解题思路



```python
class MaxStack:
    
    
    def __init__(self):
        """
        initialize your data structure here.
        """
        self.stack = list()

    def push(self, x: int) -> None:
        self.stack.append(x)

    def pop(self) -> int:
        return self.stack.pop()

    def top(self) -> int:
        return self.stack[-1]

    def peekMax(self) -> int:
        return max(self.stack)

    def popMax(self) -> int:
        if not self.stack:
            return None
        max_val = max(self.stack)
        for index in range(len(self.stack)-1,-1,-1):
            if self.stack[index] == max_val:
                return self.stack.pop(index)

        


# Your MaxStack object will be instantiated and called as such:
# obj = MaxStack()
# obj.push(x)
# param_2 = obj.pop()
# param_3 = obj.top()
# param_4 = obj.peekMax()
# param_5 = obj.popMax()
```

