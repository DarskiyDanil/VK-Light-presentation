//
//  String + heidht.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 25.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

// для вычисления высоты по наполненности текстом

extension String {
    
    func heidht(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
    
}
