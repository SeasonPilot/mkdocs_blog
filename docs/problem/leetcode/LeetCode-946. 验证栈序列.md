# LeetCode: 946. 验证栈序列

[TOC]

## 1、题目描述

给定 `pushed` 和 `popped` 两个序列，只有当它们可能是在最初空栈上进行的推入 `push` 和弹出 `pop` 操作序列的结果时，返回 `true`；否则，返回 `false` 。

 

**示例 1：**

```
输入：pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
输出：true
解释：我们可以按以下顺序执行：
push(1), push(2), push(3), push(4), pop() -> 4,
push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
```


**示例 2：**

```
输入：pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
输出：false
解释：1 不能在 2 之前弹出。
```

**提示：**

- `0 <= pushed.length == popped.length <= 1000`
- `0 <= pushed[i], popped[i] < 1000`
- `pushed 是 popped 的排列。`



## 2、解题思路

- 设置一个栈
- 如果栈为空，或者栈中最后一个数字不等于弹出顺序的数字，就进行入栈操作
- 如果栈中最后一个数字等于出栈顺序对应的数字，就进行出栈操作
- 如果已经将所有数据入栈，出栈并没有进行完毕，表示不能得到这个出栈序列



```python
class Solution:
    def validateStackSequences(self, pushed: List[int], popped: List[int]) -> bool:
        push_pos = 0
        pop_pos = 0
        push_l, pop_l = len(pushed), len(popped)

        stack = []
        while push_pos < push_l and pop_pos < pop_l or stack and stack[-1] == popped[pop_pos]:

            while pop_pos < pop_l and stack and stack[-1] == popped[pop_pos]:
                stack.pop()
                pop_pos += 1

            while push_pos < push_l and (not stack or stack[-1] != popped[pop_pos]):
                stack.append(pushed[push_pos])
                push_pos += 1

        if push_pos >= push_l and pop_pos >= pop_l:
            return True
        else:
            return False
```

