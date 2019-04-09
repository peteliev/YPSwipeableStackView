//
//  ColoredView.swift
//  YPSwipeableStackViewExample
//
//  Created by Zhenya Peteliev on 4/9/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import UIKit

@IBDesignable
public class ColoredView: UIView {
    
    // MARK: - Public Properties
    @IBInspectable public var borderColor: UIColor = .black {
        didSet { updateBorderColor() }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet { updateBorderWidth() }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet { updateCornerRadius() }
    }
    
    @IBInspectable public var shadowColor: UIColor = .black {
        didSet { updateShadowColor() }
    }
    @IBInspectable public var shadowOpacity: CGFloat = 0.0 {
        didSet { updateShadowOpacity() }
    }
    @IBInspectable public var shadowRadius: CGFloat = 3.0 {
        didSet { updateShadowRadius() }
    }
    @IBInspectable public var shadowOffset: CGSize = .init(width: 0, height: 3) {
        didSet { updateShadowOffset() }
    }
  
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        updateView()
    }
}

// MARK: - Update Methods
private extension ColoredView {
    
    func updateView() {
        updateShadow()
        updateBorder()
        updateCornerRadius()
    }
    
    func updateBorder() {
        updateBorderColor()
        updateBorderWidth()
    }
    
    func updateShadow() {
        updateShadowColor()
        updateShadowOffset()
        updateShadowRadius()
        updateShadowOpacity()
    }
    
    func updateBorderColor() {
        layer.borderColor = borderColor.cgColor
    }
    
    func updateBorderWidth() {
        layer.borderWidth = borderWidth
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
    
    func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }
    
    func updateShadowOffset() {
        layer.shadowOffset = shadowOffset
    }
    
    func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }
    
    func updateShadowOpacity() {
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
