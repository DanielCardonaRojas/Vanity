//
//  GenericStyle.swift
//  
//
//  Created by Daniel Cardona Rojas on 1/6/20.
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
