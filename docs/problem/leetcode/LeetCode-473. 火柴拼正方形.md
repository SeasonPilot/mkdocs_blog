# LeetCode: 473. 火柴拼正方形

[TOC]

## 1、题目描述

还记得童话《卖火柴的小女孩》吗？现在，你知道小女孩有多少根火柴，请找出一种能使用所有火柴拼成一个正方形的方法。不能折断火柴，可以把火柴连接起来，并且每根火柴都要用到。

输入为小女孩拥有火柴的数目，每根火柴用其长度表示。输出即为是否能用所有的火柴拼成正方形。

```
示例 1:

输入: [1,1,2,2,2]
输出: true

解释: 能拼成一个边长为2的正方形，每边两根火柴。


示例 2:

输入: [3,3,3,3,4]
输出: false

解释: 不能用所有火柴拼成一个正方形。
```



**注意:**

- 给定的火柴长度和在 0 到 10^9之间。
- 火柴数组的长度不超过15。



## 2、解题思路

- 先判断基本体条件
  - 小于4个数
  - 不能被4整除
  - 最大值大于边长

上面几种情况直接返回False

- 采用回溯法
- 设计一个长度为4的数组，初始值为0
- 每一次进行遍历判断，将所有的值分别加到4个位置上，如果恰好得到边长，更新结果
- 无法得到，回溯，将当前值返回到之前的状态，重新计算

```python
class Solution:
    def makesquare(self, nums: List[int]) -> bool:
        
        total = sum(nums)
        edge = total // 4
        if len(nums) < 4 or total % 4 or max(nums) > edge:
            return False
        if max(nums) < edge and (max(nums) + min(nums) > edge):
            return False

        res = False
        res_nums = [0] * 4

        def dfs(cur_nums: list, pos, temp_nums, target_edge):
            nonlocal res
            if res:
                return
            if pos == len(cur_nums):
                if all(c == target_edge for c in temp_nums):
                    res = True
                return
            for i in range(0, 4):
                if temp_nums[i] == target_edge:
                    continue
                cur_val = temp_nums[i]
                temp_nums[i] += cur_nums[pos]
                if temp_nums[i] <= target_edge:
                    dfs(cur_nums, pos + 1, temp_nums, target_edge)
                    if res:
                        return
                temp_nums[i] = cur_val

        dfs(sorted(nums, reverse=True), 0, res_nums, edge)
        return res
```

这个很容易超时，加上了限制条件才不超时，换一种思路

- 我们需要从所有的数据中进行构造4条边，那么我们进行标记，通过dfs找出能够得到边长的，将这些节点标记位已使用

```python
class Solution:
    def makesquare(self, nums: List[int]) -> bool:
        total = sum(nums)
        edge = total // 4
        if len(nums) < 4 or total % 4 or max(nums) > edge:
            return False
        if max(nums) < edge and (max(nums) + min(nums) > edge):
            return False

        used = [False] * len(nums)
        nums.sort(reverse=True)

        def dfs(pos, target):
            used[pos] = True
            target += nums[pos]
            if target == edge:
                return True
            for p in range(pos + 1, len(nums)):
                if not used[p] and (target + nums[p]) <= edge:
                    if dfs(p, target):
                        return True
                    used[p] = False
            return False

        for i in range(4):
            temp = 0
            while used[temp]:
                temp += 1
            if not dfs(temp, 0):
                return False
        return True
```



