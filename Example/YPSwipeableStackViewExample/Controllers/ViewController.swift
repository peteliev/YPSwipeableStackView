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

    // MARK: - Outlets
    @IBOutlet private weak var swipeableStackView: YPSwipeableStackView!
    
    let animals: [AnimalProfile] = [
        AnimalProfile(name: "Brenda Kemmer", nickname: "@b.kemmer", profession: "iOS Engineer", icon: #imageLiteral(resourceName: "chick"), highlightColor: .init(hex: 0x006400)),
        AnimalProfile(name: "Marcia Monroe", nickname: "@monroe", profession: "Freelancer", icon: #imageLiteral(resourceName: "bull"), highlightColor: .init(hex: 0xF0E68C)),
        AnimalProfile(name: "Thomas Rutherford", nickname: "@t_rutherford", profession: "Designer", icon: #imageLiteral(resourceName: "crab"), highlightColor: .init(hex: 0xFFFFE0)),
        AnimalProfile(name: "Willie Nelson", nickname: "@wnelson", profession: "Teacher", icon: #imageLiteral(resourceName: "fox"), highlightColor: .init(hex: 0xFFF8DC)),
        AnimalProfile(name: "Nelson Fuller", nickname: "@fuller", profession: "Constructor", icon: #imageLiteral(resourceName: "hedgehog"), highlightColor: .init(hex: 0xF5F5DC)),
        AnimalProfile(name: "Kevin Holmes", nickname: "@k.holmes", profession: "Scientist", icon: #imageLiteral(resourceName: "hippopotamus"), highlightColor: .init(hex: 0x5F9EA0)),
        AnimalProfile(name: "Shirley Dixon", nickname: "@dixon", profession: "Administrator", icon: #imageLiteral(resourceName: "koala"), highlightColor: .init(hex: 0x6495ED)),
        AnimalProfile(name: "Ronnie Leib", nickname: "@leib", profession: "Manager", icon: #imageLiteral(resourceName: "lemur"), highlightColor: .init(hex: 0x808000)),
        AnimalProfile(name: "Ronnie Rivers", nickname: "@rrivers", profession: "Director", icon: #imageLiteral(resourceName: "pig"), highlightColor: .init(hex: 0xFFF5EE)),
        AnimalProfile(name: "Anne Seigler", nickname: "@aseigler", profession: "Auditor", icon: #imageLiteral(resourceName: "tiger"), highlightColor: .init(hex: 0x5F9EA0)),
        AnimalProfile(name: "Seigler Wilson", nickname: "@wilson", profession: "Artist", icon: #imageLiteral(resourceName: "whale"), highlightColor: .init(hex: 0xFFF8DC)),
        AnimalProfile(name: "Wilson Christensen", nickname: "@christensen", profession: "Singer", icon: #imageLiteral(resourceName: "zebra"), highlightColor: .init(hex: 0xDB7093)),
    ]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeableStackView()
        swipeableStackView.reloadData()
    }
}

// MARK: - YPSwipeableStackViewDataSource
extension ViewController: YPSwipeableStackViewDataSource {
    
    public func numberOfItems(in swipeableStackView: YPSwipeableStackView) -> Int {
        return animals.count
    }
    
    public func swipeableStackView(_ swipeableStackView: YPSwipeableStackView, forItemAt index: Int) -> YPSwipeableStackViewItem {
        let profileViewItem = AnimalProfileView()
        let animal = animals[index]

        profileViewItem.name = animal.name
        profileViewItem.nickname = animal.nickname
        profileViewItem.profession = animal.profession
        profileViewItem.icon = animal.icon
        profileViewItem.highlightColor = animal.highlightColor
        
        return profileViewItem
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
