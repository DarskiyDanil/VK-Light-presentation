//
//  AllFriendDataTableView.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class AllFriendDataTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var allFriend: [AllFriendCoreData]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allFriend?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllFriendCell.idCell, for: indexPath) as! AllFriendCell
        
        let friendOne = allFriend?[indexPath.row]
        guard let friend = friendOne else {return cell}
        
        cell.configure(with: friend)
        
        return cell
    }
    
}
