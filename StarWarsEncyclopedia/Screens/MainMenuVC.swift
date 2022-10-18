//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import UIKit

class MainMenuVC: UIViewController {
    

    let logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureLogoImageView()
        configureStackView()
    }
    
    func configureLogoImageView() {
        
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "SWLogo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureStackView(){
        
        var offset = 75.0
        
        for tab in MainMenuTab.tabs {
            
            let stackView = MainMenuLabelStackView(text: tab.title, systemImage: tab.image)
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: offset),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
                stackView.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            offset += 60.0
        }

    }
    
    
}

