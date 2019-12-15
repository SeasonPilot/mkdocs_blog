# LeetCode: 1286. 字母组合迭代器

[TOC]

## 1、题目描述

请你设计一个迭代器类，包括以下内容：

-   一个构造函数，输入参数包括：一个 有序且字符唯一 的字符串 `characters`（该字符串只包含小写英文字母）和一个数字 `combinationLength` 。
-   函数 `next()` ，按 字典序 返回长度为 `combinationLength` 的下一个字母组合。
-   函数 `hasNext()` ，只有存在长度为 `combinationLength` 的下一个字母组合时，才返回 `True`；否则，返回 `False`。

**示例：**

```
CombinationIterator iterator = new CombinationIterator("abc", 2); // 创建迭代器 iterator

iterator.next(); // 返回 "ab"
iterator.hasNext(); // 返回 true
iterator.next(); // 返回 "ac"
iterator.hasNext(); // 返回 true
iterator.next(); // 返回 "bc"
iterator.hasNext(); // 返回 false
```

**提示：**

-   $1 <= combinationLength <= characters.length <= 15$
-   每组测试数据最多包含 `10^4` 次函数调用。
-   题目保证每次调用函数 `next` 时都存在下一个字母组合。



## 2、解题思路

-   维护一个数组下标，表示当前需要返回的字母组合
-   为了得到最小字典序，每一次都是前面的索引不动，最后的索引加一

```
例如  "abc"  2

索引变化如下
[0,1]
[0,2]
[1,2]
```

```
例如 "abcd" 3

索引变化如下
[0,1,2]
[0,1,3]
[1,2,3]
```



```python
class CombinationIterator:

    def __init__(self, characters: str, combinationLength: int):
        self.characters = characters
        self.length = len(characters)
        self.combinationLength = combinationLength
        self.current = list(range(combinationLength))
        self.next_item = True

    def next(self) -> str:
        current = "".join(map(lambda index: self.characters[index], self.current))
        if self.current[-1] < self.length - 1:
            self.current[-1] += 1
        else:
            self.next_item = False
            temp = -1
            target = self.length - 1
            for i in range(self.combinationLength - 1, -1, -1):
                if self.current[i] < target:
                    temp = i
                    self.next_item = True
                    break
                target -= 1
            if temp >= 0:
                self.current[temp] += 1
                for i in range(temp + 1, self.combinationLength):
                    self.current[i] = self.current[i - 1] + 1
        return current

    def hasNext(self) -> bool:
        return self.next_item


# Your CombinationIterator object will be instantiated and called as such:
# obj = CombinationIterator(characters, combinationLength)
# param_1 = obj.next()
# param_2 = obj.hasNext()
```

