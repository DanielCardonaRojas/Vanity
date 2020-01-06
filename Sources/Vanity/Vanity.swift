//
//  Vanity.swift
//  
//
//  Created by Daniel Cardona Rojas on 1/6/20.
//

import UIKit

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
struct GenericStyleBuilder {
    static func buildBlock(_ styles: GenericStyle...) -> GenericStyle {
        var allStyles = styles
        let firstStyle = allStyles.remove(at: 0)
        return styles.reduce(firstStyle, { accumulatedStyle, newStyle in accumulatedStyle + newStyle })
    }
}

@_functionBuilder
struct StyleBuilder {
    static func buildBlock<T>(_ styles: Style<T>...) -> Style<T> {
        var allStyles = styles
        let firstStyle = allStyles.remove(at: 0)
        return styles.reduce(firstStyle, { accumulatedStyle, newStyle in accumulatedStyle + newStyle })
    }
}

public enum Vanity {
    public static func combine(@GenericStyleBuilder _ content: () -> GenericStyle) -> GenericStyle {
        let styling = content()
        return styling
    }
    
    public static func combine<T: UIView>(@StyleBuilder _ content: () -> Style<T>) -> Style<T> {
        let styling = content()
        return styling
    }
    
    public static func style(view: UIView, @GenericStyleBuilder _ content: () -> GenericStyle) {
        let styling = content()
        view.applying(styling)
    }
    
    public static func style<T: UIView>(view: T, @StyleBuilder _ content: () -> Style<T>) {
        let styling = content()
        styling.apply(to: view)
    }
}
