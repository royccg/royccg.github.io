---
title: Python中的正则表达式
date: 2020-06-26 21:51:07
tags:
    - python
    - 正则

---
使用python对字符串进行处理中，正则表达式的使用是十分有必要的，此处将小做归纳整理。
<!-- more -->

# 正则表达式的概念
+ 正则表达式
    + `Regular Expression` `regex` `RE`
    + 正则表达式是用来简洁表达一组字符串的表达式。
    ![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/5681f11896e22c99cc40ada93af72862.png)
    ![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/b15536cab55bf243b3ef79660170f29b.png)
    + 通用的字符串表达框架
    + 简洁表达一组字符串的表达式
    + 针对字符串表达“简洁”和“特征”思想的工具
    + 判断某字符串的特征归属

+ 正则表达式在文本处理中十分常用
    + 表达文本类型的特征（病毒、入侵等）
    + 同时查找或替换一组字符串
    + 匹配字符串的全部或部分

+ 正则表达式的使用
    + 编译：将符合正则表达式语法的字符串转换成正则表示特征
    ![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/2c5d34f3af596ce2ef520f0edca49988.png)

# 正则表达式的语法
正则表达式是由字符和 操作符组成的

操作符|说明|实例
:----|:---:|:--:
`.`|表示任何单个字符|
`[]`|字符集，对单个字符给出取值范围|`[abc]`表示a、b、c，`[a-z]`表示a到z单个字符
`[^]`|非字符集，对单个字符给出排除范围|`[^abc]`表示非a或b或c的单个字符
`*`|前一个字符0次或无限次扩展|`abc*`表示ab、abc、abcc、abccc等
`+`|前一个字符1次货无限次扩展|`abc+`表示abc、abcc、abccc等
`?`|前一个字符0次货1次扩展|`abc?`表示ab、abc
` &#124 `|左右表达式任意一个|`abc &#124 def` `表示abc、def
`{m}`|扩展前一个字符m次|`ab{2}c`表示abbc
`{m,n}`|扩展前一个字符m至n次（含n）| `ab{1,2}c`表示abc、abbc
`^`|匹配字符串开头|`^abc`表示abc且在一个字符串的开头
`$`|匹配字符串结尾|`abc$`表示abc且在一个字符串的结尾
`()`|分组标记，内部职能使用 &# 124 操作符 | `(abc)`表示abc，`(abc&#124 def)` 表示abc、def
`\d`|数字，等价于 `[0-9]`
`\w`|单词字符，等价于 `[A-Za-z0-9]`


# 经典正则表达式实例
--------------------------------
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/f7627fa325b23d3d55e679680cf2566a.png)

## 匹配IP地址的正则表达式
IP地址字符串形式的正则表达式
（IP地址分4段，每段0-255）
+ 精确写法
    + 0-99: `[1-9]?\d`
    + 100-199: `1\d{2}`
    + 200-249: `2[0-4]\d`
    + 250-255：`25[0-5]`

    ```regex
    (([1-9]?\d|1\d{2}|2[0-4]\d|25[0-5]).){3}([1-9]?\d|1\d{2}|2[0-4]\d|25[0-5])
    ```

# Re库的使用
--------------------------------
Re库是Python的标准库，主要用于字符串匹配
```python
import re
```

## 正则表达式的表示类型
### raw string类型（原生字符串类型）
re库采用raw string类型表示正则表达式，表示为`r"text"`
例如：
+ `r'[1-9]\d{5}'`
+ `r'\d{3}-\d{8}|\d{4}-\d{7}'`

raw string是不包括转义符的字符串
### string类型，更繁琐
例如
+ `'[1-9]\\d{5}'`
+ `'\\d{3}-\\d{8}|\\d{4}-\\d{7}'`

## Re库主要功能函数

函数| 说明
:--:|:--:
`re.search()`| 在一个字符串中搜索匹配正则表达式的第一个位置，返回`match`对象
`re.match()`|从一个字符串的开始位置起匹配正则表达式，返回`match`对象
`re.findall`|搜索字符串，以列表类型返回全部能匹配的子串
`re.split()`|将一个字符串按照正则表达式匹配结果进行分割，返回列表类型
`re.finditer()`|搜索字符串，返回一个匹配结果的迭代类型，每个迭代元素是`match`对象
`re.sub()`|在一个字符串中替换所有匹配正则表达式的子串，返回替换后的字符串

### `re.search()`
`re.search(pattern, string, flags=0)`
 在一个字符串中搜索匹配正则表达式的第一个位置，返回`match`对象
+ `pattern`：正则表达式的字符串或原生字符串表示
+ `string`：待匹配字符串
+ `flags`：正则表达式使用时的控制标记

常用标记| 说明
:--|:--
`re.I` `re.IGNORECASE`|忽略正则表达式的大小写，`[A-Z]`能匹配小写字符
`re.M` `re.MULTILINE`| 正则表达式中的`^`操作符能够将给定字符串的每行当做匹配开始
`re.S` `re.DOTALL`| 正则表达式中的`.`操作符能够匹配所有字符，默认匹配除换行外的所有字符

```python
import re
match = re.search(r'[1-9]\d{5}', 'BIT 100081')
if match:
    print(match.group(0))

100081
```
### `re.match()`
```python
re.match(pattern, string, flags=0)
```
从一个字符串的开始位置起匹配正则表达式，返回`match`对象。
+ `pattern`：正则表达式的字符串或原生字符串表示；
+ `string`: 待匹配字符串；
+ `flags`: 正则表达式使用时的控制标记。

```python
import re
match = re.match(r'[1-9]\d{5}', '100081 BIT')
if match:
    match.group(0)
'100081'
```

### `re.findall()`
`re.findall(pattern, string, flags = 0)`
搜索字符串，以列表类型返回全部能匹配的子串。

```python
import re
ls = re.findall(r'[1-9]\d{5}', 'BIT100081 TSU100084')
ls

['100081', '1000084']

```

### `re.split()`
`re.split(pattern, string, maxsplit = 0, flags =0)`
将一个字符串按照正则表达式匹配结果进行分割，返回列表类型。
+ `maxsplit`： 最大分割数，剩余部分作为最后一个元素输出。

```python
import re
re.split(r'[1-9]\d{5}', 'BIT100081 TSU100084')
['BIT', ' TSU', '']

re.split(r'[1-9]\d{5}', 'BIT100081 TSU100084', maxsplit=1)
['BIT', 'TSU100084']
```

### `re.finditer()`
`re.finditer(pattern, string, flags = 0)`
搜索字符串，返回一个匹配结果的迭代类型，每个迭代元素是`match`对象。

```python
import re
for m in re.finditer(r'[1-9]\d{5}', 'BIT100081 TSU100084'):
    if m:
        print(m.group(0))

100081
100084
```

### `re.sub()`
`re.sub(pattern, repl, string, count=0, flags = 0)`
在一个字符串中替换所有匹配正则表达式的子串，返回替换后的字符串。
+ `repl`：替换匹配字符串的字符串
+ `count`：匹配的最大替换次数

```python
import re
re.sub(r'[1-9]\d{5}', ':zipcode', 'BIT100081 TSU100084')

'BIT:zipcode TSU:zipcode'
```
# Re库的另一种等价用法
+ 函数式用法：一次性操作
```python
rst = re.search(r'[1-9]\d{5}', 'BIT 100081')
```
+ 面向对象用法：编译后的多次操作
```python
pat = re.compile(r'[1-9]\d{5}')
rst = pat.search('BIT 100081')
```

`regex = re.compile(pattern, flags = 0)`
将正则表达式的字符串形式编译成正则表达式对象
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/004f1fd6d609e6c220fb12981b6bf2dd.png)

# Re库的Match对象
```python
import re
match = re.search(r'[1-9]\d{5}', 'BIT100084')
if match:
    print(match.group(0))

100081

type(match)
<class '_sre.SRE_Match'>

```
## Match对象的属性

属性|说明
:--|:--
`.string`| 待匹配的文本
`.re`| 匹配时使用的`pattern`对象（正则表达式）
`.pos`|正则表达式搜索文本的开始位置
`.endpos`| 正则表达式搜索文本的结束位置

## Match对象的方法
方法| 说明
:--|:--
`.group(0)`| 获取匹配后的字符串
`.start()`|匹配字符串再原始字符串的开始位置
`.end()`|匹配字符串再原始字符串的结束位置
`.span()`|返回`(.start()..end())`

```python
import re
m = re.search(r'[1-9]\d{5}', 'BIT100081 TSU100084')
m.string
'BIT100081 TSU100084'

m.re
re.compile('[1-9]\\d{5}')

m.pos
0

m.endpos
19

m.group(0)
'100081'

m.start()
3

m.span()
(3, 9)
```

# Re库的贪婪匹配和最小匹配

+ 实例
```python
import re
match = re.search(r'PY.*N', 'PYANBNCNDN')
match.group(0)
```

### 贪婪匹配
Re库默认采用贪婪匹配，即输出匹配最长的子串
```python
match.group(0)
'PYANBNCNDN'
```

### 最小匹配
如何输出最短的字串
**加入`?`**
```python
match = re.search(r'PY.*?N', 'PYANBNCNDN')
match.group(0)
'PYAN'
```

最小匹配操作符

操作符|说明
:----|:----
`*?`|前一个字符0次或无限次扩展，最小匹配
`+?`|前一个字符1次或无限次扩展，最小匹配
`??`|前一个字符0次或1次扩展，最小匹配
`{m,n}?`|扩展前一个字符m至n次（含n），最小匹配

### Re库（正则表达式）入门
正则表达式是用来简洁表达一组字符串的表达式

`r'\d{3}-\d{8}|\d{4}-\d{7}'`

![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/e373722ac039ec0e31aa5ba0146d28c8.png)
