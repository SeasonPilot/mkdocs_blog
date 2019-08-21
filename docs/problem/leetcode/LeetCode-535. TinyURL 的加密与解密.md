# LeetCode: 535. TinyURL 的加密与解密

[TOC]

## 1、题目描述

`TinyURL`是一种`URL`简化服务， 比如：当你输入一个URL `https://leetcode.com/problems/design-tinyurl` 时，它将返回一个简化的URL `http://tinyurl.com/4e9iAk`.

要求：设计一个 `TinyURL` 的加密 `encode` 和解密 `decode` 的方法。你的加密和解密算法如何设计和运作是没有限制的，你只需要保证一个`URL`可以被加密成一个`TinyURL`，并且这个`TinyURL`可以用解密方法恢复成原本的`URL`。

## 2、解题思路

- 设置一个字典计数器

```python
class Codec:

    def __init__(self):
        self.count = 0
        self.mapping = {}

    def encode(self, longUrl):
        """Encodes a URL to a shortened URL.

        :type longUrl: str
        :rtype: str
        """
        self.count += 1
        self.mapping[self.count] = longUrl
        return str(self.count)

    def decode(self, shortUrl):
        """Decodes a shortened URL to its original URL.

        :type shortUrl: str
        :rtype: str
        """
        return self.mapping[int(shortUrl)]
        

# Your Codec object will be instantiated and called as such:
# codec = Codec()
# codec.decode(codec.encode(url))
```



