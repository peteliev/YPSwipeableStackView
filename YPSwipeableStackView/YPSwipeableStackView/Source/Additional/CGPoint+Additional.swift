//
//  CGPoint+Additional.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/9/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import Foundation

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
public func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}
public func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

public func + (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x + scalar, y: point.y + scalar)
}
public func += (point: inout CGPoint, scalar: CGFloat) {
    point = point + scalar
}

public func - (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x - scalar, y: point.y - scalar)
}
public func -= (point: inout CGPoint, scalar: CGFloat) {
    point = point - scalar
}

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
public func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}
public func /= ( left: inout CGPoint, right: CGPoint) {
    left = left / right
}

public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
public func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}


public extension CGPoint {
    
    var modulo: CGFloat {
        return sqrt(self.x*self.x + self.y*self.y)
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    func normalizedDistance(for size: CGSize) -> CGPoint {
        // multiplies by 2 because coordinate system is (-1,1)
        let x = 2 * (self.x / size.width)
        let y = 2 * (self.y / size.height)
        return CGPoint(x: x, y: y)
    }
    
    func scalarProjectionPoint(with point: CGPoint) -> CGPoint {
        let r = scalarProjection(with: point) / point.modulo
        return CGPoint(x: point.x * r, y: point.y * r)
    }
    
    func scalarProjection(with point: CGPoint) -> CGFloat {
        return dotProduct(with: point) / point.modulo
    }
    
    func dotProduct(with point: CGPoint) -> CGFloat {
        return (self.x * point.x) + (self.y * point.y)
    }
    
    func screenPointForSize(_ screenSize: CGSize) -> CGPoint {
        let x = 0.5 * (1 + self.x) * screenSize.width
        let y = 0.5 * (1 + self.y) * screenSize.height
        return CGPoint(x: x, y: y)
    }
    
    static func intersectionBetweenLines(_ line1: CGLine, line2: CGLine) -> CGPoint? {
        let (p1,p2) = line1
        let (p3,p4) = line2
        
        var d = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y)
        var ua = (p4.x - p3.x) * (p1.y - p4.y) - (p4.y - p3.y) * (p1.x - p3.x)
        var ub = (p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x)
        if (d < 0) {
            ua = -ua; ub = -ub; d = -d
        }
        
        if d != 0 {
            return CGPoint(x: p1.x + ua / d * (p2.x - p1.x), y: p1.y + ua / d * (p2.y - p1.y))
        }
        return nil
    }
}
