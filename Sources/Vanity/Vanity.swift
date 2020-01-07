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

public enum Vanity {
    @_functionBuilder
    public struct Compose {
        public static func buildBlock<S1: Styleable, S2: Styleable>(_ s1: S1, _ s2: S2...) -> Style<S1.ViewType> {
            Style<S1.ViewType> { v in
                s1.styler(v)
                for s in s2 {
                    if let casted = v as? S2.ViewType {
                        s.styler(casted)
                    } else {
                        print("\(v) couldn't be cast to \(S2.ViewType.self)")
                    }
                }
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
