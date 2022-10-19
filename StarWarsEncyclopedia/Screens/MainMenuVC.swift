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
        view.backgroundColor = Colors.backgroundColor
        configureNavigationController()
        configureLogoImageView()
        configureStackView()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Colors.backgroundColor
    }
    
    private func configureLogoImageView() {
        
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "SWLogo1")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureStackView(){
        
        var offset = 75.0
        
        for tab in MainMenuTab.allCases {
            
            let stackView = MainMenuLabelStackView(tab: tab)
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.delegate = self
            
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

extension MainMenuVC : MainMenuDelegate {
    func didTap(for tab: MainMenuTab) {
        switch tab {
        case .films:
            navigationController?.pushViewController(FilmListVC(), animated: true)
        case .people:
            navigationController?.pushViewController(PeopleListVC(), animated: true)
        case .planets:
            print("planets")
        case .species:
            print("species")
        case .vehicles:
            print("vehicles")
        case .starship:
            print("starship")
        }
    }
    
    
}

