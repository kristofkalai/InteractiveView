# InteractiveView
Enhance View with interaction detection! 🔍

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/InteractiveView", exact: .init(0, 0, 1))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
InteractiveView {
    // view
} changed: {
    print("state: \($0), isInteracting: \($0.isInteracting)")
}
```

For details see the Example app.
