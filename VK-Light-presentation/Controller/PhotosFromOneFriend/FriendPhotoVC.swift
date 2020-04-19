//
//  FriendPhotoVC.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import CoreData


class FriendPhotoVC: UIViewController, UICollectionViewDelegate {
    
    
    let apiServiceRequest = APIServiceRequest()
    let friendPhotoDataSource = FriendPhotoDataSource()
    let groupAllFrindList = DispatchGroup()
    
    let collectionView: UICollectionView = {
        var collectionV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        return collectionV
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = #colorLiteral(red: 0.5544524193, green: 0.9462211728, blue: 0.01620966755, alpha: 1)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = friendPhotoDataSource
        collectionView.delegate = self
        collectionView.register(FriendPhotoCell.self, forCellWithReuseIdentifier: FriendPhotoCell.idCell)
        
        groupAllFrindList.enter()
        requestPhotoFriendsSession()
        groupAllFrindList.leave()
        groupAllFrindList.wait()
        groupAllFrindList.enter()
        returnPhotoCoreData()
        groupAllFrindList.leave()
        
        DispatchQueue.main.async{
            self.layoutView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let presentPhotoVC = PresentPhotoVC()
        presentPhotoVC.photoURL = friendPhotoDataSource.urlPhoto?[indexPath.item].urlPhotoCoreData?.lastObject as? UrlPhotoCoreData
        self.collectionView.reloadData()
        present(presentPhotoVC, animated: true, completion: nil)
    }
    
    private func showLoginError() {
        let alter = UIAlertController(title: "Ошибка сети", message: "данные неполучены, пните разработчика", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    
}


// MARK: -  CoreData Friend Photo VC
extension FriendPhotoVC {
    
    //  контекст CoreData
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataManager.persistentContainer.viewContext
    }
    
    //    получение сохраненных данных из CoreData
    private func returnPhotoCoreData() {
        //        получаем сохраненные сущности
        let context = getContext()
        //        запрос
        let fetchRequest: NSFetchRequest<PhotoFriendCoreData> = PhotoFriendCoreData.fetchRequest()
        do {
            friendPhotoDataSource.urlPhoto = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //        запрос списка друзей
    private func requestPhotoFriendsSession() {
        self.activityIndicator.startAnimating()
        self.apiServiceRequest.requestPhotosOneFriend(ownerId: SessionSingletone.shared.ownerIdSelectedPerson) {[unowned self] (friends, error) in
            guard let friendsRequest = friends else {return}
            guard let friendData = self.friendPhotoDataSource.urlPhoto else {return}
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
    
    //    Сохранение
    private func saveListFriendCoreData (friendData: [PhotoFriendParsedData]) {
        //                print(friendData)
        let context = getContext()                                          //1
        var photoFriend = [PhotoFriendCoreData]()                           //2
        
        for first in friendData {                                                             //3 --- {
            let nextPhotoFriendCoreData = PhotoFriendCoreData(context: context)                              //4
            let attributes = nextPhotoFriendCoreData.urlPhotoCoreData?.mutableCopy() as? NSMutableOrderedSet //5
            nextPhotoFriendCoreData.id = Int64(first.id)                                                 //6
            nextPhotoFriendCoreData.ownerId = Int64(first.ownerId)                                       //7
            
            for friend in first.sizes {                                              // 8 -- {
                let contextObject = UrlPhotoCoreData(context: context)      //9
                //                if friend.height < 500 && friend.height > 300 {
                contextObject.url = friend.url                          //10
                contextObject.height = Int64(friend.height)             //11
                contextObject.width = Int64(friend.width)               //12
                
                attributes?.add(contextObject)                          //13
                //                }
            }                                                                       // 14 -- }
            nextPhotoFriendCoreData.urlPhotoCoreData = attributes             //15
            photoFriend.append(nextPhotoFriendCoreData)                       //16
        }                                                                                       //17 --- }
        do {
            try context.save()
            self.friendPhotoDataSource.urlPhoto = photoFriend
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch let error as NSError {
            print("метод saveSectionPersonTitleName не сохранил: \(error.localizedDescription)")
        }
    }
    
    private func dellAllFriendCoreData() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<PhotoFriendCoreData> = PhotoFriendCoreData.fetchRequest()
        //        получаем все объекты
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        do {
            try context.save()
            friendPhotoDataSource.urlPhoto?.removeAll()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}


// MARK: - Layout
extension FriendPhotoVC: UICollectionViewDelegateFlowLayout {
    //    размер ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCountInRow: CGFloat = 3
        let fillingWidth: CGFloat = 8 * (itemsCountInRow + 1)
        let availableWidthForItems: CGFloat = collectionView.frame.width - fillingWidth
        let widthForItem: CGFloat = availableWidthForItems / itemsCountInRow
        return CGSize(width: widthForItem, height: widthForItem)
    }
    //    отступы ячеек от краёв
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    //    минимальный межстрочный интервал
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    //    минимальный строчный интервал между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    private func layoutView() {
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
}
