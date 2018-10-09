//
//  GameCollectionViewController.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

protocol GameManagerDelegate {
    func update(score: Int)
}

class GameCollectionViewController: UICollectionViewController {
    let level: Int
    
    lazy var customDataSource: GameCollectionViewDataSource = {
        return GameCollectionViewDataSource(level: level)
    }()
    
    lazy var customDelegate: GameCollectionViewDelegate = {
        let delegate = GameCollectionViewDelegate(level: level)
        delegate.manager = self
        return delegate
    }()
    
    lazy var quitButton = {
        return UIBarButtonItem(title: "Quit", style: .done, target: self, action: #selector(displayConfirmationAlert))
    }()
    
    lazy var confirmationAlert: UIAlertController = {
        let alert = UIAlertController(title: "Save state?", message: "Save state to start from where you left off later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: saveState))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: quitGame))
        return alert
    }()
    
    init(level: Int, gameState: [(UIColor, Bool)]?) {
        self.level = level
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        if let savedState = gameState {
            customDataSource.colors = savedState.map{ $0.0 }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = quitButton
            
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = customDataSource
        collectionView.delegate = customDelegate
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        
        title = "Score: 0"
    }
    
    @objc func displayConfirmationAlert() {
        present(confirmationAlert, animated: true, completion: nil)
    }
    
    @objc func saveState(_ sender: Any?) {
        History.save(gameState: gameState())
        quitGame(nil)
    }
    
    @objc func quitGame(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}

extension GameCollectionViewController: GameManagerDelegate {
    func update(score: Int) {
        title = "Score: \(score)"
        
        if score == level {
            History.save(score: customDelegate.numMoves)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func gameState() -> [(UIColor, Bool)] {
        let numCells = collectionView.numberOfItems(inSection: 0)
        let cellStatus = (0 ..< numCells).map { (row) -> (Bool) in
            let cell = collectionView.cellForItem(at: IndexPath(row: row, section: 0)) as! CardCollectionViewCell
            return cell.flipped
        }

        return Array(zip(customDataSource.colors, cellStatus))
    }
    
    func sendToServer() {
        let state = gameState()
        /*
        MyCustomAPI.send(data: state, completion: { err in
            // Error handling code goes here :D
        })
        */
    }
}
