//
//  Vanity.swift
//  
//
//  Created by Daniel Cardona Rojas on 1/6/20.
//



import UIKit

// MARK: Combining styles
precedencegroup PipePrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator |> : PipePrecedence

public func |><V>(_ lhs: Style<V>, rhs: Style<V>) -> Style<V> {
    return Style { (v: V) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public func |><V>(_ lhs: Style<V>, rhs: GenericStyle) -> Style<V> {
    return Style { (v: V) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public func |><V>(_ lhs: GenericStyle, rhs: Style<V>) -> Style<V> {
    return Style { (v: V) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public func |>(_ lhs: GenericStyle, rhs: GenericStyle) -> GenericStyle {
    return GenericStyle { (v: UIView) -> Void in
        lhs.apply(to: v)
        rhs.apply(to: v)
    }
}

public struct Vanity {
    @_functionBuilder
    public struct Compose {
        public static func buildBlock<T: UIView>(_ styles: Style<T>...) -> Style<T> {
            var allStyles = styles
            let firstStyle = allStyles.remove(at: 0)
            return allStyles.reduce(firstStyle, { accumulatedStyle, nextStyle in accumulatedStyle |> nextStyle })
        }
    }
}

public typealias Styler<V> = (V) -> Void

public protocol Styleable {
    associatedtype ViewType: UIView
    var styler: Styler<ViewType> { get }
    
}

extension Style: Styleable {
    public var styler: (T) -> Void {
        styling
    }
}

