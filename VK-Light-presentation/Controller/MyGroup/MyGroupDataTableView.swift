//
//  MyGroupDataTableView.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class MyGroupDataTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var allGroups: [AllGroupCoreData]?
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allGroups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupCell.idCell, for: indexPath) as! MyGroupCell
        
        //        let friendOne = allGroups?[indexPath.row]
        //        guard let friend = friendOne else {return cell}
        
        if let allGroups = self.allGroups?[indexPath.row] {
            cell.configure(with: allGroups)
        }
        
        return cell
    }
    
}
