//
//  YPSwipeableStackViewDataSource.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/8/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import Foundation

public protocol YPSwipeableStackViewDataSource: class {
    
    func numberOfItems(in swipeableStackView: YPSwipeableStackView) -> Int
    func swipeableStackView(_ swipeableStackView: YPSwipeableStackView, forItemAt index: Int) -> YPSwipeableStackViewItem
}
