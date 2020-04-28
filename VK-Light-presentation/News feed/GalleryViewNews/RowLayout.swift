//
//  RowLayout.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 27.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath IndexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    
    weak var delegate: RowLayoutDelegate!
    
    static var numbersOfRows = 2
    fileprivate var cellPadding: CGFloat = 4
    //    кеш вычисляемых атрибутов
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    //
    fileprivate var contentWidth: CGFloat = 0
    //     константа
    fileprivate var contentHeigth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeigth)
    }
    
    override func prepare() {
//        обнуление размеров
        contentWidth = 0
//        очистка кеш
        cache = []
        guard cache.isEmpty == true, let collectionView = collectionView else {return}
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath =  IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superViewWidth = collectionView.frame.width
        
//        фиксированная высота для каждого столбца
        guard var rowHeight = RowLayout.rowHeightCounter(superViewWidth: superViewWidth, photosArray: photos) else {return}
        
        rowHeight = rowHeight / CGFloat(RowLayout.numbersOfRows)
        
        let photosRatios = photos.map {$0.height / $0.width}
        
//        координаты но Y
        var yOffset = [CGFloat]()
        for row in 0 ..< RowLayout.numbersOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        
        //        координаты но X
        var xOffset = [CGFloat](repeating: 0, count: RowLayout.numbersOfRows)
        
        var row = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let ratio = photosRatios[indexPath.row]
//            соотношение сторон для каждой картинки
            let width = (rowHeight / ratio)
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            row = row < (RowLayout.numbersOfRows - 1) ? (row + 1) : 0
        }
    }
    
    static func rowHeightCounter (superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        let photoWithMinRatio = photosArray.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        
        guard let myPhotoWithMinRatio = photoWithMinRatio else {return nil}
        let difference = superViewWidth / myPhotoWithMinRatio.width
        
        rowHeight = myPhotoWithMinRatio.height * difference
        rowHeight = rowHeight * CGFloat(RowLayout.numbersOfRows)
        
        return rowHeight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    
}













