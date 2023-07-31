//
//  UICollectionViewCell+Extension.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 27/7/23.
//

import UIKit

extension UICollectionViewCell {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
