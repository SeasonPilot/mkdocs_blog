# LeetCode: 293. 翻转游戏

[TOC]

## 1、题目描述



你和朋友玩一个叫做「翻转游戏」的游戏，游戏规则：给定一个只有 + 和 - 的字符串。你和朋友轮流将 连续 的两个 "++" 反转成 "--"。 当一方无法进行有效的翻转时便意味着游戏结束，则另一方获胜。

请你写出一个函数，来计算出每个有效操作后，字符串所有的可能状态。

示例：

输入: s = "++++"
输出: 
[
  "--++",
  "+--+",
  "++--"
]
注意：如果不存在可能的有效操作，请返回一个空列表 []。



## 2、解题思路

如果是遇到++，则替换以后放入结果数组中

- 

```python
class Solution:
    def generatePossibleNextMoves(self, s: str) -> List[str]:
        
        replace = "--"
        target = "++"

        result = []

        pos = 0

        try:
            for i in range(len(s)):
                tar_pos = s.index(target, pos)
                result.append(s[:tar_pos] + replace + s[tar_pos + len(target):])
                pos = tar_pos + 1
        except ValueError:
            pass
        return result
        
```

