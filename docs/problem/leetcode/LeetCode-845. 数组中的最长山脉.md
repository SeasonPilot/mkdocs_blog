# LeetCode: 845. 数组中的最长山脉

[TOC]

## 1、题目描述

我们把数组 `A` 中符合下列属性的任意连续子数组 `B` 称为 “山脉”：

`B.length >= 3`
存在 `0 < i < B.length - 1 使得 B[0] < B[1] < ... B[i-1] < B[i] > B[i+1] > ... > B[B.length - 1]`
（注意：`B` 可以是 `A` 的任意子数组，包括整个数组 `A`。）

给出一个整数数组 `A`，返回最长 “山脉” 的长度。

如果不含有 “山脉” 则返回 `0`。

 

**示例 1：**

```
输入：[2,1,4,7,3,2,5]
输出：5
解释：最长的 “山脉” 是 [1,4,7,3,2]，长度为 5。
```


**示例 2：**

```
输入：[2,2,2]
输出：0
解释：不含 “山脉”。
```

**提示：**

-   $0 <= A.length <= 10000$
-   $0 <= A[i] <= 10000$



## 2、解题思路

-   指针扫描法
-   设置三个指针，`left`,`mid`,`right`,分别代表左侧，峰顶，右侧，不断向右更新寻找即可



```python
class Solution:
    def longestMountain(self, A: List[int]) -> int:
        length = len(A)
        if length < 3:
            return 0
        ans = 0

        left, mid, right = 0, 0, 0
        while left < length:
            left = right
            while left < length - 1 and A[left] >= A[left + 1]:
                left += 1

            mid = left + 1

            while mid < length - 1 and A[mid] < A[mid + 1]:
                mid += 1

            right = mid

            while right < length - 1 and A[right + 1] < A[right]:
                right += 1

            if right > mid:
                ans = max(ans, right - left + 1)

        return ans if ans >= 3 else 0
```

