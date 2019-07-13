# LeetCode: 604. 迭代压缩字符串

[TOC]

## 1、题目描述

对于一个压缩字符串，设计一个数据结构，它支持如下两种操作： next 和 hasNext。

给定的压缩字符串格式为：每个字母后面紧跟一个正整数，这个整数表示该字母在解压后的字符串里连续出现的次数。

next() - 如果压缩字符串仍然有字母未被解压，则返回下一个字母，否则返回一个空格。
hasNext() - 判断是否还有字母仍然没被解压。

注意：

请记得将你的类在 StringIterator 中 初始化 ，因为静态变量或类变量在多组测试数据中不会被自动清空。更多细节请访问 这里 。

示例：

```
StringIterator iterator = new StringIterator("L1e2t1C1o1d1e1");

iterator.next(); // 返回 'L'
iterator.next(); // 返回 'e'
iterator.next(); // 返回 'e'
iterator.next(); // 返回 't'
iterator.next(); // 返回 'C'
iterator.next(); // 返回 'o'
iterator.next(); // 返回 'd'
iterator.hasNext(); // 返回 true
iterator.next(); // 返回 'e'
iterator.hasNext(); // 返回 false
iterator.next(); // 返回 ' '
```



## 2、解题思路

设置两个列表，分别保存对应的字符与数量

使用两个变量，记录当前所处的位置



```python
class StringIterator:
    def __init__(self, compressedString: str):

        self.alpha = []
        self.nums = []
        self.pos = 0
        self.pos_nums = 0

        temp_num = ''
        for i in compressedString:
            if i.isalpha():
                self.alpha.append(i)
                if temp_num:
                    self.nums.append(int(temp_num))
                    temp_num = ''
            else:
                temp_num += i
        if temp_num:
            self.nums.append(int(temp_num))

    def next(self) -> str:
        res = ''
        if self.pos < len(self.alpha) and self.pos_nums < self.nums[self.pos]:
            res = self.alpha[self.pos]
            self.pos_nums += 1
            if self.pos_nums >= self.nums[self.pos]:
                self.pos += 1
                self.pos_nums = 0
            return res
        else:
            return ' '

    def hasNext(self) -> bool:
        if self.pos < len(self.alpha) and self.pos_nums < self.nums[self.pos]:
            return True
        return False
    
# Your StringIterator object will be instantiated and called as such:
# obj = StringIterator(compressedString)
# param_1 = obj.next()
# param_2 = obj.hasNext()

```

