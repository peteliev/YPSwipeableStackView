//
//  YPSwipeableStackViewItemDelegate.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/9/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import Foundation

public protocol YPSwipeableStackViewItemDelegate: class {
    
    func didSelect(item: YPSwipeableStackViewItem)
    func didBeginSwipe(onItem item: YPSwipeableStackViewItem)
    func didEndSwipe(onItem item: YPSwipeableStackViewItem)
}

// MARK: - Default Implementation
public extension YPSwipeableStackViewItemDelegate {
    
    func didTap(item: YPSwipeableStackViewItem) {
        /* empty */
    }
    
    func didBeginSwipe(onItem item: YPSwipeableStackViewItem) {
        /* empty */
    }
    
    func didEndSwipe(onItem item: YPSwipeableStackViewItem) {
        /* empty */
    }
}
