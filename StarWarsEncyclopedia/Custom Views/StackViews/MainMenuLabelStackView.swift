//
//  MainMenuLabelStackView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class MainMenuLabelStackView: UIStackView {

    let label = UILabel()
    let imageView = UIImageView()
    let chevronImageView = UIImageView()
    var tab : MainMenuTab?
    var delegate : MainMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(tab: MainMenuTab) {
        self.init(frame: .zero)
        self.tab = tab
        label.text = tab.displayName()
        imageView.image = UIImage(systemName: tab.rawValue)
    }
    
    private func configure(){
        axis = .horizontal
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        
        DispatchQueue.main.async {
            self.addGestureRecognizer(tapGesture)
        }
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        
        configureImageView()
        configureTextField()
        configureChevronImageView()
    }
    
    private func configureImageView(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureTextField(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.tangoSansRegular.rawValue, size: 16.0)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureChevronImageView() {
        addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.clipsToBounds = true
        chevronImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer? = nil) {
        guard let tab = tab else { return }
        delegate?.didTap(for: tab)
    }
}

protocol MainMenuDelegate {
    func didTap(for tab: MainMenuTab)
}
