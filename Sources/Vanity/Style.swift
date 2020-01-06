//
//  Style.swift
//
//  Created by Daniel Cardona Rojas on 20/11/19.
//  Copyright © 2019 Daniel Cardona Rojas. All rights reserved.
//

import UIKit

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
