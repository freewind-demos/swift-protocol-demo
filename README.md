# Swift 协议 Demo

## 简介

展示 Swift 协议的创建、实现、继承和默认实现。

## 启动和使用

```bash
cd swift-protocol-demo
swift run
```

## 教程

### 协议定义

```swift
protocol ProtocolName {
    var property: Type { get }
    func method()
}
```

### 协议特点

- 类似于其他语言的接口
- 支持默认实现
- 支持关联类型
- 可以组合多个协议
