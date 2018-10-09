//
//  CardCollectionViewCell.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardCollectionViewCell"
    
    var flipped = false
    var trueColor = UIColor.black
    var matched = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
        backgroundColor = .softBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTrueColor(_ color: UIColor) {
        trueColor = color
    }
    
    func flip(callback: @escaping () -> ()) {
        UIView.transition(with: contentView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            if self.flipped {
                self.backgroundColor = .softBlue
            } else {
                self.backgroundColor = self.trueColor
            }
            self.flipped = !(self.flipped)
        }, completion: { _ in
            callback()
        })
    }
}
