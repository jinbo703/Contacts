//
//  ViewController.swift
//  Contacts
//
//  Created by John Nik on 11/25/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId"
    
    var showIndexPaths = false
    
    var twoDemensionalArray = [
        
        ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Mary", "Clare"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["Carl", "Cristina", "Camel"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["Den", "Darl"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["Patrick", "Patty"].map{ Contact(name: $0, hasFavorited: false) })
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    }
    
    func handleFavorite(cell: UITableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let contact = twoDemensionalArray[indexPath.section].names[indexPath.row]
        
        let hasFavorited = contact.hasFavorited
        twoDemensionalArray[indexPath.section].names[indexPath.row].hasFavorited = !hasFavorited
        
//        tableView.reloadRows(at: [indexPath], with: .fade)
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
        
    }
    
    @objc private func handleShowIndexPath() {
        
        var indexPathToReload = [IndexPath]()
        
        for section in twoDemensionalArray.indices {
            
            for row in twoDemensionalArray[section].names.indices {
                
                let indexPath = IndexPath(row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        
        showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
        
    }

    
    @objc private func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        
        for row in twoDemensionalArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDemensionalArray[section].isExpanded
        twoDemensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDemensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !twoDemensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDemensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
        
//        let label = UILabel()
//        label.text = "Header"
//        label.backgroundColor = .lightGray
//        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        
        cell.viewController = self
        
        let contact = twoDemensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = contact.name
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        
        if showIndexPaths {
            cell.textLabel?.text = "\(contact)   Section: \(indexPath.section)  Row: \(indexPath.row)"
        }
        
        return cell
    }

}



















