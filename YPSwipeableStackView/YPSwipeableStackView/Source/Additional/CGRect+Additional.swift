//
//  CGRect+Additional.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/9/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import Foundation

public typealias CGLine = (start: CGPoint, end: CGPoint)

public extension CGRect {
    
    var topLine: CGLine {
        return (SwipeDirection.topLeft.point, SwipeDirection.topRight.point)
    }
    var leftLine: CGLine {
        return (SwipeDirection.topLeft.point, SwipeDirection.bottomLeft.point)
    }
    var bottomLine: CGLine {
        return (SwipeDirection.bottomLeft.point, SwipeDirection.bottomRight.point)
    }
    var rightLine: CGLine {
        return (SwipeDirection.topRight.point, SwipeDirection.bottomRight.point)
    }
    
    var perimeterLines: [CGLine] {
        return [topLine, leftLine, bottomLine, rightLine]
    }
}
