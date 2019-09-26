# LeetCode: 659. 分割数组为连续子序列

[TOC]

## 1、题目描述

输入一个按升序排序的整数数组（可能包含重复数字），你需要将它们分割成几个子序列，其中每个子序列至少包含三个连续整数。返回你是否能做出这样的分割？

 

**示例 1：**

```
输入: [1,2,3,3,4,5]
输出: True
解释:
你可以分割出这样两个连续子序列 : 
1, 2, 3
3, 4, 5
```

**示例 2：**

```
输入: [1,2,3,3,4,4,5,5]
输出: True
解释:
你可以分割出这样两个连续子序列 : 
1, 2, 3, 4, 5
3, 4, 5
```

**示例 3：**

```
输入: [1,2,3,4,4,5]
输出: False
```

**提示：**

- 输入的数组长度范围为 `[1, 10000]`



## 2、解题思路

- 判断标准：如果连续序列的过程中，每个元素都能够用上，并且子序列长度至少为3，就表示满足要求，如果有不能用到的子元素，就表示不满足要求

- 判断当前元素是否能够被用到：
  - 如果以前面元素为结尾的子序列存在，就将子序列结尾移到当前位置上面
  - 如果不存在，就判断能够以当前元素作为子序列的开始，也就是判断后面两个连续的值是否存在



```python
from collections import Counter, defaultdict


class Solution:
    def isPossible(self, nums: List[int]) -> bool:
        if len(nums) < 3:
            return False

        num_count = Counter(nums)
        end_count = defaultdict(int)

        for num in nums:
            if num_count[num] == 0:
                continue

            num_count[num] -= 1
            if end_count[num - 1] > 0:
                end_count[num - 1] -= 1
                end_count[num] += 1
            elif num_count[num + 1] > 0 and num_count[num + 2] > 0:
                num_count[num + 1] -= 1
                num_count[num + 2] -= 1
                end_count[num + 2] += 1
            else:
                return False
        return True
```

