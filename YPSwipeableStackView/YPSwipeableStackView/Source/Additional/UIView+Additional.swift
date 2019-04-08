//
//  UIView+Additional.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/8/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import UIKit

public extension UIView {
    
    func embedView(_ viewToEmbed: UIView) {
        addSubview(viewToEmbed)
        addConstraints(for: viewToEmbed)
    }
    
    func addConstraints(for embeddedView: UIView) {
        guard embeddedView.superview == self else { return }
        embeddedView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .directionLeadingToTrailing, metrics: nil, views: ["view": embeddedView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .directionLeadingToTrailing, metrics: nil, views: ["view": embeddedView]))
    }
}
