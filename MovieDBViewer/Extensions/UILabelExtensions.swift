//
//  UILabelExtensions.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import Foundation
import UIKit

@IBDesignable
extension UILabel {
    
    @IBInspectable var localizedText: String {
        get { return "" }
        set {
            self.text = newValue.localized
        }
    }
}
