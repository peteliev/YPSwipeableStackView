//
//  SwipeDirection.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/9/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import Foundation

public enum SwipeDirection {
    
    enum HorizontalPosition: CGFloat {
        case left = -1
        case middle = 0
        case right = 1
    }
    enum VerticalPosition: CGFloat {
        case top = -1
        case middle = 0
        case bottom = 1
    }
    
    case left
    case right
    case up
    case down
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    static var allDirections: [SwipeDirection] {
        return [.left, .right, .up, .down, .topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    static var boundsRect: CGRect {
        let width = HorizontalPosition.right.rawValue - HorizontalPosition.left.rawValue
        let height = VerticalPosition.bottom.rawValue - VerticalPosition.top.rawValue
        return CGRect(x: HorizontalPosition.left.rawValue, y: VerticalPosition.top.rawValue, width: width, height: height)
    }
    
    var horizontalPosition: HorizontalPosition {
        switch self {
        case .left: return .left
        case .right: return .right
        case .up: return .middle
        case .down: return .middle
        case .topLeft: return .left
        case .topRight: return .right
        case .bottomLeft: return .left
        case .bottomRight: return .right
        }
    }
    var verticalPosition: VerticalPosition {
        switch self {
        case .left: return .middle
        case .right: return .middle
        case .up: return .top
        case .down: return .bottom
        case .topLeft: return .top
        case .topRight: return .top
        case .bottomLeft: return .bottom
        case .bottomRight: return .bottom
        }
    }
    var point: CGPoint {
        return CGPoint(x: horizontalPosition.rawValue, y: verticalPosition.rawValue)
    }
}
