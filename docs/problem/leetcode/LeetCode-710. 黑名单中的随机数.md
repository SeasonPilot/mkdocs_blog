# LeetCode: 710. 黑名单中的随机数

[TOC]

## 1、题目描述

给定一个包含 [0，n ) 中独特的整数的黑名单 B，写一个函数从 [ 0，n ) 中返回一个不在 B 中的随机整数。

对它进行优化使其尽量少调用系统方法 `Math.random()` 。

提示:

- 1 <= N <= 1000000000
- 0 <= B.length < min(100000, N)
- [0, N) 不包含 N，详细参见 interval notation 。

**示例 1:**

```
输入: 
["Solution","pick","pick","pick"]
[[1,[]],[],[],[]]
输出: [null,0,0,0]
```


**示例 2:**

```
输入: 
["Solution","pick","pick","pick"]
[[2,[]],[],[],[]]
输出: [null,1,1,1]
```


**示例 3:**

```
输入: 
["Solution","pick","pick","pick"]
[[3,[1]],[],[],[]]
Output: [null,0,0,2]
```

**示例 4:**

```
输入: 
["Solution","pick","pick","pick"]
[[4,[2]],[],[],[]]
输出: [null,1,3,1]
```

**输入语法说明：**

- 输入是两个列表：调用成员函数名和调用的参数。Solution的构造函数有两个参数，N 和黑名单 B。pick 没有参数，输入参数是一个列表，即使参数为空，也会输入一个 [] 空列表。

## 2、解题思路

一共是`N`个数字，黑名单中的数字有`len(blacklist)`个，那么白名单中的数字就有`N-len(blacklist)`个

如果我们从`[0,N-len(blacklist))`中随机取数字，其中有一些可能在黑名单中，但是同时肯定有一个数字大于等于`N-len(blacklist)`，并且不在黑名单中，找出这些数字，并建立映射关系



```python
class Solution:
    
    def __init__(self, N: int, blacklist: [int]):
        self.while_nums = N - len(blacklist)

        self.whi_in_blk = [i for i in blacklist if i < self.while_nums]
        self.whi_not_in_blk = set(range(self.while_nums, N)) - set(blacklist)
        self.mapping = {k: v for k, v in zip(self.whi_in_blk, self.whi_not_in_blk)}

    def pick(self) -> int:
        import random
        tar = random.randint(0, self.while_nums - 1)
        return tar if tar not in self.mapping else self.mapping[tar]    


# Your Solution object will be instantiated and called as such:
# obj = Solution(N, blacklist)
# param_1 = obj.pick()
```

