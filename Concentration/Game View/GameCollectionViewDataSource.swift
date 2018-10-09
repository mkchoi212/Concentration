//
//  GameCollectionViewDataSource.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class GameCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let level: Int
    
    lazy var colors: [UIColor] = {
        let possibleColors = UIColor.generate(count: (level * level) / 2)
        return possibleColors + possibleColors
    }()
    
    init(level: Int) {
        self.level = level
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return level * level
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setTrueColor(colors[indexPath.row])
        return cell
    }
}
