# LeetCode: 246. 中心对称数

[TOC]

## 1、题目描述



中心对称数是指一个数字在旋转了 180 度之后看起来依旧相同的数字（或者上下颠倒地看）。

请写一个函数来判断该数字是否是中心对称数，其输入将会以一个字符串的形式来表达数字。

示例 1:

输入:  "69"
输出: true
示例 2:

输入:  "88"
输出: true
示例 3:

输入:  "962"
输出: false



## 2、解题思路

能够反转变成另一个数字的有：

- 0 -> 0
- 1 -> 1
- 6 -> 9
- 8 -> 8
- 9 -> 6



因此，从上面可以看到，如果将字符串从中间进行拆分，奇数的话，中间的字符一定在0，1，8之间

偶数的话，左右边0，1，8相同，6和9相互对应

因此判断思路如下：

- 判断字符串是否是奇数，如果是，判断中间字符是否是0，1，8中间的一个，不是则返回FALSE
- 从左面开始进行判断，遇到0，1，8，右面必定是0，1，8
- 遇到6，9，右面为9，6



```python
class Solution:
    def isStrobogrammatic(self, num: str) -> bool:
        same = set(['0', '1', '8'])
        non_same = set(['2', '3', '4', '5', '7'])
        length = len(num)
        if length % 2 == 1 and num[length // 2] not in same:
            return False

        half_length = length // 2

        for i in range(half_length):
            if num[i] in non_same:
                return False
            if num[i] in same and num[i] != num[-(i + 1)]:
                return False
            if num[i] == '6' and num[-(i + 1)] != '9':
                return False
            if num[i] == '9' and num[-(i + 1)] != '6':
                return False
        return True
```



