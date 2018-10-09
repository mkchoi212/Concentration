//
//  HistoryTableViewController.swift
//  Concentration
//
//  Created by Mike Choi on 10/9/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    lazy var startButton = {
        return UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(askDifficulty))
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var difficultyAlert: UIAlertController = {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 250)
        vc.view.addSubview(pickerView)
        
        let alert = UIAlertController(title: "Select difficulty", message: "(Number of rows)", preferredStyle: .alert)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: displayGame))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }()

    var history = History.all
    let cellIdentifier = "HISTORY_CELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        navigationItem.rightBarButtonItem = startButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        history = History.all
        tableView.reloadData()
    }
    
    @objc func askDifficulty() {
        present(difficultyAlert, animated: true, completion: nil)
    }
    
    @objc func displayGame(_ sender: Any?) {
        let difficulty = (pickerView.selectedRow(inComponent: 0) + 1) * 2
        let gameViewController = GameCollectionViewController(level: difficulty)
        let targetNC = UINavigationController(rootViewController: gameViewController)
        present(targetNC, animated: true, completion: nil)
    }
}

extension HistoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default , reuseIdentifier: cellIdentifier)
        }
        
        // TODO make custom UITableViewCell with more defined constraints
        cell.textLabel?.text = String("\(indexPath.row + 1). \t \(history[indexPath.row]) moves")
        return cell
    }
}

extension HistoryTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String((row + 1) * 2)
    }
}
