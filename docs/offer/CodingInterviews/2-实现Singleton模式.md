# 2-实现Singleton模式

[TOC]

## 1、单例模式

单例模式就是确保一个类只有一个实例.当希望整个系统中,某个类只有一个实例时,就用到了单例模式

例如某个服务器的配置信息存在在一个文件中,客户端通过`AppConfig`类来读取配置文件的信息.

如果程序的运行的过程中,很多地方都会用到配置文件信息,则就需要创建很多的`AppConfig`实例,这样就导致内存中有很多`AppConfig`对象的实例,造成资源的浪费.其实这个时候`AppConfig`我们希望它只有一份,就可以使用单例模式.



## 2、代码实现

### 2.1 使用import的方式

为这个配置单独编写一个模块，在`python`中，引入只有一次，其他代码再次引入就会直接使用已经引入的模块

```python
class Apple:
    def __init__(self):
        pass

    def eat(self):
        print("Eat an apple.")


apple = Apple()

```

在代码中引入使用

```python
from singleton.mySingleton import apple

apple.eat()

```



### 2.2 通过装饰器实现

```python
from functools import wraps


def singleton(cls):
    _instance = {}

    @wraps(cls)
    def _singleton(*args, **kwargs):
        if cls not in _instance:
            _instance[cls] = cls(*args, **kwargs)
        return _instance[cls]

    return _singleton


@singleton
class Apple(object):
    num = 0

    def __init__(self, a=0):
        self.a = a
        self.num += 1
        print("Init. ")


s1 = Apple(1)
s2 = Apple(2)
print(id(s1), id(s2))
print(s1.a, s2.a)
print(s1.num, s2.num)
print(Apple.num)

```

**输出：**

```
Init. 
4360689088 4360689088
1 1
1 1
0
```

通过装饰器，实际上就是利用装饰器的闭包特性，判断是否已经创建了这个实例，创建就直接返回



### 2.3 使用类方法实现

使用类实现，就需要调用类的特定方法，有些麻烦

```python
class Apple(object):
    def __init__(self, *args, **kwargs):
        pass

    @classmethod
    def get_apple(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            cls._instance = cls(*args, **kwargs)
        return cls._instance


s1 = Apple()
s2 = Apple.get_apple()
s3 = Apple()
s4 = Apple.get_apple()

print(id(s1), id(s2), id(s3), id(s4))

```

**输出：**

```
4389420896 4389421008 4389458104 4389421008
```

如上，只有调用类的特定方法的时候，才能实现单例



### 2.4 基于`__new__`实现

`__new__`在创建实例的时候才会调用

```python
class Apple(object):
    def __init__(self, *args, **kwargs):
        pass

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            cls._instance = super().__new__(cls)
        return cls._instance


s1 = Apple()
s2 = Apple()

print(s1, s2, sep="\n")

```

输出：

```
<__main__.Apple object at 0x1020634a8>
<__main__.Apple object at 0x1020634a8>
```



### 2.5 多线程的处理方式

```python
import threading
import time


class Apple(object):
    def __init__(self, *args, **kwargs):
        time.sleep(1)

    @classmethod
    def get_apple(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            cls._instance = cls(*args, **kwargs)
        return cls._instance


def task(arg):
    obj = Apple.get_apple(arg)
    print(obj)


for i in range(10):
    t = threading.Thread(target=task, args=[i, ])
    t.start()

```

如上所示的创建实例对象，输出如下：

```
<__main__.Apple object at 0x1057910f0>
<__main__.Apple object at 0x1073a3940>
<__main__.Apple object at 0x1073bef28>
<__main__.Apple object at 0x1073a3c50>
<__main__.Apple object at 0x107638438>
<__main__.Apple object at 0x107638048>
<__main__.Apple object at 0x107638160>
<__main__.Apple object at 0x1073a3d30>
<__main__.Apple object at 0x1076385c0>
<__main__.Apple object at 0x107638748>
```

可以看到对象在内存中是不同的，因此这种方式的实现咋多线程中不能实现单例模式，需要加锁

```python
import threading
import time


class Apple(object):
    _singleton_lock = threading.Lock()

    def __init__(self, *args, **kwargs):
        time.sleep(1)

    @classmethod
    def get_apple(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            with cls._singleton_lock:
                if not hasattr(cls, '_instance'):
                    cls._instance = cls(*args, **kwargs)
        return cls._instance


def task(arg):
    obj = Apple.get_apple(arg)
    print(obj)


for i in range(10):
    t = threading.Thread(target=task, args=[i, ])
    t.start()

```

如上，加锁以后，输出如下：

```
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
<__main__.Apple object at 0x1026033c8>
```

现在得到了想要的结果



基于`__new__`的多线程版本：

```python
import threading
import time


class Apple(object):
    _singleton_lock = threading.Lock()

    def __init__(self, *args, **kwargs):
        time.sleep(1)

    def __new__(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            with cls._singleton_lock:
                if not hasattr(cls, '_instance'):
                    cls._instance = super().__new__(cls)
        return cls._instance


def task(arg):
    obj = Apple()
    print(obj)


for i in range(10):
    t = threading.Thread(target=task, args=[i, ])
    t.start()

```

```
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
<__main__.Apple object at 0x1009b33c8>
```

