//
//  AllFriendVC.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
import CoreData
import UIKit

class AllFriendVC: UIViewController, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let refreshControl = UIRefreshControl()
    let apiServiceRequest = APIServiceRequest()
    var allFriendDataTableView = AllFriendDataTableView()
    let groupAllFrindList = DispatchGroup()
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let textSearch = searchController.searchBar.text else {return false}
        return textSearch.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .blue
        return activityIndicator
    }()
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "мои друзья"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.searchController = searchController
        tableView.dataSource = allFriendDataTableView
        tableView.delegate = self
        tableView.register(AllFriendCell.self, forCellReuseIdentifier: AllFriendCell.idCell)
        addRefreshControl()
        groupAllFrindList.enter()
        self.requestMyFriendsSession()
        groupAllFrindList.leave()
        groupAllFrindList.wait()
        groupAllFrindList.enter()
        self.returnFriendCoreData()
        groupAllFrindList.leave()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "поиск"
    }
    
    override func viewDidLayoutSubviews() {
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let friend = allFriendDataTableView.allFriend?[indexPath.row] else {return}
            let idFriend = String(friend.id)
            SessionSingletone.shared.ownerIdSelectedPerson = idFriend
            navigationController?.pushViewController(FriendPhotoVC(), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    //    запрос списка друзей
    private func requestMyFriendsSession() {
        self.activityIndicator.startAnimating()
        self.apiServiceRequest.requestAllFriends {[unowned self] (friends, error) in
            
            guard let friendsRequest = friends else {return}
            guard let friendData = self.allFriendDataTableView.allFriend else {return}
            if !friendData.isEmpty {
                self.dellAllFriendCoreData()
            }
            if error != nil {
                self.showLoginError()
            }
            self.saveListFriendCoreData(friendData: friendsRequest)
            self.activityIndicator.stopAnimating()
        }
    }
    
    //  контекст CoreData
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataManager.persistentContainer.viewContext
    }
    
    //    Сохранение
    private func saveListFriendCoreData (friendData: [AllFriendParsedData]) {
        let context = getContext()
        var attributes = [AllFriendCoreData]()
        
        for friend in friendData {
            let contextObject = AllFriendCoreData(context: context)
            contextObject.firstName =  friend.firstName
            contextObject.lastName = friend.lastName
            contextObject.imageUrl = friend.imageUrl
            contextObject.id = Int64(friend.id)
            contextObject.dateDownload = Date()
            attributes.append(contextObject)
        }
        do {
            try context.save()
            self.allFriendDataTableView.allFriend = attributes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print("метод saveSectionPersonTitleName не сохранил: \(error.localizedDescription)")
        }
    }
    
    //    получение сохраненных данных из CoreData
    private func returnFriendCoreData() {
        //        получаем сохраненные сущности
        let context = getContext()
        //        запрос
        let fetchRequest: NSFetchRequest<AllFriendCoreData> = AllFriendCoreData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateDownload", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            allFriendDataTableView.allFriend = try context.fetch(fetchRequest)
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
        let fetchRequest: NSFetchRequest<AllFriendCoreData> = AllFriendCoreData.fetchRequest()
        //        получаем все объекты
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        do {
            try context.save()
            allFriendDataTableView.allFriend?.removeAll()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func showLoginError() {
        let alter = UIAlertController(title: "Ошибка сети", message: "данных нет, смотрим код", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    
}


// MARK: - Search
extension AllFriendVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if isFiltering && !searchText.isEmpty {
            let context = getContext()
            //        запрос
            let fetchRequest: NSFetchRequest<AllFriendCoreData> = AllFriendCoreData.fetchRequest()
            //            фильтрация
            let predicate = NSPredicate(format: "firstName BEGINSWITH[cd] %@", searchText)
            fetchRequest.predicate = predicate
            
            do {
                allFriendDataTableView.allFriend = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            self.returnFriendCoreData()
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
//        activityIndicator.isHidden = true
        self.requestMyFriendsSession()
        groupAllFrindList.leave()
        groupAllFrindList.wait()
        groupAllFrindList.enter()
        refreshControl.endRefreshing()
        self.returnFriendCoreData()
//        activityIndicator.isHidden = false
        groupAllFrindList.leave()
    }
    
    
}


extension AllFriendVC {
    
    fileprivate func addViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}



