# LeetCode: 823. 带因子的二叉树

[TOC]

## 1、题目描述

给出一个含有不重复整数元素的数组，每个整数均大于 `1`。

我们用这些整数来构建二叉树，每个整数可以使用任意次数。

其中：每个非叶结点的值应等于它的两个子结点的值的乘积。

满足条件的二叉树一共有多少个？返回的结果应模除 $10^{9} + 7$。

 

**示例 1:**

```
输入: A = [2, 4]
输出: 3
解释: 我们可以得到这些二叉树: [2], [4], [4, 2, 2]
```


**示例 2:**

```
输入: A = [2, 4, 5, 10]
输出: 7
解释: 我们可以得到这些二叉树: [2], [4], [5], [10], [4, 2, 2], [10, 2, 5], [10, 5, 2].
```

**提示:**

-   $1 <= A.length <= 1000.$
-   $2 <= A[i] <= 10 ^ 9.$



## 2、解题思路

-   动态规划
-   首先排序

-   初始化：

```
dp[index] ： 表示以第index个元素开头的能够得到子树的数量
```

-   状态转换方程

```
dp[index] += dp[before] * dp[index_mapping[right_node]]
```

表示左右节点子树方案数之积



```python
class Solution:
    def numFactoredBinaryTrees(self, A: List[int]) -> int:
        mod_num = 1000000007
        A.sort()
        length = len(A)
        dp = [1] * length
        index_mapping = {val: index for index, val in enumerate(A)}

        for index, num in enumerate(A):
            for before in range(index):
                if num % A[before] == 0:
                    right_node = num // A[before]
                    if right_node in index_mapping:
                        dp[index] += dp[before] * dp[index_mapping[right_node]]
                        dp[index] %= mod_num
        return sum(dp) % mod_num
```

