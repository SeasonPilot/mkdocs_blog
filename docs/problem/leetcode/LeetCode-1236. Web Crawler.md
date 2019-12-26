# LeetCode: 1236. Web Crawler

[TOC]

## 1、题目描述

Given a url startUrl and an interface HtmlParser, implement a web crawler to crawl all links that are under the same hostname as startUrl. 

Return all urls obtained by your web crawler in any order.

Your crawler should:

- Start from the page: `startUrl`
- Call `HtmlParser.getUrls(url)` to get all urls from a webpage of given url.
- Do not crawl the same link twice.
- Explore only the links that are under the **same hostname** as `startUrl`.

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-26-015554.png)




As shown in the example url above, the hostname is example.org. For simplicity sake, you may assume all urls use http protocol without any port specified. For example, the urls `http://leetcode.com/problems` and `http://leetcode.com/contest` are under the same hostname, while urls `http://example.org/test` and `http://example.com/abc` are not under the same hostname.

The HtmlParser interface is defined as such: 

```java
interface HtmlParser {
  // Return a list of all urls from a webpage of given url.
  public List<String> getUrls(String url);
}

```
Below are two examples explaining the functionality of the problem, for custom testing purposes you'll have three variables urls, edges and startUrl. Notice that you will only have access to startUrl in your code, while urls and edges are not directly accessible to you in code.

 

**Example 1:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-26-015626.png)



```

Input:
urls = [
  "http://news.yahoo.com",
  "http://news.yahoo.com/news",
  "http://news.yahoo.com/news/topics/",
  "http://news.google.com",
  "http://news.yahoo.com/us"
]
edges = [[2,0],[2,1],[3,2],[3,1],[0,4]]
startUrl = "http://news.yahoo.com/news/topics/"
Output: [
  "http://news.yahoo.com",
  "http://news.yahoo.com/news",
  "http://news.yahoo.com/news/topics/",
  "http://news.yahoo.com/us"
]

```

**Example 2:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-26-015650.png)

```

Input: 
urls = [
  "http://news.yahoo.com",
  "http://news.yahoo.com/news",
  "http://news.yahoo.com/news/topics/",
  "http://news.google.com"
]
edges = [[0,2],[2,1],[3,2],[3,1],[3,0]]
startUrl = "http://news.google.com"
Output: ["http://news.google.com"]
Explanation: The startUrl links to all other pages that do not share the same hostname.
```
**Constraints:**

-   $1 <= urls.length <= 1000$
-   $1 <= urls[i].length <= 300$
-   `startUrl` is one of the urls.
-   Hostname label must be from `1` to `63` characters long, including the dots, may contain only the ASCII 
-   letters from `'a'` to `'z'`, digits  from `'0'` to `'9'` and the hyphen-minus character `('-')`.
-   The hostname may not start or end with the hyphen-minus character `('-')`. 
-   See:  https://en.wikipedia.org/wiki/Hostname#Restrictions_on_valid_hostnames
-   You may assume there're no duplicates in url library.



## 2、解题思路

-   使用集合记录出现过的`URL`

-   将新的待检查的`URL`单独存放，直到待检查`URL`集合为空为止

    

```python
# """
# This is HtmlParser's API interface.
# You should not implement it, or speculate about its implementation
# """
#class HtmlParser(object):
#    def getUrls(self, url):
#        """
#        :type url: str
#        :rtype List[str]
#        """

class Solution:
    def crawl(self, startUrl: str, htmlParser: 'HtmlParser') -> List[str]:
        host_name = "/".join(startUrl.split("/")[:3])

        ans_set = {startUrl, }
        check_set = {startUrl, }
        while check_set:
            next_check = set()
            for url in check_set:
                for next_url in htmlParser.getUrls(url):
                    if next_url.startswith(host_name) and next_url not in ans_set:
                        next_check.add(next_url)
                        ans_set.add(next_url)
            check_set = next_check
        return list(ans_set)
```

