# LeetCode: 1172. 餐盘栈

[TOC]

## 1、题目描述

我们把无限数量 `∞` 的栈排成一行，按从左到右的次序从 `0` 开始编号。每个栈的的最大容量 `capacity` 都相同。

实现一个叫「餐盘」的类 `DinnerPlates`：

-   `DinnerPlates(int capacity)` - 给出栈的最大容量 `capacity`。
-   `void push(int val)` - 将给出的正整数 `val` 推入 从左往右第一个 没有满的栈。
-   `int pop()` - 返回 从右往左第一个 非空栈顶部的值，并将其从栈中删除；如果所有的栈都是空的，请返回 `-1`。
-   `int popAtStack(int index)` - 返回编号 `index` 的栈顶部的值，并将其从栈中删除；如果编号 `index` 的栈是空的，请返回 `-1`。

**示例：**

```
输入： 
["DinnerPlates","push","push","push","push","push","popAtStack","push","push","popAtStack","popAtStack","pop","pop","pop","pop","pop"]
[[2],[1],[2],[3],[4],[5],[0],[20],[21],[0],[2],[],[],[],[],[]]
输出：
[null,null,null,null,null,null,2,null,null,20,21,5,4,3,1,-1]

解释：
DinnerPlates D = DinnerPlates(2);  // 初始化，栈最大容量 capacity = 2
D.push(1);
D.push(2);
D.push(3);
D.push(4);
D.push(5);         // 栈的现状为：    2  4
                                    1  3  5
                                    ﹈ ﹈ ﹈
D.popAtStack(0);   // 返回 2。栈的现状为：      4
                                          1  3  5
                                          ﹈ ﹈ ﹈
D.push(20);        // 栈的现状为：  20  4
                                   1  3  5
                                   ﹈ ﹈ ﹈
D.push(21);        // 栈的现状为：  20  4 21
                                   1  3  5
                                   ﹈ ﹈ ﹈
D.popAtStack(0);   // 返回 20。栈的现状为：       4 21
                                            1  3  5
                                            ﹈ ﹈ ﹈
D.popAtStack(2);   // 返回 21。栈的现状为：       4
                                            1  3  5
                                            ﹈ ﹈ ﹈ 
D.pop()            // 返回 5。栈的现状为：        4
                                            1  3 
                                            ﹈ ﹈  
D.pop()            // 返回 4。栈的现状为：    1  3 
                                           ﹈ ﹈   
D.pop()            // 返回 3。栈的现状为：    1 
                                           ﹈   
D.pop()            // 返回 1。现在没有栈。
D.pop()            // 返回 -1。仍然没有栈。
```

**提示：**

-   `1 <= capacity <= 20000`
-   `1 <= val <= 20000`
-   `0 <= index <= 100000`
-   `最多会对 push，pop，和 popAtStack 进行 200000 次调用。`



## 2、解题思路

-   使用栈来保存弹出的历史位置
-   需要注意的就是，再进行pop的时候，历史栈可能被清空，因此在push的时候，需要首先进行有效位置判断



```python
import heapq


class DinnerPlates:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.stack = []
        self.heap = []

    def push(self, val: int) -> None:
		# 有效位置判断
        while self.heap and self.heap[0] >= len(self.stack):
            heapq.heappop(self.heap)
        if self.heap:
            self.stack[heapq.heappop(self.heap)].append(val)
        elif not self.stack or len(self.stack[-1]) == self.capacity:
            self.stack.append([val])
        else:
            self.stack[-1].append(val)

    def pop(self) -> int:
        for i in range(len(self.stack) - 1, -1, -1):
            if self.stack[i]:
                return self.stack[i].pop()
            self.stack.pop()
        return -1

    def popAtStack(self, index: int) -> int:
        if index >= len(self.stack) or not self.stack[index]:
            return -1

        heapq.heappush(self.heap, index)
        return self.stack[index].pop()
```



下面使用了树状数组，可惜超时了

```python
class BinaryIndexTree:
    def __init__(self, nums):
        """
        :type nums: List[int]
        """

        self.nums = nums
        self.buff = [0] * (len(nums) + 1)
        for i in range(1, len(nums) + 1):
            temp = nums[i - 1]
            while i < (len(nums) + 1):
                self.buff[i] += temp
                i += i & (-i)

    def extend(self, val):
        self.nums.append(val)
        self.buff.append(val)

        index = len(self.buff) - 1
        res = 0
        count = 0
        max_num = index & -index
        while 2 ** count < max_num:
            res += self.buff[index - (2 ** count)]
            count += 1
        self.buff[-1] += res

    def update(self, i, val):
        """
        :type i: int
        :type val: int
        :rtype: void
        """
        index = i + 1
        diff = val
        while index < len(self.buff):
            self.buff[index] += diff
            index += index & (-index)

        self.nums[i] += val

    def sumRange(self, i, j):
        """
        :type i: int
        :type j: int
        :rtype: int
        """
        return self.getSum(j) - self.getSum(i - 1)

    def getSum(self, index):
        res = 0
        index += 1

        while index > 0:
            res += self.buff[index]
            index -= index & (-index)

        return res


class DinnerPlates:

    def __init__(self, capacity: int):
        self.bit = BinaryIndexTree([])
        self.capacity = capacity
        self.stack = []

    def push(self, val: int) -> None:
        if len(self.stack) == 0 or self.bit.getSum(len(self.stack) - 1) == self.capacity * len(self.stack):
            self.stack.append([val])
            self.bit.extend(1)
        else:
            left, right = 0, len(self.stack) - 1
            while left != right:
                mid = (left + right) // 2
                left_count = self.bit.sumRange(left, mid)
                if left_count < self.capacity * (mid - left + 1):
                    right = mid
                else:
                    left = mid + 1

            self.stack[left].append(val)
            self.bit.update(left, 1)

    def pop(self) -> int:
        if len(self.stack) == 0 or self.bit.getSum(len(self.stack) - 1) == 0:
            return -1

        left, right = 0, len(self.stack) - 1
        while left != right:
            mid = (left + right) // 2
            mid = mid + 1 if mid == left else mid
            right_count = self.bit.sumRange(mid, right)
            if right_count > 0:
                left = mid
            else:
                right = mid - 1
        print("===: ", left)
        self.bit.update(left, -1)
        return self.stack[left].pop()

    def popAtStack(self, index: int) -> int:
        if index >= len(self.stack):
            return -1
        if len(self.stack[index]) > 0:
            self.bit.update(index, -1)
            return self.stack[index].pop()

        return -1


# Your DinnerPlates object will be instantiated and called as such:
# obj = DinnerPlates(capacity)
# obj.push(val)
# param_2 = obj.pop()
# param_3 = obj.popAtStack(index)


dp = DinnerPlates(2)
# dp.push(1)
# dp.push(2)
# dp.push(3)
# dp.push(4)
# dp.push(5)
# print(dp.stack)
# dp.popAtStack(0)
# print(dp.stack)
# dp.push(20)
# dp.push(21)
# print(dp.stack)
# dp.popAtStack(0)
# print(dp.stack)
# dp.popAtStack(2)
# print(dp.stack)
# dp.pop()
# print(dp.stack)
# dp.pop()
# print(dp.stack)
# dp.pop()
# print(dp.stack)
# dp.pop()
# print(dp.stack)
dp.push(1)
dp.push(2)
dp.push(3)
dp.push(4)
dp.push(7)
print(dp.bit.buff)
dp.popAtStack(8)
dp.push(20)
dp.push(21)
print(dp.bit.buff)
dp.popAtStack(0)
dp.popAtStack(2)
print(dp.stack)
dp.pop()
print(dp.stack)
dp.pop()
dp.pop()
dp.pop()
dp.pop()

```

