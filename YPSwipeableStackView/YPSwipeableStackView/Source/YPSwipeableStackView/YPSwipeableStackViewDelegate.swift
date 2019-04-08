//
//  YPSwipeableStackViewDelegate.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/8/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import Foundation

public protocol YPSwipeableStackViewDelegate: class {
    
    func swipeableStackView(_ swipeableStackView: YPSwipeableStackView, didSelectItemAt index: Int)
}

// MARK: - Default Implementation
public extension YPSwipeableStackViewDelegate {
    
    func swipeableStackView(_ swipeableStackView: YPSwipeableStackView, didSelectItemAt index: Int) {
        /* empty */
    }
}
