# Array Manipulation

[TOC]

## 1、题目描述

Devendra在9号云上看到了他的教练朝他微笑。 每次教授选出Devendra单独问他一个问题，Devendra朦胧的头脑里全是他的教练和她的微笑，以至于他无法专注于其他事情。帮助他解决这个问题：

给你一个长度为N的列表，列表的初始值全是0。对此列表，你要进行M次查询，输出列表种最终N个值的最大值。对每次查询，给你的是3个整数——a,b和k，你要对列表中从位置a到位置b范围内的（包含a和b)的全部元素加上k。



**输入格式**

第一行包含两个整数 *N*和 *M*。
接下来 M行，每行包含3个整数 *a*, *b* 和 *k*。
**列表中的数位置编号为从\*1\*到 \*N\*。**



**输出格式**

单独的一行包含 **最终列表里的最大值**

**约束条件**

-   $3 <= N <= 10^7$
-   $1 <= M <= 2*10^5$
-   $1 <= a <= b <= N$
-   $0 <= k <= 10^9$

**输入样例 #00:**

```
5 3
1 2 100
2 5 100
3 4 100
```

**输出样例 #00:**

```
200
```

**解释:**

第一次更新后，列表变为 `100 100 0 0 0`，
第二次更新后，列表变为 `100 200 100 100 100`。
第三次更新后，列表变为 `100 200 200 200 100`。
因此要求的答案是200。

## 2、解题思路

-   将一段距离的更新看成上下车，判断某一个点在车上的人数即可
-   第一步：更新所有点上下车人数
-   第二步：根据前一站的人数，更新当前站人数



```python
#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the arrayManipulation function below.
def arrayManipulation(n, queries):
    dp = [0] * (n + 2)

    for start, end, num in queries:
        dp[start] += num
        dp[end + 1] -= num
    ans = 0
    for i in range(1, n + 1):
        dp[i] += dp[i - 1]
        ans = max(ans, dp[i])

    return ans

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    nm = input().split()

    n = int(nm[0])

    m = int(nm[1])

    queries = []

    for _ in range(m):
        queries.append(list(map(int, input().rstrip().split())))

    result = arrayManipulation(n, queries)

    fptr.write(str(result) + '\n')

    fptr.close()

```

