# The Minion Game

[TOC]

```
Practice/Python/Strings/The Minion Game
```



## 1、题目描述

Kevin and Stuart want to play the '**The Minion Game**'.

**Game Rules**

Both players are given the same string, $S$.
Both players have to make substrings using the letters of the string $S$.
Stuart has to make words starting with *consonants*.
Kevin has to make words starting with *vowels*.
The game ends when both players have made all possible substrings.

**Scoring**
A player gets `+1` point for each occurrence of the substring in the string $S$.

**For Example**:
String $S$ = *BANANA*
Kevin's vowel beginning word = *ANA*
Here, *ANA* occurs twice in *BANANA*. Hence, Kevin will get `2` Points.

For better understanding, see the image below:

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-19-082803.png)

Your task is to determine the winner of the game and their score.

**Input Format**

A single line of input containing the string $S$.
**Note**: The string will contain only uppercase letters: $[A-Z]$.

**Constraints**

$0\lt len(S) \le 10^{6}$

**Output Format**

Print one line: the name of the winner and their score separated by a space.

If the game is a draw, print *Draw*.

**Sample Input**

```
BANANA
```

**Sample Output**

```
Stuart 12
```

**Note :
Vowels are only defined as$AEIOU$ . In this problem, is not considered a vowel.**

## 2、解题思路

-   题目的描述就是两个人分别构造子串，一个人以元音字母开头，另一个人以辅音字母开头
-   实际上，这个问题简单的转变成，

```
所有以元音字母开头的所有子串的数量
所有以辅音字母开头的所有子串的数量
```

如果当前字母是元音，那么从当前字母开始，一直都最后，都是满足按照元音开头的条件的

```
例如：BANANA
第二个字母是元音，以第二个字母开头的子串有：
A
AN
ANA
ANAN
ANANA
```

也就是当前索引到字符串最后的长度

代码实例：

```python
def minion_game(string):
    length = len(string)
    Stuart_points = 0
    Kevin_points = 0

    vowels = {"A", "E", "I", "O", "U"}

    for index, ch in enumerate(string):
        if ch in vowels:
            Kevin_points += length - index
        else:
            Stuart_points += length - index

    if Stuart_points > Kevin_points:
        print("Stuart", Stuart_points)
    elif Stuart_points < Kevin_points:
        print("Kevin", Kevin_points)
    else:
        print("Draw")
# your code goes here


if __name__ == '__main__':
    s = input()
    minion_game(s)
```

