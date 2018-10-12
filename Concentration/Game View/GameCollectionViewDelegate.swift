//
//  GameCollectionViewDelegate.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class GameCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var manager: GameManagerDelegate?
    var selected: [IndexPath] = []
    var score = 0
    var numMoves = 0
    
    let level: Int
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    init(level: Int) {
        self.level = level
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else {
            return
        }
        
        if cell.matched {
            return
        }
        
        numMoves += 1
        selected.append(indexPath)
        
        cell.flip(callback: {
            if self.selected.count == 2 {
                let selectedCells = self.selected.map{ collectionView.cellForItem(at: $0) as? CardCollectionViewCell }
                let selectedColors = Set(selectedCells.map{ $0?.trueColor })

                if selectedColors.count == 1 {
                    _ = selectedCells.map{ $0?.matched = true }
                    self.score += 1
                } else {
                    _ = selectedCells.map{ $0?.flip(callback: {}) }
                }
                
                self.selected = []
                self.manager?.update(score: self.score)
            }
        })
    }
}

extension GameCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sidePadding = sectionInsets.left * CGFloat(level + 1)
        let availableWidth = collectionView.frame.width - sidePadding
        let widthPerItem = availableWidth / CGFloat(level)
        
        let topPadding = sectionInsets.top * CGFloat(level + 1)
        let availableHeight = collectionView.frame.height - topPadding
        let heightPerItem = availableHeight / (CGFloat(level) * 1.2)
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
