//
//  XibInstantiable.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import Foundation
import UIKit

protocol XibInstantiatable {
    func instantiate()
}

extension XibInstantiatable where Self: UIView {
    func instantiate() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[view]|",
            options:NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[view]|",
            options:NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
    }
}



