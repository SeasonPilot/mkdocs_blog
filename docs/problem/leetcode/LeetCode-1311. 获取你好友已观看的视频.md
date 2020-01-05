# LeetCode: 1311. 获取你好友已观看的视频

[TOC]

## 1、题目描述

有 `n` 个人，每个人都有一个 `0` 到 `n-1` 的唯一 *id* 。给你数组 `watchedVideos` 和 `friends` ，其中 `watchedVideos[i]` 和 `friends[i]` 分别表示 `id = i` 的人观看过的视频列表和他的好友列表。

Level **1** 的视频包含所有你好友观看过的视频，level **2** 的视频包含所有你好友的好友观看过的视频，以此类推。一般的，Level 为 **k** 的视频包含所有从你出发，最短距离为 **k** 的好友观看过的视频。

给定你的 `id` 和 `level` ，请你返回所有指定 level 的视频，并将它们按观看频率升序返回。如果有频率相同的视频，请将它们按名字字典序从小到大排列。

 

**示例 1：**

**![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2020-01-05-085730.png)**

```
输入：watchedVideos = [["A","B"],["C"],["B","C"],["D"]], friends = [[1,2],[0,3],[0,3],[1,2]], id = 0, level = 1
输出：["B","C"] 
解释：
你的 id 为 0 ，你的朋友包括：
id 为 1 -> watchedVideos = ["C"] 
id 为 2 -> watchedVideos = ["B","C"] 
你朋友观看过视频的频率为：
B -> 1 
C -> 2
```

**示例 2：**

**![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2020-01-05-085737.png)**

```
输入：watchedVideos = [["A","B"],["C"],["B","C"],["D"]], friends = [[1,2],[0,3],[0,3],[1,2]], id = 0, level = 2
输出：["D"]
解释：
你的 id 为 0 ，你朋友的朋友只有一个人，他的 id 为 3 。
```

 

**提示：**

-   `n == watchedVideos.length == friends.length`
-   `2 <= n <= 100`
-   `1 <= watchedVideos[i].length <= 100`
-   `1 <= watchedVideos[i][j].length <= 8`
-   `0 <= friends[i].length < n`
-   `0 <= friends[i][j] < n`
-   `0 <= id < n`
-   `1 <= level < n`
-   如果 `friends[i]` 包含 `j` ，那么 `friends[j]` 包含 `i`

## 2、解题思路

-   广度优先搜索



```python
from collections import defaultdict


class Solution:
    def watchedVideosByFriends(self, watchedVideos: List[List[str]], friends: List[List[int]], id: int, level: int) -> List[str]:
        if level == 0:
            return sorted(watchedVideos[id])

        length = len(watchedVideos)
        visited = [0] * length

        d = [id]
        visited[id] = 1
        videos = defaultdict(int)
        while level > 0:
            next_level = []
            for friend in d:
                for next_friend in friends[friend]:

                    if not visited[next_friend]:
                        next_level.append(next_friend)
                        if level == 1:
                            for video in watchedVideos[next_friend]:
                                videos[video] += 1
                    visited[next_friend] = 1
            level -= 1
            d = next_level
        ans = []
        for v in sorted(videos.items(), key=lambda x: [x[1], x[0]]):
            ans.append(v[0])
        return ans
```

