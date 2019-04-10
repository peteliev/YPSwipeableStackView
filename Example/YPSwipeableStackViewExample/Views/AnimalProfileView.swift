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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var professionLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var highlightView: ColoredView!
    @IBOutlet private weak var backgroundView: ColoredView!
    
    // MARK: - Public Properties
    public var name: String? = nil {
        didSet { updateName() }
    }
    public var nickname: String? = nil {
        didSet { updateNickname() }
    }
    public var profession: String? = nil {
        didSet { updateProfession() }
    }
    public var icon: UIImage? = nil  {
        didSet { updateIcon() }
    }
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
        updateProfile()
    }
}

// MARK: - Update Methods
private extension AnimalProfileView {
    
    func updateProfile() {
        updateName()
        updateNickname()
        updateIcon()
        updateHighlightColor()
    }
    
    func updateName() {
        nameLabel.text = name
    }
    
    func updateNickname() {
        nicknameLabel.text = nickname
    }
    
    func updateProfession() {
        professionLabel.text = profession
    }

    func updateIcon() {
        iconImageView.image = icon
    }
    
    func updateHighlightColor() {
        highlightView.backgroundColor = highlightColor
    }
}
