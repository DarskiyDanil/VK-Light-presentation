//
//  FriendPhotoDataSource.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit


class FriendPhotoDataSource: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var urlPhoto:[PhotoFriendCoreData]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlPhoto?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendPhotoCell.idCell, for: indexPath) as? FriendPhotoCell else {return UICollectionViewCell()}
        if let OnePhotoCoreData = urlPhoto?[indexPath.item].urlPhotoCoreData?.lastObject as? UrlPhotoCoreData {
            cell.configure(with: OnePhotoCoreData )
        }
        return cell
    }
    
}
