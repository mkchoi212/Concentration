//
//  UIColor+Generate.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

extension UIColor {
    static var softBlue: UIColor {
        return UIColor(red: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)
    }
    
    static func generate(count: Int) -> [UIColor] {
        return (0..<count).map { _ in
            let r = CGFloat.random(in: 0 ... 1)
            let g = CGFloat.random(in: 0 ... 1)
            let b = CGFloat.random(in: 0 ... 1)
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }
}
