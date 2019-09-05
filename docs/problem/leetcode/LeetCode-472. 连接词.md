# LeetCode: 472. 连接词

[TOC]

## 1、题目描述

给定一个不含重复单词的列表，编写一个程序，返回给定单词列表中所有的连接词。

连接词的定义为：一个字符串完全是由至少两个给定数组中的单词组成的。

**示例:**

```
输入: ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]

输出: ["catsdogcats","dogcatsdog","ratcatdogcat"]

解释: "catsdogcats"由"cats", "dog" 和 "cats"组成; 
     "dogcatsdog"由"dog", "cats"和"dog"组成; 
     "ratcatdogcat"由"rat", "cat", "dog"和"cat"组成。
```


**说明:**

- `给定数组的元素总数不超过 10000。`
- `给定数组中元素的长度总和不超过 600000。`
- `所有输入字符串只包含小写字母。`
- `不需要考虑答案输出的顺序。`



## 2、解题思路

- 深度优先搜索

```python
class Solution:
    def findAllConcatenatedWordsInADict(self, words: List[str]) -> List[str]:

        w_set = set(words)
        
        def dfs(word):
            for i in range(1, len(word)):
                if word[:i] not in w_set:
                    continue
                if word[i:] in w_set or dfs(word[i:]):
                    return True
            return False
        
        return list(filter(lambda x:dfs(x),words))
```

- 分割点判断

```python
class Solution:
    def findAllConcatenatedWordsInADict(self, words: [str]) -> [str]:
        map_set = set(words)
        res = []

        for word in words:
            segmentation = [len(word)]
            # 从后向前获取所有可能的分割点，到第1个字符结束
            for index in range(len(word) - 1, 0, -1):
                if any(word[index:segment] in map_set for segment in segmentation):
                    segmentation.append(index)

            # 从前向后找，如果分割点之前的单词存在，表示这个单词满足条件
            if any(word[:segment] in map_set for segment in segmentation[1:]):
                res.append(word)

        return res
```

