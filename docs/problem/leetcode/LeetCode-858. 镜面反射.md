# LeetCode: 858. 镜面反射

[TOC]

## 1、题目描述

有一个特殊的正方形房间，每面墙上都有一面镜子。除西南角以外，每个角落都放有一个接受器，编号为 0， 1，以及 2。

正方形房间的墙壁长度为 p，一束激光从西南角射出，首先会与东墙相遇，入射点到接收器 0 的距离为 q 。

返回光线最先遇到的接收器的编号（保证光线最终会遇到一个接收器）。

 

**示例：**

```
输入： p = 2, q = 1
输出： 2
解释： 这条光线在第一次被反射回左边的墙时就遇到了接收器 2 。
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-29-151551.png)

**提示：**

-   `1 <= p <= 1000`
-   `0 <= q <= p`



## 2、解题思路

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-29-152455.png" alt="image-20190929232445177" style="zoom:33%;" />



如上图所示，依据反射原理，只要得到p和q的公倍数，然后判断在左面还是在右面即可

```
lcm = p * q / gcd(p,q)
判断公倍数包含了几个q，几个p，分别是奇数还是偶数
p_judge = lcm / q
        = (p * q / gcd(p,q) )/ q
        = p / gcd(p,q)
q_judge = lcm / p
        = (p * q / gcd(p,q) )/ p
        = q / gcd(p,q)
```



```python
class Solution:
    def mirrorReflection(self, p: int, q: int) -> int:
        import math

        gcd_num = math.gcd(p, q)
        p_judge = (p // gcd_num) % 2
        q_judge = (q // gcd_num) % 2

        if p_judge and q_judge:
            return 1
        elif not p_judge and q_judge:
            return 2
        else:
            return 0
```

