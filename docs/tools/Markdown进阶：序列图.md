# Markdown进阶：序列图

## 1、什么是序列图

	序列图（Sequence Diagram），又名时序图、循序图、顺序图，是一种UML交互图。它通过描述对象之间发送消息的时间顺序显示多个对象之间的动态协作。它可以表示用例的行为顺序，当执行一个用例行为时，其中的每条消息对应一个类操作或状态机中引起转换的触发事件。
	
	上面的是百度百科的解释，通俗地讲，时序图，就是描述各个对象之间，不同时间，不同对象之前的动作，或者说消息。

## 2、序列图基础

	常规的时序图由下面几个部分组成：
	
	**角色**
	
		系统角色，可以是人、及其甚至其他的系统或者子系统；
	
		比如说，市民是一个角色，终端系统是一个角色。
	
	**对象**
	
		对象是某一类实例，比方说张三，POS机；
	
		对象包括三种命名方式：

 			 第一种方式包括对象名和类名；

 			 第二中方式只显示类名不显示对象名，即表示他是一个匿名对象；

 			 第三种方式只显示对象名不显示类名。

	**生命线**
	
		见文知意，一个对象的生命线就表示对象的存活时间，是一条垂直的虚线，消息在虚线之间传递。
	
	**控制焦点**
	
		在生命线中的某一个点，对象的动作，也就是某一时刻对象做了什么。
	
	**消息**
	
		在实体之间传递消息，就是不同的时刻，对象之间的消息交互。

---


一个写markdown非常好的工具，typora，支持流程图，时序图，还有mermaid，上标，下标与高亮显示。

![这里写图片描述](http://img.blog.csdn.net/20170701150858902?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhpc2hlbmdxaWFuanVu/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

在**typora**中，实现时序图是基于  [js-sequence](https://bramp.github.io/js-sequence-diagrams/)来实现的，现在csdn默认的也可以支持时序图，主要可以看成有下面几部分组成：

### 2.1 标题(title)

	表示时序图的标题，语法如下：

```
title: 这是标题
```

	示例如下：

```mermaid
sequenceDiagram
title: 这是标题
participant 对象A
```

### 2.2 参与者(participant)

	参与者，也就相当于一个对象实例，可以使用下面的语法来定义：

```
participant 对象A
participant 对象B
```

	效果如下：

```mermaid
sequenceDiagram
title: 标题
participant 对象A
participant 对象B
```

### 2.3 消息(Note)

	这里的消息，表示参与者在某时刻的动作，有三个位置可选择，左，中，右，语法如下：

```
participant 对象A
Note left of 对象A: 这是左面的消息
```

```mermaid
sequenceDiagram
participant 对象A
Note left of 对象A: 这是左面的消息
```

```
participant 对象B
Note over 对象B: 这是中间的消息
```

```mermaid
sequenceDiagram
participant 对象B
Note over 对象B: 这是中间的消息
```

```
participant 对象C
Note right of 对象C: 这是右面的消息
```

```mermaid
sequenceDiagram
participant 对象C
Note right of 对象C: 这是右面的消息
```



### 2.4 动作(actor)

	动作表示两个对象之间的交互，有两种格式：

```
对象A->对象B:How are you?
对象B-->>对象A:Fine,and you?
```

```mermaid
sequenceDiagram
对象A->>对象B:How are you?
对象B-->>对象A:Fine,and you?
```



	一种是虚线，一种是实线。



### 2.5 官方参考图

![sequence](https://bramp.github.io/js-sequence-diagrams/images/grammar.png)

## 3、时序图实例

### 3.1 示例1

	在画图的时候，有时候不用提前定义参与者，不过提前定义显得清晰。

```
title: Alice and Bob
participant Alice
participant Bob
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```







```mermaid
sequenceDiagram
title: Alice and Bob
participant Alice
participant Bob
Alice->>Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->>Alice: I am good thanks!
```





### 3.2 示例2

```
Title: Here is a title
A->B: Normal line 
B-->C: Dashed line 
C->>D: Open arrow 
D-->>A: Dashed open arrow

Note left of A: Note to the\n left of A 
Note right of A: Note to the\n right of A 
Note over A: Note over A 
Note over C,D: Note over both C and D
```





```mermaid
sequenceDiagram
Title: Here is a title
A->>B: Normal line 
B-->>C: Dashed line 
C->>D: Open arrow 
D-->>A: Dashed open arrow

Note left of A: Note to the\n left of A 
Note right of A: Note to the\n right of A 
Note over A: Note over A 
Note over C,D: Note over both C and D
```

### 3.3 示例3

```
participant 客户端
participant 服务器
participant 通行证中心
Note over 客户端: 用户输入通行证的账号、密码
客户端->通行证中心: 发送账号、密码
Note over 通行证中心: 验证账号、密码
通行证中心-->>客户端: 返回token
客户端->服务器: 发送token
服务器->通行证中心: 验证token
通行证中心-->>服务器: 验证成功
服务器-->>客户端: 登陆成功
```







```mermaid
sequenceDiagram
participant 客户端
participant 服务器
participant 通行证中心
Note over 客户端: 用户输入通行证的账号、密码
客户端->>通行证中心: 发送账号、密码
Note over 通行证中心: 验证账号、密码
通行证中心-->>客户端: 返回token
客户端->>服务器: 发送token
服务器->>通行证中心: 验证token
通行证中心-->>服务器: 验证成功
服务器-->>客户端: 登陆成功
```