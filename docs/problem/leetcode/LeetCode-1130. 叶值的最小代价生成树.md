# LeetCode: 1130. 叶值的最小代价生成树

[TOC]

## 1、题目描述

给你一个正整数数组 `arr`，考虑所有满足以下条件的二叉树：

每个节点都有 `0` 个或是 `2` 个子节点。
数组 `arr` 中的值与树的中序遍历中每个叶节点的值一一对应。（知识回顾：如果一个节点有 `0` 个子节点，那么该节点为叶节点。）
每个非叶节点的值等于其左子树和右子树中叶节点的最大值的乘积。
在所有这样的二叉树中，返回每个非叶节点的值的最小可能总和。这个和的值是一个 `32` 位整数。

 

**示例：**

```
输入：arr = [6,2,4]
输出：32
解释：
有两种可能的树，第一种的非叶节点的总和为 36，第二种非叶节点的总和为 32。


    24            24
   /  \          /  \
  12   4        6    8
 /  \               / \
6    2             2   4
```
**提示：**

- `2 <= arr.length <= 40`
- `1 <= arr[i] <= 15`
- `答案保证是一个 32 位带符号整数，即小于 2^31。`



## 2、解题思路

- 分治法

如果有3个元素

```
[6,2,4]
首先确认最上层元素，也就是下面的分成两部分，最少是一个，有多种方案
也就是分成
[6] [24]
或者
[6,2] [4]
然后子元素继续找，如果只有一个元素，返回0，表示叶节点
如果有两个元素，直接返回两数之积
元素多余两个，重复上面的步骤进行分割
```



```python
class Solution:
    def mctFromLeafValues(self, arr: List[int]) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dfs(left, right):
            if left == right:
                return 0
            if left + 1 == right:
                return arr[left] * arr[right]

            res = float('inf')
            for mid in range(left, right):
                temp = max(arr[left:mid + 1]) * max(arr[mid + 1:right + 1]) + dfs(left, mid) + dfs(mid + 1, right)
                res = min(res, temp)
            return res

        return dfs(0, len(arr) - 1)
```

