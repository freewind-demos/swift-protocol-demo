# Swift 协议 Demo

## 简介

本 demo 展示 Swift 协议的创建、实现、继承和默认实现。协议（Protocol）是 Swift 中**面向接口编程**的核心，它定义了行为的蓝图，让不同类型可以共享相同的接口。

## 基本原理

### 什么是协议？

协议定义了**方法、属性和其他需求的蓝图**，具体实现由遵循协议的类型完成。

```swift
protocol Drawable {
    var radius: Double { get }  // 需要实现的属性
    func draw()                  // 需要实现的方法
}
```

### 协议 vs 其他语言的接口

Swift 协议类似于其他语言的接口（Interface），但更加强大：

| 特性 | 其他语言 | Swift 协议 |
|------|----------|------------|
| 默认实现 | 不支持 | 支持 |
| 关联类型 | 不支持 | 支持 |
| 协议组合 | 受限 | 简单 |
| 值类型遵循 | 不支持 | 支持 |

### 协议在 Swift 中的地位

Swift 是一种**面向协议编程（Protocol-Oriented Programming）**的语言，协议在 Swift 中无处不在：
- `Equatable`、`Hashable`、`Codable` 等标准库协议
- SwiftUI 的 `View` 协议
- 集合类型的 `Collection`、`Sequence` 协议

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-protocol-demo
swift run
```

---

## 教程

### 定义协议

```swift
protocol Drawable {
    var radius: Double { get }     // 只读属性
    func draw()                    // 实例方法
}
```

协议可以要求：
- **属性**（必须是 var，且指定 { get } 或 { get set }）
- **方法**（不需要 func 关键字，但要写参数和返回值）
- **下标**
- **初始化器**

### 实现协议

```swift
struct Circle: Drawable {
    var radius: Double

    func draw() {
        print("画圆，半径: \(radius)")
    }
}

struct Square: Drawable {
    var side: Double

    func draw() {
        print("画正方形，边长: \(side)")
    }
}
```

使用：

```swift
let circle = Circle(radius: 5)
circle.draw()
```

### 协议作为类型

协议可以作为**类型**使用：

```swift
func render(_ shapes: [Drawable]) {
    for shape in shapes {
        shape.draw()
    }
}

let shapes: [Drawable] = [Circle(radius: 5), Square(side: 10)]
render(shapes)
```

**原理**：Swift 的静态分发允许协议作为类型使用，所有遵循 `Drawable` 的类型都可以传入。

### 协议组合

多个协议可以用 `&` 组合：

```swift
protocol Printable {
    func printDescription()
}

protocol Serializable {
    func toString() -> String
}

struct DataItem: Printable, Serializable {
    var name: String

    func printDescription() {
        print("数据项: \(name)")
    }

    func toString() -> String {
        return name
    }
}

// 使用协议组合
func process(_ item: Printable & Serializable) {
    item.printDescription()
    print(item.toString())
}
```

### 协议继承

协议可以继承其他协议：

```swift
protocol Drawable {
    func draw()
}

protocol AdvancedDrawable: Drawable {
    var color: String { get }
    func fill()
}

struct FilledCircle: AdvancedDrawable {
    var radius: Double
    var color: String

    func draw() {
        print("画圆")
    }

    func fill() {
        print("填充颜色: \(color)")
    }
}
```

### 默认实现

协议可以提供**默认实现**，让遵循者选择是否覆盖：

```swift
protocol Describable {
    var name: String { get }
    func describe() {
        print("这是 \(name)")
    }
}

struct Item: Describable {
    var name: String = "物品"
}

let item = Item()
item.describe()  // 输出: 这是 物品
```

**使用场景**：为协议添加新方法而不破坏现有实现。

### 关联类型（Associated Types）

协议可以使用**关联类型**，让实现者决定具体类型：

```swift
protocol Container {
    associatedtype Item  // 由实现者决定类型
    var items: [Item] { get }
    mutating func add(_ item: Item)
}

struct Stack<T>: Container {
    var items: [T] = []

    mutating func add(_ item: T) {
        items.append(item)
    }
}

var stack = Stack<Int>()
stack.add(1)
stack.add(2)
print("栈内容: \(stack.items)")
```

**原理**：关联类型让协议更加灵活，实现者可以指定具体的泛型类型。

---

## 关键代码详解

### 协议的静态分发

```swift
func render(_ shapes: [Drawable]) {
    for shape in shapes {
        shape.draw()
    }
}
```

这里的 `shape.draw()` 是通过**虚表（vtable）**进行动态分发的，而不是静态分发。这允许不同类型有不同实现。

### 协议扩展

协议可以被扩展，提供默认实现：

```swift
extension Drawable {
    func description() -> String {
        return "一个可绘制的图形"
    }
}
```

这样所有遵循 `Drawable` 的类型都会获得这个默认实现。

---

## 总结

协议是 Swift 面向协议编程的核心：

1. **定义行为蓝图** — 协议定义需要实现的方法和属性
2. **默认实现** — 可以在协议扩展中提供默认实现
3. **协议组合** — 用 `&` 组合多个协议
4. **关联类型** — 让协议更加灵活

协议的使用场景：
- 定义通用接口（可绘制、可序列化）
- 实现依赖注入
- 面向接口编程
- SwiftUI 的 View 协议
