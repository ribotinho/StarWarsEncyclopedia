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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, systemImage: String) {
        self.init(frame: .zero)
        label.text = text
        imageView.image = UIImage(systemName: systemImage)
    }
    
    private func configure(){
        axis = .horizontal
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        
        DispatchQueue.main.async {
            self.addGestureRecognizer(tapGesture)
        }
        
        layer.borderColor = UIColor.yellow.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        configureImageView()
        configureTextField()
        configureChevronImageView()
    }
    
    private func configureImageView(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .yellow
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
        label.textColor = .white
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureChevronImageView() {
        addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = .yellow
        chevronImageView.clipsToBounds = true
        chevronImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer? = nil) {
        print("tapped \(label.text)")
    }

}
