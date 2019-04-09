//
//  AnimalProfileView.swift
//  YPSwipeableStackViewExample
//
//  Created by Zhenya Peteliev on 4/9/19.
//  Copyright © 2019 Yevhenii Peteliev. All rights reserved.
//

import UIKit
import YPSwipeableStackView

final public class AnimalProfileView: YPSwipeableStackViewItem {

    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var backgroundView: ColoredView!
    
    // MARK: - Public Properties
    public var highlightColor: UIColor = .white {
        didSet { updateHighlightColor() }
    }
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("\(AnimalProfileView.self)", owner: self, options: nil)
        embedView(contentView)
        setupView()
    }
}

// MARK: - Update Methods
private extension AnimalProfileView {
    
    func setupView() {
        setupBackground()
        updateHighlightColor()
    }
    
    func setupBackground() {
        backgroundView.borderWidth = 2
        backgroundView.cornerRadius = 15
        backgroundView.shadowRadius = 3
        backgroundView.shadowOpacity = 0.3
    }

    func updateHighlightColor() {
        backgroundView.backgroundColor = highlightColor
    }
}
