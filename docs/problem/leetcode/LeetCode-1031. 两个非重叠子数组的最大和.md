# LeetCode: 1031. 两个非重叠子数组的最大和

[TOC]

## 1、题目描述

给出非负整数数组 `A` ，返回两个非重叠（连续）子数组中元素的最大和，子数组的长度分别为 `L` 和 `M`。（这里需要澄清的是，长为 `L` 的子数组可以出现在长为 `M` 的子数组之前或之后。）

从形式上看，返回最大的 `V`，而 $V = (A[i] + A[i+1] + ... + A[i+L-1]) + (A[j] + A[j+1] + ... + A[j+M-1])$  并满足下列条件之一：



- $0 <= i < i + L - 1 < j < j + M - 1 < A.length$ , 或
- $0 <= j < j + M - 1 < i < i + L - 1 < A.length.$ 

**示例 1：**

```
输入：A = [0,6,5,2,2,5,1,9,4], L = 1, M = 2
输出：20
解释：子数组的一种选择中，[9] 长度为 1，[6,5] 长度为 2。
```

**示例 2：**

```
输入：A = [3,8,1,3,2,1,8,9,0], L = 3, M = 2
输出：29
解释：子数组的一种选择中，[3,8,1] 长度为 3，[8,9] 长度为 2。
```


**示例 3：**

```
输入：A = [2,1,5,6,0,9,5,0,3,8], L = 4, M = 3
输出：31
解释：子数组的一种选择中，[5,6,0,9] 长度为 4，[0,3,8] 长度为 3。
```

**提示：**

- `L >= 1`
- `M >= 1`
- `L + M <= A.length <= 1000`
- `0 <= A[i] <= 1000`



## 2、解题思路

- 因为想要取出两个连续的子数组，那么数组中可以看成有一条分界线，左面和右面分别取出一个子数组令和最大
- 首先计算几个辅助数组：
  - 从左面到当前位置取出L长度子数组最大和
  - 从左面到当前位置取出M长度子数组最大和
  - 从右面到当前位置取出L长度子数组最大和
  - 从右面到当前位置取出M长度子数组最大和
- 然后我们就从中间的分界线进行判断即可，每次取出左面和右面的最大和，更新结果即可



```python
class Solution:
    def maxSumTwoNoOverlap(self, A: List[int], L: int, M: int) -> int:
        length = len(A)
        ans = -1
        l_left = [-1] * length
        l_right = [-1] * length
        m_left = [-1] * length
        m_right = [-1] * length

        def get_max_sub(sub_len, source, target):
            pos = sub_len
            cur_sums = sum(source[:sub_len])
            max_sums = cur_sums
            target[sub_len - 1] = cur_sums
            while pos < len(source):
                cur_sums = cur_sums + source[pos] - source[pos - sub_len]
                max_sums = max(max_sums, cur_sums)
                target[pos] = max_sums
                pos += 1

        get_max_sub(L, A, l_left)
        get_max_sub(L, list(reversed(A)), l_right)
        get_max_sub(M, A, m_left)
        get_max_sub(M, list(reversed(A)), m_right)

        min_sub_len = min(L, M)

        for i in range(min_sub_len - 1, length - min_sub_len):
            if l_left[i] != -1 and m_right[length - i - 2] != -1:
                ans = max(ans, l_left[i] + m_right[length - i - 2])
            if m_left[i] != -1 and l_right[length - i - 2] != -1:
                ans = max(ans, m_left[i] + l_right[length - i - 2])
        return ans
```

