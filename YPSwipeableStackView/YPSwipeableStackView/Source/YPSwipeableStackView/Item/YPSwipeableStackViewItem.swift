//
//  YPSwipeableStackViewItem.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/8/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import UIKit

final public class YPSwipeableStackViewItem: UIView {
    
    private enum Settings {
        enum DragAnimation {
            static let maximumRotation: CGFloat = 1.0
            static let rotationAngle: CGFloat = .pi / 10
            static let animationDirectionY: CGFloat = 1.0
            static let swipePercentageMargin: CGFloat = 0.6
        }
        enum SwipeAnimation {
            static let finalizeSwipeActionAnimationDuration: TimeInterval = 0.8
        }
        enum ResetAnimation {
            static let cardViewResetAnimationDuration: TimeInterval = 0.2
            static let cardViewResetAnimationSpringSpeed: CGFloat = 20.0
            static let cardViewResetAnimationSpringBounciness: CGFloat = 10.0
        }
    }
    
    // MARK: - Public Properties
    public weak var delegate: YPSwipeableStackViewItemDelegate?
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupTapGestureRecognizer()
        setupPanGestureRecognizer()
    }
    
    // MARK: - Private Properties
    private var panGestureTranslation: CGPoint = .zero
}

// MARK: - Gestures
private extension YPSwipeableStackViewItem {
    
    func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func tapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        
    }
    
    @objc func panGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        panGestureTranslation = gestureRecognizer.translation(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            let initialTouchPoint = gestureRecognizer.location(in: self)
            let newAnchorPoint = CGPoint(x: initialTouchPoint.x / bounds.width, y: initialTouchPoint.y / bounds.height)
            let oldPosition = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
            let newPosition = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
            layer.anchorPoint = newAnchorPoint
            layer.position = CGPoint(x: layer.position.x - oldPosition.x + newPosition.x, y: layer.position.y - oldPosition.y + newPosition.y)
            
            removeAnimations()
            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = true
            
            delegate?.didBeginSwipe(onItem: self)
        case .changed:
            let rotationStrength = min(panGestureTranslation.x / frame.width, Settings.DragAnimation.maximumRotation)
            let rotationAngle = Settings.DragAnimation.animationDirectionY * Settings.DragAnimation.rotationAngle * rotationStrength
            
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
            transform = CATransform3DTranslate(transform, panGestureTranslation.x, panGestureTranslation.y, 0)
            layer.transform = transform
        case .ended:
            endedPanAnimation()
            layer.shouldRasterize = false
        default:
            resetItemPosition()
            layer.shouldRasterize = false
        }
    }
}

// MARK: - Helper Methods
private extension YPSwipeableStackViewItem {
    
    private var dragDirection: SwipeDirection? {
        let normalizedDragPoint = panGestureTranslation.normalizedDistanceForSize(bounds.size)
        return SwipeDirection.allDirections.reduce((distance: CGFloat.infinity, direction: nil), { closest, direction -> (CGFloat, SwipeDirection?) in
            let distance = direction.point.distanceTo(normalizedDragPoint)
            if distance < closest.distance {
                return (distance, direction)
            }
            return closest
        }).direction
    }
    
    private var dragPercentage: CGFloat {
        guard let dragDirection = dragDirection else { return 0.0 }
        
        let normalizedDragPoint = panGestureTranslation.normalizedDistanceForSize(frame.size)
        let swipePoint = normalizedDragPoint.scalarProjectionPointWith(dragDirection.point)
        let rect = SwipeDirection.boundsRect
        
        if !rect.contains(swipePoint) {
            return 1.0
        } else {
            let centerDistance = swipePoint.distanceTo(.zero)
            let targetLine = (swipePoint, CGPoint.zero)
            return rect.perimeterLines
                .compactMap { CGPoint.intersectionBetweenLines(targetLine, line2: $0) }
                .map { centerDistance / $0.distanceTo(.zero) }
                .min() ?? 0.0
        }
    }
    
    func endedPanAnimation() {
        if let dragDirection = dragDirection, dragPercentage >= Settings.DragAnimation.swipePercentageMargin {
            let translationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerTranslationXY)
            translationAnimation?.duration = SwipeableView.finalizeSwipeActionAnimationDuration
            translationAnimation?.fromValue = NSValue(cgPoint: POPLayerGetTranslationXY(layer))
            translationAnimation?.toValue = NSValue(cgPoint: animationPointForDirection(dragDirection))
            layer.pop_add(translationAnimation, forKey: "swipeTranslationAnimation")
            delegate?.didEndSwipe(onItem: self)
        } else {
            resetItemPosition()
        }
    }
    
    func animationPointForDirection(_ direction: SwipeDirection) -> CGPoint {
        let point = direction.point
        let animatePoint = CGPoint(x: point.x * 4, y: point.y * 4)
        return animatePoint.screenPointForSize(UIScreen.main.bounds.size)
    }
    
    private func resetItemPosition() {
        removeAnimations()
        
        // Reset Translation
        let resetPositionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationXY)
        resetPositionAnimation?.fromValue = NSValue(cgPoint:POPLayerGetTranslationXY(layer))
        resetPositionAnimation?.toValue = NSValue(cgPoint: CGPoint.zero)
        resetPositionAnimation?.springBounciness = Settings.ResetAnimation.cardViewResetAnimationSpringBounciness
        resetPositionAnimation?.springSpeed = Settings.ResetAnimation.cardViewResetAnimationSpringSpeed
        resetPositionAnimation?.completionBlock = { _, _ in
            self.layer.transform = CATransform3DIdentity
        }
        layer.pop_add(resetPositionAnimation, forKey: "resetPositionAnimation")

        // Reset Rotation
        let resetRotationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        resetRotationAnimation?.fromValue = POPLayerGetRotationZ(layer)
        resetRotationAnimation?.toValue = CGFloat(0.0)
        resetRotationAnimation?.duration = Settings.ResetAnimation.cardViewResetAnimationDuration
        layer.pop_add(resetRotationAnimation, forKey: "resetRotationAnimation")
    }
    
    func removeAnimations() {
        layer.removeAllAnimations()
    }
}
