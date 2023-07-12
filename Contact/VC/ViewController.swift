//
//  ViewController.swift
//  Contact
//
//  Created by Nikolay Zhukov on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var storage: ContactStorageProtocol!
    
    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
            storage.save(contacts: contacts)
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()
    }
    
    @IBAction func showNewContactAlerrt() {
        let alertController = UIAlertController(title: "Create new contact", message: "Input name and number", preferredStyle: .alert)  //check words
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Number"
        }
        
        let createButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text else { return }
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        present(alertController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
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
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
    
    private func loadContacts() {
        contacts = storage.load()
    }
    
}

extension ViewController: UITextViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
        
