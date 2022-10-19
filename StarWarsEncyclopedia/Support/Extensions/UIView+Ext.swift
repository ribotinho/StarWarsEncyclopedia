//
//  UIView+Ext.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
