# LeetCode: 239. 滑动窗口最大值

[TOC]

## 1、题目描述

给定一个数组 `nums`，有一个大小为 `k` 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 `k` 个数字。滑动窗口每次只向右移动一位。

返回滑动窗口中的最大值。

 

**示例:**

```
输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
输出: [3,3,5,5,6,7] 
解释: 

  滑动窗口的位置                最大值

------

[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7

提示：

你可以假设 k 总是有效的，在输入数组不为空的情况下，1 ≤ k ≤ 输入数组的大小。
```

 

**进阶：**

- 你能在线性时间复杂度内解决此题吗？



## 2、解题思路

- 滑动窗口法

- 使用堆维持窗口最大值



```python
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        if not nums:
            return []
        import heapq
        N = len(nums)
        res = []

        pos = 1
        window = [-x for x in nums[:k]]
        heapq.heapify(window)
        res.append(-window[0])
        while pos < N - k + 1:
            window.remove(-nums[pos-1])
            heapq.heapify(window)
            heapq.heappush(window, -nums[pos + k - 1])
            res.append(-window[0])
            pos += 1

        return res
```

- 双向队列法

使用队列维持当前最大元素在首部



```python
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        from collections import deque
        if not nums:
            return []

        windows = deque(maxlen=k)

        def process_deque(deq: deque, pos: int):
            if deq and deq[0] + k == pos:
                deq.popleft()
            while deq and nums[deq[-1]] < nums[pos]:
                deq.pop()
            deq.append(pos)

        for i in range(k - 1):
            process_deque(windows, i)
        res = []
        for i in range(k - 1, len(nums)):
            process_deque(windows, i)
            res.append(nums[windows[0]])
        return res
    
```





```python
from collections import deque


class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        length = len(nums)
        if k<=1 or length<=1:
            return nums
        d = deque(maxlen=k)
        ans = []
        
        for i in range(k):
            while d and nums[i] >= nums[d[-1]]:
                d.pop()
            d.append(i)
        
        ans.append(nums[d[0]])
        
        
        for i in range(k,length):
            if d[0] == i-k:
                d.popleft()
            while d and nums[i] >= nums[d[-1]]:
                d.pop()
            d.append(i)
            ans.append(nums[d[0]])
        return ans
            
            
```

