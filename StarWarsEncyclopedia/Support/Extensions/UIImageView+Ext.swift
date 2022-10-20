//
//  UIImageView+Ext.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 19/10/22.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        layer.masksToBounds = true
        clipsToBounds = true
        layer.cornerRadius = self.frame.height / 2
    }
}
