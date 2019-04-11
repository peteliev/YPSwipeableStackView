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
    }
    
    // MARK: - Private Properties
    private var remainingItemsCount: Int = 0
    private var items: [YPSwipeableStackViewItem] = []
    private var visibleItems: [YPSwipeableStackViewItem] {
        return subviews as? [YPSwipeableStackViewItem] ?? []
    }
}

// MARK: - Private Methods
extension YPSwipeableStackView: YPSwipeableStackViewItemDelegate {
    
    public func didSelect(item: YPSwipeableStackViewItem) {
        guard let itemIndex = items.firstIndex(of: item) else { return }
        delegate?.swipeableStackView(self, didSelectItemAt: itemIndex)
    }
    
    public func didEndSwipe(onItem item: YPSwipeableStackViewItem) {
        guard let dataSource = dataSource else { return }
        item.removeFromSuperview()
        
        guard remainingItemsCount > 0 else { return }
        let newIndex = dataSource.numberOfItems(in: self) - remainingItemsCount
        addItem(dataSource.swipeableStackView(self, forItemAt: newIndex), at: Settings.numberOfVisibleItems - 1)
        
        for (itemIndex, item) in visibleItems.reversed().enumerated() {
            UIView.animate(withDuration: 0.2, animations: {
                self.setFrame(for: item, at: itemIndex)
                self.layoutIfNeeded()
            })
        }
    }
}

// MARK: - Private Methods
private extension YPSwipeableStackView {
    
    func removeAllCardViews() {
        visibleItems.forEach { $0.removeFromSuperview() }
        items = []
    }
    
    func addItem(_ item: YPSwipeableStackViewItem, at index: Int) {
        item.delegate = self
        remainingItemsCount -= 1
        
        items.append(item)
        insertSubview(item, at: 0)
        setFrame(for: item, at: index)
    }
    
    func setFrame(for itemView: YPSwipeableStackViewItem, at index: Int) {
        var itemViewFrame = bounds
        let verticalInset = CGFloat(index) * Settings.Inset.vertical
        let horizontalInset = CGFloat(index) * Settings.Inset.horizontal
        
        itemViewFrame.size.width -= 2 * horizontalInset
        itemViewFrame.origin.x += horizontalInset
        itemViewFrame.origin.y += verticalInset
        
        itemView.frame = itemViewFrame
    }
}
