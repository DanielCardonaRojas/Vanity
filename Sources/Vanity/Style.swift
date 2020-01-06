//
//  Style.swift
//
//  Created by Daniel Cardona Rojas on 20/11/19.
//  Copyright © 2019 Daniel Cardona Rojas. All rights reserved.
//

import UIKit

public class Style<T> where T: UIView {

    let styling: (T) -> Void

    public init(_ styling: @escaping (T) -> Void) {
        self.styling = styling
    }
    
    public init(from genericStyle: GenericStyle) {
        self.styling = { cv in genericStyle.styling(cv) }
    }

    public func apply(to view: T) {
        styling(view)
    }
}


// MARK: GenericStyle
public typealias GenericStyle = Style<UIView>
extension GenericStyle {
    func compatible<T: UIView>(with viewType: T.Type) -> Style<T> {
        Style<T> { customView in
            self.styling(customView)
        }
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
