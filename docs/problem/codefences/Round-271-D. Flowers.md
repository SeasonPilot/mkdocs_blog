# Round-271: D. Flowers

[TOC]

链接：[Codeforces Round #271](https://codeforces.com/contest/474)

## 1、题目描述

```
time limit per test1.5 seconds
memory limit per test256 megabytes
inputstandard input
outputstandard output
```

We saw the little game Marmot made for Mole's lunch. Now it's Marmot's dinner time and, as we all know, Marmot eats flowers. At every dinner he eats some red and white flowers. Therefore a dinner can be represented as a sequence of several flowers, some of them white and some of them red.

But, for a dinner to be tasty, there is a rule: Marmot wants to eat white flowers only in groups of size *k*.

Now Marmot wonders in how many ways he can eat between *a* and *b* flowers. As the number of ways could be very large, print it modulo `1000000007 (10^9 + 7)`.

### Input

Input contains several test cases.

The first line contains two integers $t$  and $k (1 ≤ t, k ≤ 10^5)$ , where *t* represents the number of test cases.

The next *t* lines contain two integers $a_{i}$ and $b_{i}$  ($1 ≤ a_{i} ≤ b_{i} ≤ 10^5$ ), describing the *i*-th test.

### Output

Print *t* lines to the standard output. The *i*-th line should contain the number of ways in which Marmot can eat between $a_{i}$ and $b_{i}$ flowers at dinner modulo `1000000007` ($10^9 + 7$).

### Examples

**input**

```
3 2
1 3
2 3
4 4
```

**output**

```
6
5
5
```

**Note**

- For *K* = 2 and length 1 Marmot can eat (*R*).
- For *K* = 2 and length 2 Marmot can eat (*RR*) and (*WW*).
- For *K* = 2 and length 3 Marmot can eat (*RRR*), (*RWW*) and (*WWR*).
- For *K* = 2 and length 4 Marmot can eat, for example, (*WWWW*) or (*RWWR*), but for example he can't eat (*WWWR*).



## 2、解题思路

- 使用动态规划

- 由于有时间限制，考虑空间换时间，将所有可能的数据计算出来

- 初始化

  ```
  dp[100001] = {0}
  dp[0]=1
  ```

- 状态转换方程

  ```
  dp[i] = dp[i-1] + dp[i-k]
  if i < k:
     dp[i-k] = 0
  ```



```python
cases, k = map(int, input().strip().split())

total = 100001
mod_num = (10 ** 9) + 7
dp = [0] * total
dp[0] = 1

for i in range(1, total):
    temp = dp[i - k] if i >= k else 0
    dp[i] = (dp[i - 1] + temp) % mod_num
sums = [0] * total
t = 0
for i in range(1, total):
    sums[i] = (sums[i - 1] + dp[i]) % mod_num

for _ in range(cases):
    a, b = map(int, input().strip().split())
    print((sums[b] - sums[a - 1] + mod_num) % mod_num)
```

```c++
#include <iostream>
#include <vector>

using namespace std;

int total = 100001;
int mod_num = 1000000007;
vector<int> dp(static_cast<unsigned long>(total), 0);
vector<int> sums(total, 0);

void solve() {
    int lhs, rhs;
    cin >> lhs >> rhs;

    cout << (sums[rhs] - sums[lhs - 1] + mod_num) % mod_num << "\n";

}

void casesolve() {
    int cases, times;
    cin >> cases >> times;

    dp[0] = 1;
    int temp = 0;
    for (int i = 1; i < total; i++) {
        temp = 0;
        if (i >= times) {
            temp = dp[i - times];
        }
        dp[i] = (dp[i - 1] + temp) % mod_num;
    }


    for (int i = 1; i < total; i++) {
        sums[i] = (sums[i - 1] + dp[i]) % mod_num;
    }


    for (int i = 1; i <= cases; i++) {
        solve();
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);
    casesolve();
}
```

