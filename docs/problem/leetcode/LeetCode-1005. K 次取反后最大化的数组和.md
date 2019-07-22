# LeetCode: 1005. K 次取反后最大化的数组和

[TOC]

## 1、题目描述

给定一个整数数组 A，我们只能用以下方法修改该数组：我们选择某个个索引 i 并将 A[i] 替换为 -A[i]，然后总共重复这个过程 K 次。（我们可以多次选择同一个索引 i。）

以这种方式修改数组后，返回数组可能的最大和。

 ```
示例 1：
输入：A = [4,2,3], K = 1
输出：5
解释：选择索引 (1,) ，然后 A 变为 [4,-2,3]。

示例 2：
输入：A = [3,-1,0,2], K = 3
输出：6
解释：选择索引 (1, 2, 2) ，然后 A 变为 [3,1,0,2]。

示例 3：
输入：A = [2,-3,-1,5,-4], K = 2
输出：13
解释：选择索引 (1, 4) ，然后 A 变为 [2,3,-1,5,4]。
 ```

**提示：**

-  $1 <= A.length <= 10000$ 

-  $1 <= K <= 10000$ 

-  $ -100 <= A[i] <= 100$ 

## 2、解题思路

- 如果K小于等于负数的长度，将最小的负数取反即可
- 如果K大于负数的长度，则将所有负数取整，找出绝对值最小的数，`K%2 `判断取正还是取反

```python
class Solution:
    def largestSumAfterKNegations(self, A: [int], K: int) -> int:
        
        positive = sorted([x for x in A if x >= 0])
        negative = sorted([x for x in A if x < 0])
        neg_sum = -sum(negative[:K]) + sum(negative[K:])
        K -= len(negative)

        if K > 0:
            if negative:
                if positive:
                    if abs(negative[-1]) <= positive[0]:
                        neg_sum += negative[-1]
                        neg_sum += abs(negative[-1]) * (-1) ** (K % 2)
                    else:
                        positive[0] *= (-1) ** (K % 2)
                else:
                    neg_sum -= abs(negative[-1])
                    neg_sum += abs(negative[-1]) * (-1) ** (K % 2)

            else:
                positive[0] *= (-1) ** (K % 2)

        return neg_sum + sum(positive)
        
```

