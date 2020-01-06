//
//  Style.swift
//  ComposableStyles
//
//  Created by Daniel Cardona Rojas on 20/11/19.
//  Copyright © 2019 Daniel Cardona Rojas. All rights reserved.
//

import UIKit

public struct GenericStyle {
    private let styling: (UIView) -> Void

    init(_ styling: @escaping (UIView) -> Void) {
        self.styling = styling
    }

    func apply(to view: UIView) {
        styling(view)
    }
}

public struct Style<T> where T: UIView {

    private let styling: (T) -> Void

    public init(_ styling: @escaping (T) -> Void) {
        self.styling = styling
    }

    public func apply(to view: T) {
        styling(view)
    }
}

// MARK: Shorthand helpers
extension Style {
    public static func property<P>(_ keyPath: ReferenceWritableKeyPath<T,P>, value: P) -> Style {
        return Style { v in
            v[keyPath: keyPath] = value
        }
    }

    public static func adjustingProperty<P>(_ keyPath: ReferenceWritableKeyPath<T,P>) -> (P) -> Style {
        return { (value: P) in
            Style { v in v[keyPath: keyPath] = value }
        }
    }

}

extension GenericStyle {
    public static func property<P>(_ keyPath: ReferenceWritableKeyPath<UIView,P>, value: P) -> GenericStyle {
        return GenericStyle { v in
            v[keyPath: keyPath] = value
        }
    }

    static func adjustingProperty<P>(_ keyPath: ReferenceWritableKeyPath<UIView,P>) -> (P) -> GenericStyle {
        return { (value: P) in
            GenericStyle { v in v[keyPath: keyPath] = value }
        }
    }
}

// MARK: Combining styles
public func +<V>(_ lhs: Style<V>, rhs: Style<V>) -> Style<V> {
    return Style { (v: V) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public func +<V>(_ lhs: Style<V>, rhs: GenericStyle) -> Style<V> {
    return Style { (v: V) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public func +<V>(_ lhs: GenericStyle, rhs: Style<V>) -> Style<V> {
    return Style { (v: V) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public func +(_ lhs: GenericStyle, rhs: GenericStyle) -> GenericStyle {
    return GenericStyle { (v: UIView) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

// MARK: Component Specific helpers
extension UIView {
    public func applying(_ style: GenericStyle) {
        style.apply(to: self)
    }
}

@_functionBuilder
struct StyleBuilder {
    static func buildBlock(_ styles: GenericStyle...) -> GenericStyle {
        var allStyles = styles
        let firstStyle = allStyles.remove(at: 0)
        return styles.reduce(firstStyle, { accumulatedStyle, newStyle in accumulatedStyle + newStyle })
    }
}

public enum Vanity {
    public static func combine(@StyleBuilder _ content: () -> GenericStyle) -> GenericStyle {
        let styling = content()
        return styling
    }
    
    public static func style(view: UIView, @StyleBuilder _ content: () -> GenericStyle) {
        let styling = content()
        view.applying(styling)
    }
}
