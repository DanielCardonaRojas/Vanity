# Vanity

Composable and reusable styling to UI elements.

## Installation

**SwiftPM**

Add this to dependencies array:

```swift
.package(url: "https://github.com/DanielCardonaRojas/Vanity.git", .upToNextMajor(from: "1.0.0")
```
## Features

- Nice composable API through function builders for Swift5.1 
- Structure styles in anyway you want (nested enums etc..)
- Type safe (Vanity exposes two style types, one which applies to all UIViews -> GenericStyle and a generic variant Style\<T:UIView\>)


## Usage


**Define a theme**

Organize styles anyway you like

```swift
enum AppTheme {
    static let subtitleLabelStyle = Style<UILabel> { lbl in
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
    }

    static let baseButtonStyle =  Style<UIButton> { btn in
        btn.tintColor = .brown
    }

    static var primaryButtonStyle: Style<UIButton> =
        Self.baseButtonStyle
        |> .roundedCorners()
        |> .fatBorder(.red)
}
```

Use styles across different UIView subclasses creating GenericStyle values.

```swift
fileprivate extension GenericStyle {
    static func roundedCorners(_ value: CGFloat = 5.0) -> GenericStyle {
        return GenericStyle { v in
            v.layer.cornerRadius = value
        }
    }

    static func fatBorder(_ color: UIColor) -> GenericStyle {
        return GenericStyle { v in
            v.layer.borderColor = color.cgColor
            v.layer.borderWidth = 2
        }
    }
}
```

**Mark apply to some view**

```swift
class TestView: UIView {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }
    
    func configureStyle() {
        AppTheme.primaryButtonStyle.apply(to: button)
    }
}
```

