//
//  DataLoadingView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 19/10/22.
//

import UIKit

class DataLoadingView: UIView {

    var containerView : UIView!
    
    func showLoadingView(){
        containerView = UIView(frame: bounds)
        containerView.backgroundColor = Colors.backgroundColor
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

    func dismissLoadingView(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
