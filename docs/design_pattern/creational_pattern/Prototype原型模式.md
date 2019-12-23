# Prototype原型模式

[TOC]

## 1、简介

原型模式`（Prototype Pattern）`是用于创建重复的对象，同时又能保证性能。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

这种模式是实现了一个原型接口，该接口用于创建当前对象的克隆。当直接创建对象的代价比较大时，则采用这种模式。

例如，设计一个游戏的场景的时候，需要创建`1000`人的工兵对象，如果直接将每个对象创建出来，速度会很慢（对象需要加载配置），而原型模式则是实现一个接口`clone`，并在一开始缓存一个工兵对象，这样直接调用`1000`次这个接口，就得到了`1000`个工兵对象。



## 2、模式说明

**背景：**

-   简单的游戏，有三个对象：骑士，弓箭手，军营，其中军营能够创建上面的两种对象

下面使用 `time.sleep(1)`模拟创建一个对象的耗时，例如需要打开文件或者网络通信



```python
import time
import timeit


class Knight:
    def __init__(self, life, speed, attack_power, attack_range, weapon):
        self.unit_type = "Knight"
        self.life = life
        self.speed = speed
        self.attack_power = attack_power
        self.attack_range = attack_range
        self.weapon = weapon
        time.sleep(1)

    def __str__(self):
        return "Type: {0}\n" \
               "Life: {1}\n" \
               "Speed: {2}\n" \
               "Attack Power: {3}\n" \
               "Attack Range: {4}\n" \
               "Weapon: {5}\n".format(
            self.unit_type,
            self.life,
            self.attack_power,
            self.attack_range,
            self.speed,
            self.weapon,
        )


class Archer:
    def __init__(self, life, speed, attack_power, attack_range, weapon):
        self.unit_type = "Archer"
        self.life = life
        self.speed = speed
        self.attack_power = attack_power
        self.attack_range = attack_range
        self.weapon = weapon
        time.sleep(1)

    def __str__(self):
        return "Type: {0}\n" \
               "Life: {1}\n" \
               "Speed: {2}\n" \
               "Attack Power: {3}\n" \
               "Attack Range: {4}\n" \
               "Weapon: {5}\n".format(
            self.unit_type,
            self.life,
            self.attack_power,
            self.attack_range,
            self.speed,
            self.weapon,
        )


class Barracks:
    def generate_knight(self):
        return Knight(400, 5, 3, 1, "short sword")

    def generate_archer(self):
        return Archer(200, 7, 1, 5, "short bow")


if __name__ == "__main__":
    barrack = Barracks()
    knight1 = barrack.generate_knight()
    archer1 = barrack.generate_archer()
    print("[knight] {}".format(knight1))
    print("[archer] {}".format(archer1))
    obj_nums = 10
    print("Generate {} knight ".format(obj_nums))
    print(timeit.timeit("barrack.generate_knight()", setup="from __main__ import barrack", number=obj_nums))
    print("Generate {} archer ".format(obj_nums))
    print(timeit.timeit("barrack.generate_archer()", setup="from __main__ import barrack", number=obj_nums))

```

```
[knight] Type: Knight
Life: 400
Speed: 3
Attack Power: 1
Attack Range: 5
Weapon: short sword

[archer] Type: Archer
Life: 200
Speed: 1
Attack Power: 5
Attack Range: 7
Weapon: short bow

Generate 10 knight 
10.037141880995478
Generate 10 archer 
10.037094627987244
```

如上所示，分别创建`10`个对象耗时都超过`10s`，也就是每个对象创建的时候都需要`1s`以上

然后我们其进行改造，实现一个`clone`接口，如下所示

```python
import time
import timeit
from abc import ABCMeta, abstractmethod
from copy import deepcopy


class Prototype(metaclass=ABCMeta):
    @abstractmethod
    def clone(self):
        pass


class Knight(Prototype):
    def __init__(self, life, speed, attack_power, attack_range, weapon):
        self.unit_type = "Knight"
        self.life = life
        self.speed = speed
        self.attack_power = attack_power
        self.attack_range = attack_range
        self.weapon = weapon
        time.sleep(1)

    def __str__(self):
        return "Type: {0}\n" \
               "Life: {1}\n" \
               "Speed: {2}\n" \
               "Attack Power: {3}\n" \
               "Attack Range: {4}\n" \
               "Weapon: {5}\n".format(
            self.unit_type,
            self.life,
            self.attack_power,
            self.attack_range,
            self.speed,
            self.weapon,
        )

    def clone(self):
        return deepcopy(self)


class Archer(Prototype):
    def __init__(self, life, speed, attack_power, attack_range, weapon):
        self.unit_type = "Archer"
        self.life = life
        self.speed = speed
        self.attack_power = attack_power
        self.attack_range = attack_range
        self.weapon = weapon
        time.sleep(1)

    def __str__(self):
        return "Type: {0}\n" \
               "Life: {1}\n" \
               "Speed: {2}\n" \
               "Attack Power: {3}\n" \
               "Attack Range: {4}\n" \
               "Weapon: {5}\n".format(
            self.unit_type,
            self.life,
            self.attack_power,
            self.attack_range,
            self.speed,
            self.weapon,
        )

    def clone(self):
        return deepcopy(self)


class Barracks:
    def __init__(self):
        self.unit = {
            "knight": Knight(400, 5, 3, 1, "short sword"),
            "archer": Archer(200, 7, 1, 5, "short bow"),
        }

    def generate_knight(self):
        return self.unit["knight"].clone()

    def generate_archer(self):
        return self.unit["archer"].clone()


if __name__ == "__main__":
    barrack = Barracks()
    knight1 = barrack.generate_knight()
    archer1 = barrack.generate_archer()
    print("[knight] {}".format(knight1))
    print("[archer] {}".format(archer1))
    obj_nums = 600000
    print("Generate {} knight ".format(obj_nums))
    print(timeit.timeit("barrack.generate_knight()", setup="from __main__ import barrack", number=obj_nums))
    print("Generate {} archer ".format(obj_nums))
    print(timeit.timeit("barrack.generate_archer()", setup="from __main__ import barrack", number=obj_nums))

```

上面实现了`clone`接口，并且创建了`600000`的对象

```
[knight] Type: Knight
Life: 400
Speed: 3
Attack Power: 1
Attack Range: 5
Weapon: short sword

[archer] Type: Archer
Life: 200
Speed: 1
Attack Power: 5
Attack Range: 7
Weapon: short bow

Generate 600000 knight 
9.109043553005904
Generate 600000 archer 
9.20663261199661
```

我们发现，创建`600000`对象耗时与前面的10个对象还要快


