//
//  Constants.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 26.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit


struct Constants {
    static let cardInsets = UIEdgeInsets(top: 4, left: 4, bottom: 8, right: 4)
    static let topVewHeight: CGFloat = 50
    static let postLabelInsets = UIEdgeInsets(top: 4 + Constants.topVewHeight + 4, left: 4, bottom: 4, right: 4)
    static let postLabelFont = UIFont.systemFont(ofSize: 14)
    static let bottomViewHeight: CGFloat = 40
    static let bottomViewViewWidth: CGFloat = 80
    static let bottomViewViewsIconSize: CGFloat = 26
    static let minimumLinesCountPostLimit: CGFloat = 8
    static let minimumLinesCountPostPresent: CGFloat = 6
    static let postTextButtonIsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let postTextButtonSize = CGSize(width: 170, height: 25)
}
