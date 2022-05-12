//
//  UIButton+Extension.swift
//  EatHub
//
//  Created by RWS Macbook on 21/04/22.
//

import Foundation
import UIKit

extension UIButton {
    func underline() {
        if let textUnwrapped = self.titleLabel?.text {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.setAttributedTitle(underlineAttributedString, for: .normal)
        }
    }
}
