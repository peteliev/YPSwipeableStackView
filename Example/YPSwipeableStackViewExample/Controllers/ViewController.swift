//
//  ViewController.swift
//  YPSwipeableStackViewExample
//
//  Created by Zhenya Peteliev on 4/8/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import UIKit
import YPSwipeableStackView

final public class ViewController: UIViewController {
    
    private enum Settings {
        static let itemsCount: Int = 7
    }
    
    @IBOutlet private weak var swipeableStackView: YPSwipeableStackView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwipeableStackView()
        swipeableStackView.reloadData()
    }
}

// MARK: - YPSwipeableStackViewDataSource
extension ViewController: YPSwipeableStackViewDataSource {
    
    public func numberOfItems(in swipeableStackView: YPSwipeableStackView) -> Int {
        return Settings.itemsCount
    }
    
    public func swipeableStackView(_ swipeableStackView: YPSwipeableStackView, forItemAt index: Int) -> YPSwipeableStackViewItem {
        let item: AnimalProfileView = AnimalProfileView()
        item.highlightColor = .white
        
        return item
    }
}

// MARK: - YPSwipeableStackViewDelegate
extension ViewController: YPSwipeableStackViewDelegate {
    
    public func swipeableStackView(_ swipeableStackView: YPSwipeableStackView, didSelectItemAt index: Int) {
        print("didSelectItemAt: \(index)")
    }
}

// MARK: - Private Methods
private extension ViewController {
    
    func setupSwipeableStackView() {
        swipeableStackView.delegate = self
        swipeableStackView.dataSource = self
    }
}
