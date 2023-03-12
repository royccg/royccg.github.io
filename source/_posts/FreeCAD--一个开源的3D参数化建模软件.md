---
title: FreeCAD--一个开源的3D参数化建模软件
date: 2023-03-12 16:58:22
tags:
    - FreeCAD
    - Bridge
    - Civil Desigen
---

## 介绍
* * *

[*FreeCAD*](https://www.freecad.org/) 是一个通用的开源化的参数化3D *CAD* 建模软件，软件遵循 [*LGPL许可*](https://www.gnu.org/licenses/lgpl-3.0.en.html) 。
*FreeCAD* 的功能主要是针对 机械工程和产品设计，但也适用于更广泛的工程用途，例如建筑、有限元分析、3D打印等其他方面的设计工作。

*FreeCAD* 具有类似于 CATIA、SoildWorks的工具，因此属于[*CAD*](https://en.wikipedia.org/wiki/Computer-aided_design)、[*PLM*](https://en.wikipedia.org/wiki/Product_lifecycle)、[*CAx*](https://en.wikipedia.org/wiki/Computer-aided_technologies)、[*CAE*](https://en.wikipedia.org/wiki/Computer-aided_engineering)的类软件，是一个基于特征的参数化建模软件，具有模块化的软件架构，可以在不修改核心系统的情况下提供额外的功能。
<!-- more -->

与许多CAD建模软件一样，它有许多的2D组件，以便绘制平面形状草图或创建生产图纸。但是，对于2D绘图不是此软件的重点（优势），动画（渲染）或网格编辑（如Blender、Maya、3ds Max或者Cinema 4D）也不是此软件的主要开发内容。但由于其广泛的适应性，FreeCAD可能在更多的领域内获得关注和发挥作用。

FreeCAD使用了大量关于科学计算的开源库，其中包络功能强大的CAD内核[*Open Cascad Technology(OCCT)*](http://opencascade.org/)；[*Coin3D*](https://github.com/coin3d/coin/wiki) ，一个与[*Open Inventor*](http://en.wikipedia.org/wiki/Open_Inventor)兼容的3D图形开发工具包；[*QT*](http://www.qt.io/)，著名的用户截面UI框架；和 Python，一种现代脚本语言。FreeCAD本身也可以用作其他程序的参考库。

FreeCAD 也是多平台的，目前在 Linux/Unix、Windows 和 macOS 系统上运行，在所有平台上具有相同的外观和功能。

<img src="FreeCAD的建模案例-1.jpg" width="80%">

<img src="FreeCAD的建模案例-2.png" width="80%">

## 特色
***
+ 多平台：FreeCAD可以在多平台（Windows、Linux、macOS等其他平台）运行，并且彼此没有差别。
+ 全GUI操作：FreeCAD有基于Qt框架的完整图形的用户界面，带有基于Open Inventor的3D查看界面；并允许快速渲染3D场景和费用易于访问的场景图。
+ 可通过命令行运行：在命令行模式下，FreeCAD 运行时不展示界面，但可以完成所有的几何工具。在这种模式下，它的内存占用相对较低，例如，可以用作服务器来为其他应用程序生成内容。
+ **可以作为Python的模块导入**：FreeCAD 可以导入到任何可以运行 Python 脚本的应用程序中。与命令行模式一样，FreeCAD 的界面部分不可用，但可以访问所有几何工具。
+ **工作台**：在 FreeCAD 界面中，工具按工作台分组。这允许您仅显示用于完成特定任务的工具，保持工作区整洁和响应迅速，并允许应用程序快速加载。
+ 用于延迟加载功能/数据类型的插件/模块框架： FreeCAD 分为一个核心应用程序，其中包含仅在需要时才加载的模块。几乎所有工具和几何类型都存储在模块中。模块表现得像插件；除了延迟加载之外，还可以在现有的 FreeCAD 安装中添加或删除单个模块。
+ 参数关联文档对象：FreeCAD 文档中的所有对象都可以通过参数定义。这些参数可以随时修改和重新计算。由于保持了对象关系，因此对一个对象的修改将自动更新到一切从属对象。
+ **参数化建模**：可以通过指定几何约束来创建基本对象，例如长方体、球体、圆柱体等。
+ 图形修改操作： FreeCAD 可以在 3D 空间的任何平面中执行平移、旋转、缩放、镜像、偏移或形状转换。
+ 构造实体几何（布尔运算）： FreeCAD 可以进行建设性的实体几何操作（合并、差异、交叉）。
+ 平面几何图形的创建：可以在 3D 空间的任何平面中以图形方式创建直线、导线、矩形、B 样条曲线和圆弧或椭圆弧。
+ 使用直线或旋转拉伸、截面和圆角建模。
+ 拓扑组件：如顶点、边、线和平面。
+ 测试和修复： FreeCAD 具有用于测试网格（实体测试、非双流形测试、自相交测试）和修复网格（孔填充、统一方向）的工具。
+ 注释：FreeCAD 可以为文本或尺寸插入注释。
+ 撤消/重做框架： FreeCAD 中的所有内容都是可撤销/可重做的，用户可以访问撤销堆栈。可以一次撤消多个步骤。
+ 与事务处理相关：撤消/重做堆栈存储文档事务，而不是单个操作，允许每个工具准确定义必须撤消或重做的内容。
+ 内置脚本框架： FreeCAD 具有内置的 Python 解释器，其 API 几乎涵盖了应用程序的任何部分、界面、几何图形以及该几何图形在 3D 查看器中的表示。解释器可以运行复杂的脚本以及单个命令；整个模块可以完全用 Python 编程。
+ 内置 Python 控制台：Python 解释器包括一个带有语法高亮、自动完成和类浏览器的控制台。 Python 命令可以直接在 FreeCAD 中输入并立即返回结果，允许脚本编写者即时测试功能、探索 FreeCAD 模块的内容并轻松了解 FreeCAD 内部结构。
+ 反映用户交互：用户在 FreeCAD 界面中所做的一切都执行 Python 代码，这些代码可以打印在控制台上并记录在宏中。
+ 完整的宏录制和编辑功能：可以记录用户操作界面时发出的 Python 命令，如果需要可以进行编辑，并保存以备日后重现。
+ 复合（基于 ZIP）文档保存格式： FreeCAD 文档以 `.FCStd` 扩展名保存。该文档可以包含许多不同类型的信息，例如几何、脚本或缩略图图标。`.FCStd `文件本身就是一个 zip 容器；保存的 FreeCAD 文件已经被压缩。
+ 完全可定制/可编写脚本的图形用户界面： FreeCAD 基于 Qt 的界面完全可以通过 Python 解释器访问。除了 FreeCAD 本身提供给工作台的简单功能外，整个 Qt 框架都是可访问的。用户可以在 GUI 上执行任何操作，例如创建、添加、停靠、修改或删除小部件和工具栏。
+ 缩略图（目前只有 Linux 系统）: FreeCAD 文档图标在大多数文件管理器应用程序中显示文件的内容，例如 Gnome 的 Nautilus。
+ 模块化 MSI 安装程序： FreeCAD 的安装程序允许在 Windows 系统上灵活安装，还维护了 Ubuntu 系统的软件包。

## 工具台
***
+ **Sketcher**（草图）：带有集成约束求解器的草绘器，允许您绘制受几何约束的 2D 形状草图。使用 Sketcher 构建的受约束的 2D 形状可以用作在整个 FreeCAD 中构建其他对象的基础。
+ **Draft Workench** ：包含 2D 工具以及基本的 2D 和 3D CAD 操作。
+ **Part**：用于处理 CAD 零件的零件工作台。
+ **Part Design**：用于从草图构建零件形状的零件设计工作台。
+  **BIM**（建筑与施工）：旨在在 FreeCAD 中实施完整的建筑信息模型 (BIM) 工作流程。它扩展了 Arch Workbench，并收集了来自其他工作台的工具，以提供一个便于建模建筑和使用 `IFC` 文件的环境。
....


## 参考文献
***
<div id="refer-anchor-1"></div>

- [1] [FreeCAD的官网](https://www.freecad.org/)

<div id="refer-anchor-2"></div>

- [2] [FreeCAD的OverView](https://wiki.freecad.org/About_FreeCAD)

<div id="refer-anchor-3"></div>

- [3] [FreeCAD的工具台介绍](https://wiki.freecad.org/Workbenches)

<div id="refer-anchor-4"></div>

- [4] [FreeCAD的论坛](https://forum.freecad.org/)