//
//  YPSwipeableStackView.swift
//  YPSwipeableStackView
//
//  Created by Zhenya Peteliev on 4/8/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import UIKit

final public class YPSwipeableStackView: UIView {
    
    private enum Settings {
        enum Inset {
            static let vertical: CGFloat = 12
            static let horizontal: CGFloat = 12
        }
        static let numberOfVisibleItems: Int = 3
    }
    
    // MARK: - Public Properties
    public weak var delegate: YPSwipeableStackViewDelegate?
    public weak var dataSource: YPSwipeableStackViewDataSource?
    
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
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public Methods
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        removeAllCardViews()

        let numberOfItems = dataSource.numberOfItems(in: self)
        remainingItemsCount = numberOfItems
        
        for index in 0..<min(numberOfItems, Settings.numberOfVisibleItems) {
            addItem(dataSource.swipeableStackView(self, forItemAt: index), at: index)
        }
        
        if let emptyView = dataSource.viewForStub(in: self) {
            embedView(emptyView)
        }
        setNeedsLayout()
    }
    
    // MARK: - Private Properties
    private var remainingItemsCount: Int = 0
    private var items: [YPSwipeableStackViewItem] = []
    private var visibleItems: [YPSwipeableStackViewItem] {
        return subviews as? [YPSwipeableStackViewItem] ?? []
    }
}

// MARK: - Private Methods
private extension YPSwipeableStackView {
    
    func removeAllCardViews() {
        visibleItems.forEach { item in item.removeFromSuperview() }
        items = []
    }
    
    func addItem(_ item: YPSwipeableStackViewItem, at index: Int) {
        items.append(item)
        insertSubview(item, at: 0)
        setFrame(for: item, at: index)
        
        // item.delegate = self
        remainingItemsCount -= 1
    }
    
    func setFrame(for itemView: YPSwipeableStackViewItem, at index: Int) {
        var itemViewFrame = bounds
        let horizontalInset = (CGFloat(index) * Settings.Inset.horizontal)
        let verticalInset = CGFloat(index) * Settings.Inset.vertical
        
        itemViewFrame.size.width -= 2 * horizontalInset
        itemViewFrame.origin.x += horizontalInset
        itemViewFrame.origin.y += verticalInset
        
        itemView.frame = itemViewFrame
    }
}
