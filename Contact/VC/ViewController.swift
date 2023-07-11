//
//  ViewController.swift
//  Contact
//
//  Created by Nikolay Zhukov on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var contacts: [ContactProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "myCell") {
            print("use old row with index with index \(indexPath.row)")
            cell = reuseCell
        } else {
            print("create new cell for row with index \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "row with index \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
    
    
}

