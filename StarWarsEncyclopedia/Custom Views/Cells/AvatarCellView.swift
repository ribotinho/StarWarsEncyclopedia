//
//  AvatarCellView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 19/10/22.
//

import UIKit

class AvatarCellView: UICollectionViewCell {
    
    static let reuseID = "FilmCell"
    
    var avatarImage = UIImageView()
    var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubviews([avatarImage, nameLabel])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            avatarImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(character: People){
        nameLabel.text = character.name
        if let image = UIImage(named: character.name) {
            avatarImage.image = image
        }else {
            avatarImage.image = UIImage(named: "placeholderAvatar")
        }
        
        
        avatarImage.layer.cornerRadius = 50 // height / 2
        avatarImage.layer.masksToBounds = true
        avatarImage.clipsToBounds = true
    }
    
}
