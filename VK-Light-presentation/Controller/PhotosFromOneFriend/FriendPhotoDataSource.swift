//
//  FriendPhotoDataSource.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit


class FriendPhotoDataSource: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var urlPhoto:[PhotoFriendCoreData]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlPhoto?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendPhotoCell.idCell, for: indexPath) as? FriendPhotoCell else {return UICollectionViewCell()}
        if let onePhotoCoreData = urlPhoto?[indexPath.item].urlPhotoCoreData?.first(where: {($0 as AnyObject).type == "x"}) as? UrlPhotoCoreData {
            
            cell.configure(with: onePhotoCoreData )
        }
        return cell
    }
    
}
