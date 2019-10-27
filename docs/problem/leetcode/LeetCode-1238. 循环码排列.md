# LeetCode: 1238. 循环码排列

[TOC]

## 1、题目描述

给你两个整数 `n` 和 `start`。你的任务是返回任意 `(0,1,2,,...,2^n-1)` 的排列 `p`，并且满足：

-   `p[0] = start`
-   `p[i]` 和 `p[i+1]` 的二进制表示形式只有一位不同
-   `p[0]` 和 `p[2^n -1]` 的二进制表示形式也只有一位不同

 

**示例 1：**

```
输入：n = 2, start = 3
输出：[3,2,0,1]
解释：这个排列的二进制表示是 (11,10,00,01)
     所有的相邻元素都有一位是不同的，另一个有效的排列是 [3,1,0,2]
```

**示例 2：**

```
输出：n = 3, start = 2
输出：[2,6,7,5,4,0,1,3]
解释：这个排列的二进制表示是 (010,110,111,101,100,000,001,011)
```

 

**提示：**

-   `1 <= n <= 16`
-   `0 <= start < 2^n`

## 2、解题思路

-   首先生成格雷码，然后找找出起始值，将数组法分开合并返回即可

```
二进制转格雷码：
   从第二位开始，每一位异或左边的那位
   
格雷码转二进制:
	最高位保留，每一位都和前一位的二进制位进行异或
	
	1010101
	1保留
	0和1异或得到1
	1需要和前面得到的结果1进行异或，得到0
```



```python
class Solution:
    def circularPermutation(self, n: int, start: int) -> List[int]:
        def get_gray_code(num):
            s_num = bin(num)[2:]
            cur_ans = [s_num[0]]

            for pos in range(1, len(s_num)):
                if s_num[pos] != s_num[pos - 1]:
                    cur_ans.append("1")
                else:
                    cur_ans.append("0")
            return int("".join(cur_ans), 2)

        ans = [0] * (2 ** n)
        for i in range(2 ** n):
            ans[i] = get_gray_code(i)
        index = ans.index(start)
        return ans[index:] + ans[:index]
```

