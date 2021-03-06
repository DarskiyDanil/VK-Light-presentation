//
//  MyGroupVC.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import CoreData

class MyGroupVC: UIViewController, UITableViewDelegate {
    
    let refreshControl = UIRefreshControl()
    let apiServiceRequest = APIServiceRequest()
    let allGroupDataTableView = MyGroupDataTableView()
    let groupAllFrindList = DispatchGroup()
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let textSearch = searchController.searchBar.text else {return false}
        return textSearch.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .blue
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "мои сообщества"
        navigationItem.searchController = searchController
        navigationController?.hidesBarsOnSwipe = true
        setupTableView()
        apiServiceRequest.delegate = self
        addRefreshControl()
//        groupAllFrindList.enter()
        apiServiceRequest.requestAllGroups()
//        groupAllFrindList.leave()
//        groupAllFrindList.wait()
//        groupAllFrindList.enter()
        returnGroupedCoreData()
//        groupAllFrindList.leave()
        
        DispatchQueue.main.async{
            self.addViews()
        }
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "поиск"
        searchController.searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        searchController.searchBar.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupTableView() {
           tableView.dataSource = allGroupDataTableView
           tableView.delegate = self
           tableView.register(MyGroupCell.self, forCellReuseIdentifier: MyGroupCell.idCell)
           tableView.separatorStyle = .singleLine
           tableView.separatorInset = UIEdgeInsets(top: 1, left: 25, bottom: 1, right: 25)
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
}

// MARK: - extension
extension MyGroupVC: APIServiceRequestDelegate {
    
    // получение данных через делегат
    func updateMyGroupsInterface(_: APIServiceRequest, with parsedData: (data: [AllGroupParsedData], error: Error?)) {
        DispatchQueue.main.async{
            self.activityIndicator.startAnimating()
        }
        guard let friendData = self.allGroupDataTableView.allGroups else {return}
        if !friendData.isEmpty {
            self.dellAllFriendCoreData()
        }
        if parsedData.error != nil {
            guard let error = parsedData.error else {return}
            self.showLoginError()
            print(error.localizedDescription)
        } else {
            self.saveListGroupsCoreData(friendData: parsedData.data)
            DispatchQueue.main.async{
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}

// MARK: -  CoreData
extension MyGroupVC {
    
    //  контекст CoreData
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataManager.persistentContainer.viewContext
    }
    
    //    Сохранение
    private func saveListGroupsCoreData (friendData: [AllGroupParsedData]) {
        let context = getContext()
        var attributes = [AllGroupCoreData]()
        
        for friend in friendData {
            let contextObject = AllGroupCoreData(context: context)
            contextObject.name =  friend.name
            contextObject.imageUrl = friend.imageUrl
            contextObject.id = Int64(friend.id)
            contextObject.dateDownload = Date()
            attributes.append(contextObject)
        }
        do {
            try context.save()
            self.allGroupDataTableView.allGroups = attributes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print("метод saveListGroupsCoreData не сохранил: \(error.localizedDescription)")
        }
    }
    
    //    получение сохраненных данных из CoreData
    private func returnGroupedCoreData() {
        let context = getContext()
        //        запрос
        let fetchRequest: NSFetchRequest<AllGroupCoreData> = AllGroupCoreData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateDownload", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            allGroupDataTableView.allGroups = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // удаление объектов
    private func dellAllFriendCoreData() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<AllGroupCoreData> = AllGroupCoreData.fetchRequest()
        //        получаем все объекты
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        do {
            try context.save()
            allGroupDataTableView.allGroups?.removeAll()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func showLoginError() {
        let alter = UIAlertController(title: "Ошибка сети", message: "данные пришли с ошибкой", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    
}

// MARK: - Layout

extension MyGroupVC {
    
    fileprivate func addViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.fillSuperview()
    }
    
}

// MARK: - Search
extension MyGroupVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if isFiltering && !searchText.isEmpty {
            let context = getContext()
            //        запрос
            let fetchRequest: NSFetchRequest<AllGroupCoreData> = AllGroupCoreData.fetchRequest()
            //            фильтрация
            let predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", searchText)
            fetchRequest.predicate = predicate
            
            do {
                allGroupDataTableView.allGroups = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            self.returnGroupedCoreData()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //    обновление свайпом
    fileprivate func addRefreshControl() {
        self.tableView.addSubview(refreshControl)
        refreshControl.attributedTitle = NSAttributedString(string: "обновление")
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(refreshNewsList), for: .valueChanged)
    }
    
    @objc private func refreshNewsList() {
        groupAllFrindList.enter()
        self.apiServiceRequest.requestAllGroups()
        groupAllFrindList.leave()
        groupAllFrindList.wait()
        groupAllFrindList.enter()
        refreshControl.endRefreshing()
        self.returnGroupedCoreData()
        groupAllFrindList.leave()
    }
    
    
}
