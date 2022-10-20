//
//  PeopleCellView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 19/10/22.
//

import UIKit

class PeopleCellView: UITableViewCell {
    static let reuseID = "PeopleCell"
    var nameLabel = UILabel()
    var avatarImageView = UIImageView()
    var chevronImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        accessoryType = .disclosureIndicator
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubviews([nameLabel, avatarImageView, chevronImageView])
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.clipsToBounds = true
        chevronImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
        
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func set(people: People) {
        if let image = UIImage(named: people.name){
            avatarImageView.image = image
        }else{
            avatarImageView.image = UIImage(named: "placeholderAvatar")
            avatarImageView.layer.cornerRadius = 25
            avatarImageView.clipsToBounds = true
        }
        nameLabel.text = people.name
    }
}
