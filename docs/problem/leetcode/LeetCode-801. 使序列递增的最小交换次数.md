# LeetCode: 801. 使序列递增的最小交换次数

[TOC]

## 1、题目描述

我们有两个长度相等且不为空的整型数组 `A` 和 `B` 。

我们可以交换 `A[i]` 和 `B[i]` 的元素。注意这两个元素在各自的序列中应该处于相同的位置。

在交换过一些元素之后，数组 A 和 B 都应该是严格递增的（数组严格递增的条件仅为`A[0] < A[1] < A[2] < ... < A[A.length - 1]`）。

给定数组 `A` 和 `B` ，请返回使得两个数组均保持严格递增状态的最小交换次数。假设给定的输入总是有效的。

**示例:**

```
输入: A = [1,3,5,4], B = [1,2,3,7]
输出: 1
解释: 
交换 A[3] 和 B[3] 后，两个数组如下:
A = [1, 3, 5, 7] ， B = [1, 2, 3, 4]
两个数组均为严格递增的。
```



**注意:**

-   `A, B 两个数组的长度总是相等的，且长度的范围为 [1, 1000]。`
-   `A[i], B[i] 均为 [0, 2000]区间内的整数。`



## 2、解题思路

-   保存每个位置的两种状态：
    -   交换当前数字的满足条件的最小步骤
    -   不交换当前数字的满足条件的最小步骤

-   初始化：

```
exchange = 1
no_exchange = 0
```

对于第一个元素，交换为1，不交换为0

然后从第二个元素开始判断

```python
# 如果本身满足递增
if A[i] > A[i - 1] and B[i] > B[i - 1]:
    if A[i] > B[i - 1] and B[i] > A[i - 1]:
        # 交换以后依然满足递增
        temp_exchange = exchange
        # 那么当前位置交换就依赖于前面交换和不交换的次数
        exchange = min(exchange + 1, no_exchange + 1)
        # 不交换同样依赖于前面的两个次数
        no_exchange = min(temp_exchange, no_exchange)
    else:
        # 如果前面已经交换了，那么这一次肯定需要交换才能满足递增条件
        exchange += 1
else:
    temp_no_exchange = no_exchange
    # 本身不满足递增，当前想要不交换，只能前面一次交换
    no_exchange = exchange
    # 当前想要交换，就需要前面一次不交换才行
    exchange = temp_no_exchange + 1
```

**实例代码：**

```python
class Solution:
    def minSwap(self, A: List[int], B: List[int]) -> int:
        length = len(A)
        exchange = 1
        no_exchange = 0

        for i in range(1, length):
            if A[i] > A[i - 1] and B[i] > B[i - 1]:
                if A[i] > B[i - 1] and B[i] > A[i - 1]:
                    temp_exchange = exchange
                    exchange = min(exchange + 1, no_exchange + 1)
                    no_exchange = min(temp_exchange, no_exchange)
                else:
                    exchange += 1
            else:
                temp_no_exchange = no_exchange
                no_exchange = exchange
                exchange = temp_no_exchange + 1

        return min(no_exchange, exchange)
```

