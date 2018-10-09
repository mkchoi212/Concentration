//
//  History.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import Foundation
import UIKit

struct History {
    static let key = "ALL_SCORES"
    
    static var all: [Int] {
        guard let scores = UserDefaults.standard.array(forKey: key) as? [Int] else {
            return []
        }
        return scores.sorted()
    }
    
    static func save(score: Int) {
        var scores = History.all
        scores.append(score)
        UserDefaults.standard.set(scores, forKey: key)
    }
    
    static func save(gameState: [(UIColor, Bool)]) {
        
    }
}
