# Vanity

Composable and reusable styling to UI elements.

## Installation

**SwiftPM**

Add this to dependencies array:

```
.package(url: "https://github.com/DanielCardonaRojas/Vanity.git", .upToNextMajor(from: "1.0.0")
```
## Features

- Nice composable API through function builders for Swift5.1 
- Structure styles in anyway you want (nested enums etc..)
- Type safe (Vanity exposes two style types, one which applies to all UIViews -> GenericStyle and a generic variant Style\<T:UIView\>)


## Usage


**Define a theme**

Create a theme enum or struct

```swift
enum AppTheme {
    static let subtitleLabelStyle = Style<UILabel> { lbl in
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
    }

    static let buttonStyle =  Style<UIButton> { btn in
        btn.tintColor = .brown
        } + Self.fatBorder(.red) + Self.roundedCorners()


    // MARK: Generic styles
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
    
    static let thickBlackBorder = Vanity.combine {
        Self.roundedCorners()
        Self.fatBorder(.black)
    }
}
```

**Mark apply to some view**
```swift
class TestView: UIView {
    func styleView() {
        Vanity.style(view: self) {
            //Adhoc styling
            GenericStyle { v in
                v.backgroundColor = .blue
            }
            
            AppTheme.fatBorder(.blue)
            AppTheme.roundedCorners()
        }
    }
}
```

