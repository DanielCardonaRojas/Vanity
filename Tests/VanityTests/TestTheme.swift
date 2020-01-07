//
//  File.swift
//  
//
//  Created by Daniel Cardona Rojas on 1/6/20.
//

@testable import Vanity
import UIKit

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


class TestView: UIView {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureStyle() {
        AppTheme.primaryButtonStyle.apply(to: button)
    }
}
