// swift-protocol-demo.swift

// ============ 基本协议 ============
protocol Drawable {
    func draw()
}

// ============ 协议实现 ============
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

// ============ 协议组合 ============
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

// ============ 协议继承 ============
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

// ============ 协议作为类型 ============
func render(_ shapes: [Drawable]) {
    for shape in shapes {
        shape.draw()
    }
}

let shapes: [Drawable] = [Circle(radius: 5), Square(side: 10)]
render(shapes)

// ============ 默认实现 ============
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
item.describe()

// ============ 关联类型 ============
protocol Container {
    associatedtype Item
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
