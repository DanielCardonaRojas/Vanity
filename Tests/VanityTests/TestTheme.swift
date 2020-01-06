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

    static let buttonStyle =  Style<UIButton> { btn in
        btn.tintColor = .brown
        } + Self.fatBorder(.red) + Self.roundedCorners()

    static let thickBlackBorder = Vanity.combine {
        Self.roundedCorners()
        Self.fatBorder(.black)
    }

    // MARK: Generic styles
    static let backgroundColor = GenericStyle.adjustingProperty(\.backgroundColor)
    
    static func roundedCorners(_ value: CGFloat = 5.0) -> GenericStyle {
        return GenericStyle { v in
            v.layer.cornerRadius = value
        }
    }
    
    static func fatBorder(_ color: UIColor) -> GenericStyle {
        return GenericStyle { v in
            v.layer.borderColor = UIColor.black.cgColor
            v.layer.borderWidth = 2
        }
    }
}


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
